# ───────────────────────────── 0) SETUP & LIBRARIES ─────────────────────────────
pkgs <- c(
  "dplyr","readr","ggplot2","irr","broom","emmeans","tidyr","writexl",
  "car","hexbin","scales"
)
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

## Type III sums of squares
options(contrasts = c("contr.sum","contr.poly"))

## Helper: normalize sex to a single encoding used EVERYWHERE (Female/Male)
normalize_sex <- function(x) {
  x <- tolower(trimws(as.character(x)))
  out <- ifelse(x %in% c("f","female","w","woman","women"), "Female",
                ifelse(x %in% c("m","male","man","men"), "Male", NA_character_))
  factor(out, levels = c("Female","Male"))
}

# ───────────────────────────── 1) PATHS & INPUTS ─────────────────────────────
base_dir <- "/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset QDiabetes vs HH_Diabetes/QDiabetes Data"
if (!dir.exists(base_dir)) stop("Directory doesn’t exist: ", base_dir)
setwd(base_dir)

models <- c("A","B","C")
file_template <- function(m) sprintf("synthetic_qdiabetes_with_risk%s_and_HH.csv.gz", m)

# Columns convention in each per-model CSV:
#   risk_<M>_f, risk_<M>_m, HH_risk_<M>_f, HH_risk_<M>_m, sex, age, (optional) patient_id

extract_risks <- function(df, m) {
  qf <- paste0("risk_", m, "_f"); qm <- paste0("risk_", m, "_m")
  hf <- paste0("HH_risk_", m, "_f"); hm <- paste0("HH_risk_", m, "_m")
  
  if (!all(c(qf,qm,hf,hm,"sex","age") %in% names(df))) {
    stop("Required columns missing for model ", m,
         ". Expected: ", paste(c(qf,qm,hf,hm,"sex","age"), collapse=", "))
  }
  
  df %>%
    mutate(
      sex     = normalize_sex(sex),
      patient_id = if (!"patient_id" %in% names(df)) row_number() else patient_id,
      QD_risk = if_else(sex == "Female", .data[[qf]], .data[[qm]]),
      HH_risk = if_else(sex == "Female", .data[[hf]], .data[[hm]])
    ) %>%
    select(patient_id, sex, age, QD_risk, HH_risk)
}

# For pretty BA y-axis zoom, find the largest |QD−HH| across all models
suppressMessages({
  global_max_diff <- models %>%
    lapply(function(m) {
      readr::read_csv(file_template(m), show_col_types = FALSE) %>%
        extract_risks(m) %>%
        transmute(diff = QD_risk - HH_risk) %>%
        summarise(mx = max(abs(diff), na.rm = TRUE)) %>%
        pull(mx)
    }) %>% unlist() %>% max(na.rm = TRUE) %>% ceiling()
})
y_limits <- c(-global_max_diff, global_max_diff)

# ───────────────────────────── 2) LOOP OVER MODELS ─────────────────────────────
all_stats  <- tibble::tibble()
ba_summary <- tibble::tibble(Model=character(), Bias=numeric(), MeanAbsDiff=numeric(),
                             LoA_Lower=numeric(), LoA_Upper=numeric())
table7_all <- NULL

for (m in models) {
  message("\n--- Processing Model ", m, " ---")
  
  # 2a) Read + normalize + extract risks
  sim <- readr::read_csv(file_template(m), show_col_types = FALSE) %>%
    mutate(sex = normalize_sex(sex))
  risk_data <- extract_risks(sim, m)
  
  # quick sanity checks
  stopifnot(all(!is.na(risk_data$QD_risk)), all(!is.na(risk_data$HH_risk)))
  if (sd(risk_data$QD_risk) == 0 || sd(risk_data$HH_risk) == 0)
    stop("Constant risk column for Model ", m)
  
  # quick linear fit (diagnostic)
  fit_lm <- lm(HH_risk ~ QD_risk, data = risk_data)
  message("LM: intercept=", round(coef(fit_lm)[1],2),
          " slope=", round(coef(fit_lm)[2],2),
          " R2=", round(summary(fit_lm)$r.squared,3))
  
  # 2b) Agreement metrics
  pearson_val  <- cor(risk_data$QD_risk, risk_data$HH_risk)
  spearman_val <- cor(risk_data$QD_risk, risk_data$HH_risk, method="spearman")
  icc_obj      <- irr::icc(risk_data[, c("QD_risk","HH_risk")], model="twoway", type="agreement")
  
  summary_stats <- tibble::tibble(
    Model    = m,
    Pearson  = round(pearson_val, 3),
    Spearman = round(spearman_val, 3),
    ICC      = round(icc_obj$value, 3),
    ICC_Interp = icc_obj$interpretation
  )
  all_stats <- bind_rows(all_stats, summary_stats)
  
  # 2c) Bland–Altman (overall)
  ba <- risk_data %>%
    mutate(BA_mean = (QD_risk + HH_risk)/2,
           BA_diff = QD_risk - HH_risk,
           ABS_diff= abs(BA_diff),
           sex     = normalize_sex(sex),
           age     = as.numeric(age))
  
  m_diff <- mean(ba$BA_diff)
  sd_diff<- sd(ba$BA_diff)
  loa_lo <- m_diff - 1.96*sd_diff
  loa_hi <- m_diff + 1.96*sd_diff
  
  ba_summary <- bind_rows(ba_summary, tibble::tibble(
    Model = m,
    Bias = round(m_diff,3),
    MeanAbsDiff = round(mean(ba$ABS_diff),3),
    LoA_Lower = round(loa_lo,3),
    LoA_Upper = round(loa_hi,3)
  ))
  
  p_ba <- ggplot(ba, aes(BA_mean, BA_diff)) +
    geom_point(alpha = 0.3) +
    geom_hline(yintercept = m_diff, color = "blue") +
    geom_hline(yintercept = c(loa_lo, loa_hi), linetype = "dashed", color = "red") +
    geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE, color = "green") +
    scale_x_continuous(breaks = seq(0,100,20), labels = scales::label_number(accuracy=1)) +
    scale_y_continuous(breaks = seq(y_limits[1], y_limits[2], by = 20),
                       labels = scales::label_number(accuracy=1)) +
    coord_cartesian(xlim = c(0,100), ylim = y_limits) +
    labs(title = paste0("Bland–Altman: Model ", m),
         x = "Mean Risk (%)", y = "Difference (QD – HH, %)") +
    theme_minimal()
  ggsave(paste0("BA_Model_", m, ".png"), plot = p_ba, width = 7, height = 5, dpi = 300)
  
  # 2d) BA by sex
  ba_by_sex_tbl <- dplyr::bind_rows(lapply(levels(ba$sex), function(sx) {
    sub <- dplyr::filter(ba, sex == sx)
    md  <- mean(sub$BA_diff); sdv <- sd(sub$BA_diff)
    lo  <- md - 1.96*sdv;     hi  <- md + 1.96*sdv
    
    p <- ggplot(sub, aes(BA_mean, BA_diff)) +
      geom_point(alpha = 0.25) +
      geom_hline(yintercept = md, color = "blue") +
      geom_hline(yintercept = c(lo,hi), linetype = "dashed", color = "red") +
      geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE) +
      coord_cartesian(xlim = c(0,100), ylim = y_limits) +
      labs(title = sprintf("Bland–Altman: Model %s (%s)", m, sx),
           x = "Mean Risk (%)", y = "Difference (QD – HH, %)") +
      theme_minimal()
    ggsave(sprintf("BA_Model_%s_%s.png", m, tolower(sx)), p, width = 7, height = 5, dpi = 300)
    
    tibble::tibble(Model=m, Group=paste0("Sex: ", sx),
                   Bias=md, MeanAbsDiff=mean(abs(sub$BA_diff)),
                   LoA_Lower=lo, LoA_Upper=hi)
  }))
  
  # 2e) BA by age bands
  
  # Use ASCII labels for filenames; pretty labels for plot titles
  age_breaks  <- c(18, 45, 65, Inf)
  age_labels  <- c("18–44", "45–64", "65+")
  file_labels <- c("18-44", "45-64", "65plus")
  names(file_labels) <- age_labels
  
  ba_age <- ba %>%
    mutate(age_group = cut(age, breaks = age_breaks, right = FALSE,
                           labels = age_labels))
  
  # 1) Individual PNG for each age group (with group-specific BA lines)
  for (ag in age_labels) {
    sub <- dplyr::filter(ba_age, age_group == ag)
    if (nrow(sub) == 0) next
    
    md  <- mean(sub$BA_diff, na.rm = TRUE)
    sdv <- sd(sub$BA_diff,   na.rm = TRUE)
    lo  <- md - 1.96 * sdv
    hi  <- md + 1.96 * sdv
    tag <- file_labels[[ag]]  # safe for filenames
    
    p_ag <- ggplot(sub, aes(BA_mean, BA_diff)) +
      geom_point(alpha = 0.25) +
      geom_hline(yintercept = md, color = "blue") +
      geom_hline(yintercept = c(lo, hi), linetype = "dashed", color = "red") +
      geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE, color = "green") +
      coord_cartesian(xlim = c(0, 100), ylim = y_limits) +
      labs(title = sprintf("Bland–Altman: Model %s — Age %s", m, ag),
           x = "Mean Risk (%)", y = "Difference (QD – HH, %)") +
      theme_minimal()
    
    ggsave(sprintf("BA_Model_%s_age_%s.png", m, tag),
           p_ag, width = 7, height = 5, dpi = 300)
  }
  
  # 2) OPTIONAL: one faceted PNG with all age groups together
  summ_age <- ba_age %>%
    group_by(age_group) %>%
    summarise(md = mean(BA_diff, na.rm = TRUE),
              sdv = sd(BA_diff,   na.rm = TRUE),
              lo = md - 1.96 * sdv,
              hi = md + 1.96 * sdv,
              .groups = "drop")
  
  p_fac <- ggplot(ba_age, aes(BA_mean, BA_diff)) +
    geom_point(alpha = 0.15) +
    geom_smooth(method = "gam", formula = y ~ s(x), se = TRUE, color = "green") +
    geom_hline(data = summ_age, aes(yintercept = md), color = "blue", inherit.aes = FALSE) +
    geom_hline(data = summ_age, aes(yintercept = lo), linetype = "dashed", color = "red", inherit.aes = FALSE) +
    geom_hline(data = summ_age, aes(yintercept = hi), linetype = "dashed", color = "red", inherit.aes = FALSE) +
    coord_cartesian(xlim = c(0, 100), ylim = y_limits) +
    facet_wrap(~ age_group, ncol = 3) +
    labs(title = sprintf("Bland–Altman by Age Group: Model %s", m),
         x = "Mean Risk (%)", y = "Difference (QD – HH, %)") +
    theme_minimal()
  
  ggsave(sprintf("BA_Model_%s_by_age_facets.png", m),
         p_fac, width = 10, height = 4.5, dpi = 300)
  
  
  # 2f) ANCOVA (Type III) with centered covariates
  ba2 <- ba %>%
    mutate(
      sex        = droplevels(normalize_sex(sex)),   # ensure levels are Female/Male
      age_c      = age - 50,
      BA_mean_c  = BA_mean - mean(BA_mean)
    )
  
  fit3   <- lm(BA_diff ~ BA_mean_c + sex * age_c, data = ba2)
  anova3 <- car::Anova(fit3, type = 3)
  anova_tab <- broom::tidy(anova3) %>%
    rename(Term = term, SumSq = sumsq, Df = df, F_value = statistic, Pr_F = p.value)
  ss_res <- anova_tab$SumSq[anova_tab$Term == "Residuals"]
  anova_tab <- anova_tab %>%
    mutate(Eta2_p = if_else(Term == "Residuals", NA_real_, SumSq/(SumSq + ss_res)))
  
  # simple-slopes grid @ mean risk (BA_mean_c = 0)
  grid_ss <- expand.grid(
    age_c     = seq(min(ba2$age_c), max(ba2$age_c), length.out = 200),
    sex       = levels(ba2$sex),   # Female, Male
    BA_mean_c = 0
  )
  grid_ss$sex <- factor(grid_ss$sex, levels = levels(ba2$sex))
  preds <- predict(fit3, newdata = grid_ss, se.fit = TRUE)
  grid_ss <- grid_ss %>%
    mutate(age = age_c + 50, fit = preds$fit, se = preds$se.fit,
           upr = fit + 1.96*se, lwr = fit - 1.96*se)
  
  p_slopes <- ggplot(grid_ss, aes(age, fit, color = sex, fill = sex)) +
    geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.2, color = NA) +
    geom_line(linewidth = 1) +
    labs(title = sprintf("Simple-Slopes: Model %s BA Bias vs Age by Sex", m),
         x = "Age (years)", y = "Predicted Bias (QD − HH, %)") +
    theme_minimal() + theme(legend.position = "bottom")
  ggsave(sprintf("simple_slopes_Model_%s.png", m), p_slopes, width = 7, height = 5, dpi = 300)
  
  # emmeans at 50y & trends
  emm50    <- emmeans::emmeans(fit3, ~ sex, at = list(age_c = 0, BA_mean_c = 0))
  trends   <- emmeans::emtrends(fit3, ~ sex, var = "age_c", at = list(BA_mean_c = 0))
  emm_df   <- as.data.frame(emm50)
  trend_df <- as.data.frame(trends)
  p_int    <- anova_tab$Pr_F[anova_tab$Term == "sex:age_c"]
  
  # Table 7 row for this model
  tab7_row <- tibble::tibble(
    Model                              = m,
    `Bias @ 50 y — Female (%)`         = round(emm_df$emmean[emm_df$sex=="Female"], 2),
    `Bias @ 50 y — Male (%)`           = round(emm_df$emmean[emm_df$sex=="Male"],   2),
    `Δ Bias per year — Female (%/yr)`  = round(trend_df$age_c.trend[trend_df$sex=="Female"], 3),
    `Δ Bias per year — Male (%/yr)`    = round(trend_df$age_c.trend[trend_df$sex=="Male"],   3),
    `Sex × Age p (Type III)`           = ifelse(is.na(p_int), NA_character_,
                                                ifelse(p_int < 0.001, "< 0.001", sprintf("%.3f", p_int))),
    `95% LoA (%)`                      = sprintf("%+.1f to %+.1f", loa_lo, loa_hi)
  )
  table7_all <- if (is.null(table7_all)) tab7_row else bind_rows(table7_all, tab7_row)
  
  # 2g) Save per-model workbook
  writexl::write_xlsx(
    list(
      Correlations      = summary_stats,
      BlandAltman_All   = tibble::tibble(Bias = m_diff, MeanAbsDiff = mean(ba$ABS_diff),
                                         LoA_Lower = loa_lo, LoA_Upper = loa_hi),
      BA_Subgroups      = bind_rows(ba_by_sex_tbl, ba_by_age_tbl),
      ANCOVA_TypeIII    = anova_tab,
      AdjMeans_Sex_50y  = tibble::as_tibble(emm_df),
      Age_Trends_bySex  = tibble::as_tibble(trend_df),
      Table7_Row        = tab7_row
    ),
    path = sprintf("QD_HH_Summary_Model_%s.xlsx", m)
  )
  
  # 2h) Scatter QD vs HH
  p_sc <- ggplot(risk_data, aes(QD_risk, HH_risk)) +
    geom_point(alpha=0.3) +
    geom_abline(slope=1, intercept=0, linetype="dashed", color="blue") +
    scale_x_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
    scale_y_continuous(limits = c(0,100), breaks = seq(0,100,20)) +
    labs(title = paste0("Scatter QD vs HH: Model ", m),
         x = "QD Risk (%)", y = "HH Risk (%)") +
    theme_minimal()
  ggsave(paste0("Scatter_Model_", m, ".png"), p_sc, width = 6, height = 4, dpi = 300)
}

# ───────────────────────────── 3) OVERALL OUTPUTS ─────────────────────────────
writexl::write_xlsx(
  list(
    Correlations_ICC = all_stats,
    Bland_Altman     = ba_summary,
    Table7_AllModels = table7_all
  ),
  path = "QD_HH_All_Models_with_BA.xlsx"
)

message("\n✅ All models A, B, C processed. Outputs written (plots + Excel).")


