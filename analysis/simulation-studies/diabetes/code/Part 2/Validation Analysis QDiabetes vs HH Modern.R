# ───────────────────────────── 0. SETUP & LIBRARIES ─────────────────────────────
pkgs <- c("dplyr", "readr", "ggplot2", "irr", "broom", "emmeans",
          "rstatix", "tidyr", "writexl", "hexbin", "scales")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

# ─── 0a. POINT AT YOUR DATA DIRECTORY ───
base_dir <- "/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset QDiabetes vs HH_Diabetes/QDiabetes Data"
stopifnot(dir.exists(base_dir))
setwd(base_dir)

modern_dir   <- file.path(base_dir, "Phase 2 modern")
combined_fn  <- file.path(modern_dir, "synthetic_Phase 2 modern_combined.csv.gz")

if (!file.exists(combined_fn)) stop("Combined file not found: ", combined_fn)

# ───────────────────────────── 1. READ & PREP ─────────────────────────────
dat <- readr::read_csv(combined_fn, show_col_types = FALSE) %>%
  mutate(patient_id = row_number())  # create an id for analysis/plots

# sanity: required columns present?
req_cols <- c(paste0("QD_risk_", c("A","B","C")), paste0("HH_risk_", c("A","B","C")))
missing  <- setdiff(req_cols, names(dat))
if (length(missing)) stop("Missing columns in combined file: ", paste(missing, collapse=", "))

models <- c("A","B","C")

# helper to extract per-model paired risks
extract_risks <- function(df, m) {
  qcol <- paste0("QD_risk_", m)
  hcol <- paste0("HH_risk_", m)
  df %>% transmute(
    patient_id,
    sex,
    age,
    QD_risk = .data[[qcol]],
    HH_risk = .data[[hcol]]
  )
}

# compute a symmetric y-limit for BA plots across ALL models (nice axes)
global_max_diff <- models %>%
  lapply(function(m) {
    d <- extract_risks(dat, m)
    max(abs(d$QD_risk - d$HH_risk), na.rm = TRUE)
  }) %>%
  unlist() %>%
  max(na.rm = TRUE) %>%
  ceiling()
y_limits <- c(-global_max_diff, global_max_diff)

# ───────────────────────────── 2. LOOP OVER MODELS ─────────────────────────────
all_stats  <- tibble::tibble()
ba_summary <- tibble::tibble(
  Model       = character(),
  Bias        = numeric(),
  MeanAbsDiff = numeric(),
  LoA_Lower   = numeric(),
  LoA_Upper   = numeric()
)

for (m in models) {
  message("\n--- Processing Model ", m, " ---")
  
  # 2a. Data for this model
  risk_data <- extract_risks(dat, m)
  
  # quick sanity
  stopifnot(sum(is.na(risk_data$QD_risk)) == 0,
            sum(is.na(risk_data$HH_risk)) == 0)
  if (sd(risk_data$QD_risk) == 0 || sd(risk_data$HH_risk) == 0) {
    stop("One of the risk columns is constant—cannot compute correlation for Model ", m)
  }
  
  # 2b. Quick LM check
  fit <- lm(HH_risk ~ QD_risk, data = risk_data)
  message("Model ", m, " linear fit: intercept=", round(coef(fit)[1],2),
          "; slope=", round(coef(fit)[2],2),
          "; R2=", round(summary(fit)$r.squared,3))
  
  # optional hexbin for large N
  if (nrow(risk_data) > 50000) {
    hb <- hexbin::hexbin(risk_data$QD_risk, risk_data$HH_risk, xbins=50)
    print(plot(hb))
  }
  
  # decile-wise correlations (diagnostic)
  qs <- quantile(risk_data$QD_risk, probs = seq(0,1,0.1), na.rm = TRUE)
  for (i in seq_len(length(qs)-1)) {
    sub <- dplyr::filter(risk_data, QD_risk >= qs[i], QD_risk <= qs[i+1])
    if (nrow(sub) > 1) {
      message("Decile ", i, ": n=", nrow(sub),
              "  r=", round(cor(sub$QD_risk, sub$HH_risk),3))
    }
  }
  
  # by-sex diagnostics
  for (g in unique(risk_data$sex)) {
    sub <- dplyr::filter(risk_data, sex==g)
    if (nrow(sub) > 1) {
      message("Sex=", g, ": r=", round(cor(sub$QD_risk, sub$HH_risk),3),
              "; bias=", round(mean(sub$QD_risk - sub$HH_risk),2))
    }
  }
  
  # 2c. Correlations & ICC
  pearson_val  <- cor(risk_data$QD_risk, risk_data$HH_risk, use = "complete.obs")
  spearman_val <- cor(risk_data$QD_risk, risk_data$HH_risk, method = "spearman", use = "complete.obs")
  icc_obj      <- irr::icc(risk_data[, c("QD_risk","HH_risk")], model = "twoway", type = "agreement")
  
  summary_stats <- tibble::tibble(
    Model    = m,
    Pearson  = round(pearson_val, 3),
    Spearman = round(spearman_val, 3),
    ICC      = round(icc_obj$value, 3),
    ICC_Interp = icc_obj$interpretation
  )
  all_stats <- bind_rows(all_stats, summary_stats)
  
  # 2d. Bland–Altman
  ba <- risk_data %>% mutate(
    BA_mean = (QD_risk + HH_risk) / 2,
    BA_diff = QD_risk - HH_risk,
    ABS_diff= abs(BA_diff)
  )
  m_diff <- mean(ba$BA_diff, na.rm=TRUE)
  sd_diff<- sd(ba$BA_diff,   na.rm=TRUE)
  loa_lo <- m_diff - 1.96 * sd_diff
  loa_hi <- m_diff + 1.96 * sd_diff
  
  ba_summary <- bind_rows(ba_summary,
                          tibble::tibble(
                            Model       = m,
                            Bias        = round(m_diff, 3),
                            MeanAbsDiff = round(mean(ba$ABS_diff, na.rm=TRUE), 3),
                            LoA_Lower   = round(loa_lo, 3),
                            LoA_Upper   = round(loa_hi, 3)
                          ))
  
  p_ba <- ggplot(ba, aes(BA_mean, BA_diff)) +
    geom_point(alpha = 0.3) +
    geom_hline(yintercept = m_diff, color = "blue") +
    geom_hline(yintercept = loa_hi, linetype = "dashed", color = "red") +
    geom_hline(yintercept = loa_lo, linetype = "dashed", color = "red") +
    geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE, color = "green") +
    scale_x_continuous(breaks = seq(0, 100, 20), labels = scales::label_number(accuracy = 1)) +
    scale_y_continuous(breaks = seq(-global_max_diff, global_max_diff, by = 20),
                       labels = scales::label_number(accuracy = 1)) +
    coord_cartesian(xlim = c(0, 100), ylim = y_limits) +
    labs(title = paste0("Bland–Altman: Model ", m),
         x = "Mean Risk (%)",
         y = "Difference (QD – HH, %)") +
    theme_minimal()
  ggsave(file.path(modern_dir, paste0("BA_Model_", m, ".png")), plot = p_ba, width = 7, height = 5, dpi = 300)
  
  # --- helper to make a BA plot (per subset) with its own LoA
  make_ba_plot <- function(df, title, y_limits) {
    m  <- mean(df$BA_diff, na.rm = TRUE)
    sd <- sd(df$BA_diff,   na.rm = TRUE)
    lo <- m - 1.96 * sd
    hi <- m + 1.96 * sd
    
    ggplot(df, aes(BA_mean, BA_diff)) +
      geom_point(alpha = 0.3) +
      geom_hline(yintercept = m,  color = "blue") +
      geom_hline(yintercept = lo, linetype = "dashed", color = "red") +
      geom_hline(yintercept = hi, linetype = "dashed", color = "red") +
      geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE, color = "green") +
      scale_x_continuous(breaks = seq(0, 100, 20), labels = scales::label_number(accuracy = 1)) +
      scale_y_continuous(breaks = seq(y_limits[1], y_limits[2], by = 20),
                         labels = scales::label_number(accuracy = 1)) +
      coord_cartesian(xlim = c(0, 100), ylim = y_limits) +
      labs(title = title, x = "Mean Risk (%)", y = "Difference (QD – HH, %)") +
      theme_minimal()
  }
  
  # ===================== BA by SEX =====================
  ba_sex <- ba %>% mutate(sex = factor(sex))
  for (g in levels(ba_sex$sex)) {
    sub <- dplyr::filter(ba_sex, sex == g)
    p   <- make_ba_plot(sub, sprintf("Bland–Altman: Model %s (%s)", m, g), y_limits)
    ggsave(file.path(modern_dir, sprintf("BA_Model_%s_bySex_%s.png", m, g)),
           p, width = 7, height = 5, dpi = 300)
  }
  
  # ===================== BA by AGE GROUP =====================
  ba_age <- ba %>%
    mutate(age_group = cut(
      as.numeric(age),
      breaks = c(18, 45, 65, Inf), right = FALSE,
      labels = c("18–44", "45–64", "65+")
    ))
  
  for (ag in levels(ba_age$age_group)) {
    sub <- dplyr::filter(ba_age, age_group == ag)
    p   <- make_ba_plot(sub, sprintf("Bland–Altman: Model %s (Age %s)", m, ag), y_limits)
    # sanitize label for filename
    ag_safe <- gsub("[^0-9A-Za-z]+", "_", ag)
    ggsave(file.path(modern_dir, sprintf("BA_Model_%s_byAge_%s.png", m, ag_safe)),
           p, width = 7, height = 5, dpi = 300)
  }
  
  
  # 2e. ANCOVA on BA differences  —— Type III, with centering  (Option A: manual partial eta^2)
  ba2 <- ba %>%
    dplyr::mutate(
      sex       = factor(sex),
      age_c     = as.numeric(age) - 50,                  # center age at 50 y
      BA_mean_c = BA_mean - mean(BA_mean, na.rm = TRUE)  # center mean risk
    )
  
  # fit with interaction; use lm + sum-to-zero contrasts for Type III
  # (make sure you set once near the top of the script:
  #   options(contrasts = c("contr.sum", "contr.poly")) )
  fit <- lm(BA_diff ~ BA_mean_c + sex * age_c, data = ba2)
  
  # Type III ANCOVA (car::Anova) + tidy
  anova_tab <- car::Anova(fit, type = 3) %>%
    broom::tidy() %>%
    dplyr::rename(Term = term, SumSq = sumsq, Df = df, F_value = statistic, Pr_F = p.value)
  
  # ---- Manual partial eta^2 aligned to the Type III table ----
  ss_res <- anova_tab$SumSq[anova_tab$Term == "Residuals"]
  if (length(ss_res) == 0 || is.na(ss_res)) {
    # fallback: compute residual SS directly from the model
    ss_res <- sum(residuals(fit)^2, na.rm = TRUE)
  }
  anova_tab <- anova_tab %>%
    dplyr::mutate(
      Eta2_p = dplyr::if_else(
        Term %in% c("Residuals", "(Intercept)"),
        NA_real_,
        SumSq / (SumSq + ss_res)  # partial eta squared
      )
    )
  # ------------------------------------------------------------
  
  # simple-slopes plot at average risk (BA_mean_c = 0)
  grid_ss <- expand.grid(
    age_c     = seq(min(ba2$age_c, na.rm = TRUE), max(ba2$age_c, na.rm = TRUE), length.out = 200),
    sex       = levels(ba2$sex),
    BA_mean_c = 0
  )
  preds   <- predict(fit, newdata = grid_ss, se.fit = TRUE)
  grid_ss <- grid_ss %>%
    dplyr::mutate(
      age = age_c + 50,                 # back-transform for axis label
      fit = preds$fit, se = preds$se.fit,
      upr = fit + 1.96 * se, lwr = fit - 1.96 * se
    )
  
  p_slopes <- ggplot(grid_ss, aes(age, fit, color = sex, fill = sex)) +
    geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.2, color = NA) +
    geom_line(linewidth = 1) +
    labs(
      title = sprintf("Simple-Slopes: Model %s BA Bias vs Age by Sex", m),
      x = "Age (years)", y = "Predicted Bias (QD − HH, %)"
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  ggsave(file.path(modern_dir, sprintf("simple_slopes_Model_%s.png", m)),
         p_slopes, width = 7, height = 5, dpi = 300)
  
  # Adjusted means & slopes for tables
  emm50    <- emmeans(fit, ~ sex, at = list(age_c = 0, BA_mean_c = 0))      # bias @ 50 y
  adjmeans <- broom::tidy(emm50)
  
  slopes   <- emtrends(fit, ~ sex, var = "age_c", at = list(BA_mean_c = 0))
  trends   <- broom::tidy(slopes)
  
  # Age bands (unchanged)
  ba_band <- ba2 %>%
    dplyr::mutate(age_group = cut(age_c + 50, breaks = c(18, 45, 65, Inf),
                                  right = FALSE, labels = c("18–44", "45–64", "65+"))) %>%
    dplyr::group_by(age_group) %>%
    dplyr::summarise(
      N           = dplyr::n(),
      Bias        = mean(BA_diff, na.rm = TRUE),
      MeanAbsDiff = mean(abs(BA_diff), na.rm = TRUE),
      LoA_Lower   = Bias - 1.96 * sd(BA_diff, na.rm = TRUE),
      LoA_Upper   = Bias + 1.96 * sd(BA_diff, na.rm = TRUE),
      .groups = "drop"
    )
  
  # Export per-model tables
  writexl::write_xlsx(
    list(
      Correlations    = summary_stats,
      ANCOVA          = anova_tab,
      Simple_Slopes   = grid_ss,
      AdjMeans_Sex    = adjmeans,
      Sex_Contrasts   = broom::tidy(pairs(emm50, adjust = "bonferroni")),
      Age_Trends      = trends,
      Age_Bands       = ba_band
    ),
    path = file.path(modern_dir, sprintf("QD_HH_Summary_Model_%s.xlsx", m))
  )
  
  
  # 2f. Scatter QD vs HH
  p_sc <- ggplot(risk_data, aes(QD_risk, HH_risk)) +
    geom_point(alpha=0.3) +
    geom_abline(slope=1, intercept=0, linetype="dashed", color="blue") +
    scale_x_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
    scale_y_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
    labs(title = paste0("Scatter QD vs HH: Model ", m),
         x = "QD Risk (%)", y = "HH Risk (%)") +
    theme_minimal()
  ggsave(file.path(modern_dir, paste0("Scatter_Model_", m, ".png")),
         p_sc, width = 6, height = 4, dpi = 300)
}

# ───────────────────────────── 3. OVERALL SUMMARY ─────────────────────────────
writexl::write_xlsx(
  list(
    Correlations_ICC = all_stats,
    Bland_Altman     = ba_summary
  ),
  path = file.path(modern_dir, "Modern_QD_HH_All_Models_with_BA.xlsx")
)
message("\n✅ All models A, B, C processed and combined summary saved in 'Phase 2 modern'.")
