# ----------------------------------------------------------------
# 1. Install & load packages
# ----------------------------------------------------------------

pkgs <- c("dplyr", "readxl", "ggplot2", "writexl", "broom", "psych", "irr", "mgcv", "scales")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

if (!requireNamespace("car", quietly = TRUE))    install.packages("car")
if (!requireNamespace("emmeans", quietly = TRUE)) install.packages("emmeans")
if (!requireNamespace("rstatix", quietly = TRUE)) install.packages("rstatix")
library(car)
library(emmeans)
library(rstatix)

# ----------------------------------------------------------------
# 2. Read final simulated dataset
# ----------------------------------------------------------------

sim_data <- readxl::read_excel(file.path("simulation_dataset_final_HH_DemPoRT.xlsx"))

# ----------------------------------------------------------------
# 3a. Build comparison table
# ----------------------------------------------------------------

# Set Type-III ANCOVA-friendly contrasts (sum-to-zero for factors)
old_contr <- options(contrasts = c("contr.sum", "contr.poly"))

risk_data <- sim_data %>%
  dplyr::select(Sex, Age, DemPoRT_Risk5yr, HH_CIR) %>%
  filter(Age >= 55) %>%
  mutate(
    Age_grp = cut(
      Age,
      breaks = c(55, 70, 80, Inf),
      labels = c("55–69", "70–79", "80+"),
      right  = FALSE
    ),
    BA_Mean = (DemPoRT_Risk5yr + HH_CIR) / 2,
    BA_Diff = DemPoRT_Risk5yr - HH_CIR,
    ABS_Diff = abs(BA_Diff)
  )
# Center Age so that Type III tests for Sex are at the average age
risk_data <- risk_data %>%
  mutate(Age_c = Age - mean(Age, na.rm = TRUE))

# ----------------------------------------------------------------
# 3b. Bland–Altman summary statistics
# ----------------------------------------------------------------

# Core quantities
d  <- risk_data$BA_Diff
n  <- sum(!is.na(d))
m  <- mean(d, na.rm = TRUE)
s  <- sd(d, na.rm = TRUE)
mad_overall <- mean(abs(d), na.rm = TRUE)
tcrit <- qt(0.975, df = n - 1)

# Bias CI
bias_ci_lower <- m - tcrit * s / sqrt(n)
bias_ci_upper <- m + tcrit * s / sqrt(n)

# Limits of Agreement (LoA)
loa_lower <- m - 1.96 * s
loa_upper <- m + 1.96 * s
loa_width <- loa_upper - loa_lower

# SE for LoA and their CIs (Bland & Altman, 1999)
se_loa <- s * sqrt(1/n + (1.96^2) / (2 * (n - 1)))
loa_lower_ci_lower <- loa_lower - tcrit * se_loa
loa_lower_ci_upper <- loa_lower + tcrit * se_loa
loa_upper_ci_lower <- loa_upper - tcrit * se_loa
loa_upper_ci_upper <- loa_upper + tcrit * se_loa

# Keep your original BA_stats (now with Mean_Abs_Diff) for continuity
BA_stats <- tibble::tibble(
  Model         = "DemPoRT_vs_HH",
  n             = n,
  Mean_Diff     = m,
  SD_Diff       = s,
  Mean_Abs_Diff = mad_overall,
  LoA_Lower     = loa_lower,
  LoA_Upper     = loa_upper
) %>%
  mutate(across(where(is.numeric), ~ round(.x, 3)))

# Minimal Table A2 (what journals typically expect)
BA_table_A2 <- tibble::tibble(
  n         = n,
  Mean_Bias = m,
  SD_Diff   = s,
  LoA_Lower = loa_lower,
  LoA_Upper = loa_upper
) %>% mutate(across(where(is.numeric), ~ round(.x, 3)))

# Extended BA table with CIs and extras (nice for supplement)
BA_table_A2_extended <- tibble::tibble(
  n               = n,
  Mean_Bias       = m,
  SD_Diff         = s,
  MAD             = mad_overall,
  LoA_Lower       = loa_lower,
  LoA_Upper       = loa_upper,
  LoA_Width       = loa_width,
  Bias_CI_Lower   = bias_ci_lower,
  Bias_CI_Upper   = bias_ci_upper,
  LoA_Lower_CI_L  = loa_lower_ci_lower,
  LoA_Lower_CI_U  = loa_lower_ci_upper,
  LoA_Upper_CI_L  = loa_upper_ci_lower,
  LoA_Upper_CI_U  = loa_upper_ci_upper
) %>% mutate(across(where(is.numeric), ~ round(.x, 3)))

# Proportional-bias test: Diff ~ Mean
prop_bias_lm   <- lm(BA_Diff ~ BA_Mean, data = risk_data)
prop_bias_tidy <- broom::tidy(prop_bias_lm) %>%
  mutate(across(where(is.numeric), ~ round(.x, 3)))
prop_bias_glance <- broom::glance(prop_bias_lm) %>%
  mutate(across(where(is.numeric), ~ round(.x, 3)))

# ----------------------------------------------------------------
# 4. Overall correlations & ICC
# ----------------------------------------------------------------

pearson_test  <- cor.test(risk_data$DemPoRT_Risk5yr,
                          risk_data$HH_CIR,
                          method = "pearson",
                          use    = "complete.obs")
spearman_test <- cor.test(risk_data$DemPoRT_Risk5yr,
                          risk_data$HH_CIR,
                          method = "spearman",
                          use    = "complete.obs")
icc_res       <- irr::icc(risk_data[,c("DemPoRT_Risk5yr","HH_CIR")],
                          model = "twoway",
                          type  = "agreement",
                          unit  = "single")

pearson_cor  <- pearson_test$estimate
pearson_p    <- pearson_test$p.value
spearman_cor <- spearman_test$estimate
spearman_p   <- spearman_test$p.value
icc_value    <- icc_res$value
icc_p        <- icc_res$p.value  # available when unit="single"
icc_int      <- icc_res$interpretation

message(
  sprintf(
    "Pearson: %.3f (p = %s) | Spearman: %.3f (p = %s) | ICC: %.3f (p %s, %s)",
    pearson_cor,
    # format Pearson p-value as "<0.001" or "0.023"
    ifelse(pearson_p  < 0.001,
           "<0.001",
           sprintf("%.3f", pearson_p)),
    spearman_cor,
    # same for Spearman
    ifelse(spearman_p < 0.001,
           "<0.001",
           sprintf("%.3f", spearman_p)),
    icc_value,
    # your existing ICC formatting
    ifelse(icc_p < 0.001,
           "<0.001",
           sprintf("= %.3f", icc_p)),
    icc_int
  )
)

# ----------------------------------------------------------------
# 5a. Scatterplot
# ----------------------------------------------------------------

library(scales)
library(ggplot2)

theme_set(
  theme_minimal(base_size = 10) +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      axis.title = element_text(size = 12),
      axis.text  = element_text(size = 10),
      strip.text = element_text(size = 12)
    )
)

p_scatter <- ggplot(risk_data, aes(x = DemPoRT_Risk5yr,
                                   y = HH_CIR)) +
  geom_point(alpha = 0.3) +
  # identity line, dashed and blue
  geom_abline(slope = 1, intercept = 0,
              linetype = "dashed",
              color    = "blue",
              linewidth= 0.7) +
  scale_x_continuous(
    name   = "DemPoRT Risk (%)",
    limits = c(0, 0.8),
    breaks = seq(0, 0.8, 0.2),
    labels = percent_format(accuracy = 1),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name   = "HH Risk (%)",
    limits = c(0, 0.8),
    breaks = seq(0, 0.8, 0.2),
    labels = percent_format(accuracy = 1),
    expand = c(0, 0)
  ) +
  labs(title = "Scatter DemPoRT vs HH") +
  theme_minimal()

ggsave("scatter_DemPoRT_vs_HH.png", p_scatter,
       width = 6, height = 4)

# ----------------------------------------------------------------
# 5b. Residual analysis by age
# ----------------------------------------------------------------

p_resid_age <- ggplot(risk_data, aes(x = Age, y = BA_Diff)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Residuals (DemPoRT – HH) vs Age",
    x     = "Age",
    y     = "Difference (DemPoRT – HH)"
  ) +
  theme_minimal()
ggsave("residuals_vs_age.png", p_resid_age, width = 6, height = 4)

# ----------------------------------------------------------------
# 6. Bland-Altman plots
# ----------------------------------------------------------------

bland_altman <- function(data) {
  m         <- mean(data$BA_Diff, na.rm = TRUE)
  s         <- sd(  data$BA_Diff, na.rm = TRUE)
  loa_upper <- m + 1.96 * s
  loa_lower <- m - 1.96 * s
  
  ggplot(data, aes(x = BA_Mean, y = BA_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    geom_hline(yintercept = m,          color = "blue",   linewidth = 0.5) +
    geom_hline(yintercept = loa_upper,  linetype = "dashed", color = "red") +
    geom_hline(yintercept = loa_lower,  linetype = "dashed", color = "red") +
    geom_smooth(
      method    = "gam",
      formula   = y ~ s(x, bs = "cs"),
      se        = TRUE,
      linewidth = 1,
      color     = "green3",
      fill      = "grey80"
    ) +
    coord_cartesian(expand = FALSE) +
    theme_minimal() +
    labs(
      title = "Bland-Altman",
      x     = "Mean Risk (%)",
      y     = "Difference (DemPoRT - HH, %)"
    )
}

plot_strat <- function(var) {
  stats <- risk_data %>%
    group_by(across(all_of(var))) %>%
    summarise(
      m     = mean(BA_Diff, na.rm = TRUE),
      upper = m + 1.96 * sd(BA_Diff, na.rm = TRUE),
      lower = m - 1.96 * sd(BA_Diff, na.rm = TRUE),
      .groups = "drop"
    )
  
  ggplot(risk_data, aes(x = BA_Mean, y = BA_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    geom_hline(data = stats, aes(yintercept = m),     color = "blue",   linewidth = 0.5) +
    geom_hline(data = stats, aes(yintercept = upper), linetype = "dashed", color = "red") +
    geom_hline(data = stats, aes(yintercept = lower), linetype = "dashed", color = "red") +
    geom_smooth(
      method    = "gam",
      formula   = y ~ s(x, bs = "cs"),
      se        = TRUE,
      linewidth = 1,
      color     = "green3",
      fill      = "grey80"
    ) +
    facet_wrap(as.formula(paste("~", var))) +
    coord_cartesian(expand = FALSE) +
    theme_minimal() +
    labs(
      title = paste("Bland-Altman by", var),
      x     = "Mean Risk (%)",
      y     = "Difference (DemPoRT - HH, %)"
    )
}

# Save plots
p_ba     <- bland_altman(risk_data)
p_ba_sex <- plot_strat("Sex")
p_ba_age <- plot_strat("Age_grp")

ggsave("BA_overall.png",      p_ba,      width = 7, height = 5)
ggsave("BA_by_Sex.png",       p_ba_sex,  width = 7, height = 5)
ggsave("BA_by_Age_Group.png", p_ba_age,  width = 7, height = 5)

# ----------------------------------------------------------------
# 7. Subgroup summaries with correlation p-values
# ----------------------------------------------------------------

sex_stats <- risk_data %>%
  group_by(Sex) %>%
  summarise(
    bias       = mean(BA_Diff, na.rm=TRUE),
    LoA        = 1.96 * sd(BA_Diff, na.rm=TRUE),
    pearson    = cor.test(DemPoRT_Risk5yr, HH_CIR)$estimate,
    p_Pearson  = cor.test(DemPoRT_Risk5yr, HH_CIR)$p.value,
    spearman   = cor.test(DemPoRT_Risk5yr, HH_CIR,
                          method = "spearman")$estimate,
    p_Spearman = cor.test(DemPoRT_Risk5yr, HH_CIR,
                          method = "spearman")$p.value
  ) %>%
  mutate(
    across(c(pearson, spearman),    ~ round(.x, 3)),
    p_Pearson  = ifelse(p_Pearson  < 0.001, "<0.001", sprintf("%.3f", p_Pearson)),
    p_Spearman = ifelse(p_Spearman < 0.001, "<0.001", sprintf("%.3f", p_Spearman))
  )

age_stats <- risk_data %>%
  group_by(Age_grp) %>%
  summarise(
    bias       = mean(BA_Diff, na.rm=TRUE),
    LoA        = 1.96 * sd(BA_Diff, na.rm=TRUE),
    pearson    = cor.test(DemPoRT_Risk5yr, HH_CIR)$estimate,
    p_Pearson  = cor.test(DemPoRT_Risk5yr, HH_CIR)$p.value,
    spearman   = cor.test(DemPoRT_Risk5yr, HH_CIR,
                          method = "spearman")$estimate,
    p_Spearman = cor.test(DemPoRT_Risk5yr, HH_CIR,
                          method = "spearman")$p.value
  ) %>%
  mutate(
    across(c(pearson, spearman),    ~ round(.x, 3)),
    p_Pearson  = ifelse(p_Pearson  < 0.001, "<0.001", sprintf("%.3f", p_Pearson)),
    p_Spearman = ifelse(p_Spearman < 0.001, "<0.001", sprintf("%.3f", p_Spearman))
  )

# ----------------------------------------------------------------
# 8. ANOVA & Post-hoc
# ----------------------------------------------------------------
perform_welch_tests <- function(data, diff_col, group_col) {
  data[[group_col]] <- factor(data[[group_col]])
  w <- oneway.test(
    as.formula(paste(diff_col, "~", group_col)),
    data      = data,
    var.equal = FALSE
  )
  
  if (w$p.value < 0.05) {
    # detailed=TRUE gives both p and p.adj
    jh <- rstatix::games_howell_test(
      data,
      as.formula(paste(diff_col, "~", group_col)),
      detailed = TRUE
    ) %>%
      mutate(across(where(is.numeric), ~ signif(.x, 3)))
  } else {
    jh <- tibble::tibble(
      Note = paste0(
        "No significant ANOVA for ", group_col,
        " (p = ", signif(w$p.value, 3), ")"
      )
    )
  }
  
  list(welch = w, posthoc = jh)
}

tc_sex <- perform_welch_tests(risk_data, "BA_Diff", "Sex")
tc_age <- perform_welch_tests(risk_data, "BA_Diff", "Age_grp")

# ----------------------------------------------------------------
# 9. Simple slopes plot (using centered Age in the model)
# ----------------------------------------------------------------

# Fit ANCOVA (signed bias)
ancova <- lm(BA_Diff ~ Age_c * Sex, data = risk_data)

# Prediction grid on raw Age for readability
age_seq  <- seq(min(risk_data$Age, na.rm = TRUE),
                max(risk_data$Age, na.rm = TRUE), by = 1)
mean_age <- mean(risk_data$Age, na.rm = TRUE)

simple_slopes_df <- expand.grid(
  Age = age_seq,
  Sex = levels(factor(risk_data$Sex))
) |>
  dplyr::mutate(Age_c = Age - mean_age)

# Predictions + 95% CI
pred <- predict(ancova, newdata = simple_slopes_df, se.fit = TRUE)
simple_slopes_df$fit <- pred$fit
simple_slopes_df$lwr <- pred$fit - 1.96 * pred$se.fit
simple_slopes_df$upr <- pred$fit + 1.96 * pred$se.fit

p_simple_slopes <- ggplot(simple_slopes_df,
                          aes(x = Age, y = fit, color = Sex, fill = Sex)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.15, color = NA) +
  geom_line(linewidth = 1) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  labs(
    title = "Simple Slopes: Predicted Bias (DemPoRT - HH) vs Age by Sex",
    x     = "Age (years)",
    y     = "Predicted Bias (DemPoRT - HH)"
  ) +
  theme_minimal()

ggsave("simple_slopes_bias_age_sex.png", p_simple_slopes, width = 7, height = 5)

# ----------------------------------------------------------------
# 10. Type III ANOVA table
# ----------------------------------------------------------------

anova_res <- car::Anova(ancova, type = "III") %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Term") %>%
  mutate(
    MS     = `Sum Sq`/Df,
    Eta2_p = `Sum Sq`/(`Sum Sq` + `Sum Sq`[Term=="Residuals"])
  ) %>%
  mutate(across(where(is.numeric), ~ round(.x, 3)))

# ----------------------------------------------------------------
# 11. Adjusted means & contrasts for Sex
# ----------------------------------------------------------------

emm_sex      <- emmeans(ancova, ~ Sex)
contrast_sex <- contrast(emm_sex, method = "pairwise", adjust = "bonferroni")

emm_df <- summary(emm_sex, infer = c(TRUE, TRUE)) %>%
  as.data.frame() %>%
  mutate(across(where(is.numeric), ~ round(.x, 3)))
contrast_df <- summary(contrast_sex, infer = c(TRUE, TRUE)) %>%
  as.data.frame() %>%
  mutate(across(where(is.numeric), round, 3))

# ----------------------------------------------------------------
# 12. Export all results to Excel
# ----------------------------------------------------------------

writexl::write_xlsx(
  list(
    Correlations             = tibble::tibble(
      Pearson    = round(pearson_cor, 3),
      p_Pearson  = ifelse(pearson_p < 0.001, "<0.001", sprintf("%.3f", pearson_p)),
      Spearman   = round(spearman_cor, 3),
      p_Spearman = ifelse(spearman_p < 0.001, "<0.001", sprintf("%.3f", spearman_p)),
      ICC        = round(icc_value, 3),
      p_ICC      = ifelse(icc_p < 0.001, "<0.001", sprintf("%.3f", icc_p))
    ),
    Bland_Altman_Summary     = BA_stats,
    Bland_Altman_TableA2     = BA_table_A2,
    Bland_Altman_Extended    = BA_table_A2_extended,
    Proportional_Bias_Model  = dplyr::bind_cols(
      Tidy = prop_bias_tidy,
      Glance_R2 = prop_bias_glance["r.squared"]
    ),
    Subgroup_By_Sex          = sex_stats,
    Subgroup_By_Age          = age_stats,
    Welch_ANOVA_Posthoc_Sex  = tc_sex$posthoc,
    Welch_ANOVA_Posthoc_Age  = tc_age$posthoc,
    ANCOVA_Tidy              = ancova_tidy,
    TypeII_ANOVA             = anova_res,
    Simple_Slopes_Grid       = simple_slopes_df,
    Adjusted_Means_Sex       = emm_df,
    Sex_Contrasts            = contrast_df
  ),
  path = "validation_analysis_DemPoRT_HH_summary_clean.xlsx"
)

# Restore original contrasts
options(old_contr)