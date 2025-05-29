# validation_analysis_Framingham_vs_HH.R

# 1. Install & load required packages ----------------------------------------
pkgs <- c("dplyr", "readr", "ggplot2", "writexl", "broom", "psych", "irr",
          "car", "emmeans", "rstatix")
for (p in pkgs) {
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

# 2. Read in your final simulated dataset ------------------------------------
sim_data <- readr::read_csv(
  "simulation_dataset_final_Framingham.csv",
  show_col_types = FALSE
)

class(sim_data)

# 3. Build a clean 'risk_data' for comparison --------------------------------
risk_data <- sim_data %>%
  dplyr::select(
    Sex, Age,
    Framingham_Ten_Year_Risk_TC,
    Framingham_Ten_Year_Risk_LDL,
    HH_Absolute_Survival
  ) %>%
  dplyr::mutate(
    # Bland–Altman metrics
    BA_TC_Mean  = (Framingham_Ten_Year_Risk_TC + HH_Absolute_Survival) / 2,
    BA_TC_Diff  = Framingham_Ten_Year_Risk_TC   - HH_Absolute_Survival,
    BA_LDL_Mean = (Framingham_Ten_Year_Risk_LDL + HH_Absolute_Survival) / 2,
    BA_LDL_Diff = Framingham_Ten_Year_Risk_LDL  - HH_Absolute_Survival,
    # Absolute differences
    ABS_Diff_TC  = abs(BA_TC_Diff),
    ABS_Diff_LDL = abs(BA_LDL_Diff),
    # Age‐group strata
    Age_grp = case_when(
      Age < 50   ~ "<50",
      Age <= 70  ~ "50–70",
      TRUE       ~ ">70"
    )
  )

# 4. Overall Correlations & ICC ----------------------------------------------
pearson_TC  <- cor(risk_data$Framingham_Ten_Year_Risk_TC,
                   risk_data$HH_Absolute_Survival, use = "complete.obs")
pearson_LDL <- cor(risk_data$Framingham_Ten_Year_Risk_LDL,
                   risk_data$HH_Absolute_Survival, use = "complete.obs")
spearman_TC  <- cor(risk_data$Framingham_Ten_Year_Risk_TC,
                    risk_data$HH_Absolute_Survival, method = "spearman", use = "complete.obs")
spearman_LDL <- cor(risk_data$Framingham_Ten_Year_Risk_LDL,
                    risk_data$HH_Absolute_Survival, method = "spearman", use = "complete.obs")

icc_TC  <- irr::icc(risk_data[, c("Framingham_Ten_Year_Risk_TC", "HH_Absolute_Survival")],
                    model = "twoway", type = "agreement")
icc_LDL <- irr::icc(risk_data[, c("Framingham_Ten_Year_Risk_LDL", "HH_Absolute_Survival")],
                    model = "twoway", type = "agreement")

message("Pearson correlation (TC vs HH Survival): ", round(pearson_TC, 3))
message("Spearman correlation (TC vs HH Survival): ", round(spearman_TC, 3))
message("ICC (TC): ", round(icc_TC$value, 3), " (", icc_TC$interpretation, ")")
message("Pearson correlation (LDL vs HH Survival): ", round(pearson_LDL, 3))
message("Spearman correlation (LDL vs HH Survival): ", round(spearman_LDL, 3))
message("ICC (LDL): ", round(icc_LDL$value, 3), " (", icc_LDL$interpretation, ")")

# 5. Bland–Altman Analysis with Enhanced Diagnostics -------------------------
# Functions include LOESS smoothing and annotations

bland_altman_tc <- function(data) {
  mean_diff <- mean(data$BA_TC_Diff, na.rm = TRUE)
  sd_diff   <- sd(data$BA_TC_Diff, na.rm = TRUE)
  ggplot(data, aes(x = Framingham_Ten_Year_Risk_TC, y = BA_TC_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    geom_hline(yintercept = mean_diff, color = "blue", linetype = "solid") +
    geom_hline(yintercept = mean_diff + 1.96 * sd_diff,
               color = "red", linetype = "dashed") +
    geom_hline(yintercept = mean_diff - 1.96 * sd_diff,
               color = "red", linetype = "dashed") +
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    annotate("text",
             x = max(data$Framingham_Ten_Year_Risk_TC) * 0.75,
             y = mean_diff + 1.96 * sd_diff,
             label = paste("Upper LoA:", round(mean_diff + 1.96 * sd_diff, 3)),
             vjust = -0.5) +
    annotate("text",
             x = max(data$Framingham_Ten_Year_Risk_TC) * 0.75,
             y = mean_diff - 1.96 * sd_diff,
             label = paste("Lower LoA:", round(mean_diff - 1.96 * sd_diff, 3)),
             vjust = 1.5) +
    labs(
      title = "Bland–Altman: Framingham TC vs HH-CHD",
      x     = "Framingham TC Risk",
      y     = "Difference (Framingham – HH-CHD)"
    ) +
    scale_x_continuous(limits = c(0,1), breaks = seq(0,1,0.2)) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5),
          axis.title = element_text(face = "bold"))
}

bland_altman_ldl <- function(data) {
  mean_diff <- mean(data$BA_LDL_Diff, na.rm = TRUE)
  sd_diff   <- sd(data$BA_LDL_Diff, na.rm = TRUE)
  ggplot(data, aes(x = Framingham_Ten_Year_Risk_LDL, y = BA_LDL_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    geom_hline(yintercept = mean_diff, color = "blue", linetype = "solid") +
    geom_hline(yintercept = mean_diff + 1.96 * sd_diff,
               color = "red", linetype = "dashed") +
    geom_hline(yintercept = mean_diff - 1.96 * sd_diff,
               color = "red", linetype = "dashed") +
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    annotate("text",
             x = max(data$Framingham_Ten_Year_Risk_LDL) * 0.75,
             y = mean_diff + 1.96 * sd_diff,
             label = paste("Upper LoA:", round(mean_diff + 1.96 * sd_diff, 3)),
             vjust = -0.5) +
    annotate("text",
             x = max(data$Framingham_Ten_Year_Risk_LDL) * 0.75,
             y = mean_diff - 1.96 * sd_diff,
             label = paste("Lower LoA:", round(mean_diff - 1.96 * sd_diff, 3)),
             vjust = 1.5) +
    labs(
      title = "Bland–Altman: Framingham LDL vs HH-CHD",
      x     = "Framingham LDL Risk",
      y     = "Difference (Framingham – HH-CHD)"
    ) +
    scale_x_continuous(limits = c(0,1), breaks = seq(0,1,0.2)) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5),
          axis.title = element_text(face = "bold"))
}

bland_altman_stratified <- function(data, strat_var, chol_type) {
  risk_col <- paste0("Framingham_Ten_Year_Risk_", chol_type)
  diff_col <- paste0("BA_", chol_type, "_Diff")
  ggplot(data, aes_string(x = risk_col, y = diff_col)) +
    geom_point(alpha = 0.3, color = "blue") +
    facet_wrap(as.formula(paste("~", strat_var))) +
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    labs(
      title = paste("Bland–Altman by", strat_var, ":", chol_type),
      x     = paste("Framingham", chol_type, "Risk"),
      y     = paste("Difference (Framingham", chol_type, "− HH)")
    ) +
    scale_x_continuous(limits = c(0,1), breaks = seq(0,1,0.2)) +
    theme_minimal()
}

# Generate and save BA plots
p_ba_tc <- bland_altman_tc(risk_data)
p_ba_ldl <- bland_altman_ldl(risk_data)
ggsave("modern_BA_TC_overall.png", p_ba_tc,     width = 8, height = 6)
ggsave("modern_BA_LDL_overall.png", p_ba_ldl,   width = 8, height = 6)

# Stratified BA by Sex and Age_grp
ggsave("modern_BA_TC_by_sex.png", bland_altman_stratified(risk_data, "Sex", "TC"), width = 10, height = 6)
ggsave("modern_BA_LDL_by_sex.png", bland_altman_stratified(risk_data, "Sex", "LDL"), width = 10, height = 6)
ggsave("mdoern_BA_TC_by_age.png", bland_altman_stratified(risk_data, "Age_grp", "TC"), width = 10, height = 6)
ggsave("modern_BA_LDL_by_age.png", bland_altman_stratified(risk_data, "Age_grp", "LDL"), width = 10, height = 6)


# 6. Difference vs Age plots (modern) ----------------------------------------
p_diff_age_tc <- ggplot(risk_data, aes(x = Age, y = BA_TC_Diff)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Difference vs Age: TC",
    x     = "Age",
    y     = "Framingham_TC – HH-CHD"
  ) +
  theme_minimal()

p_diff_age_ldl <- ggplot(risk_data, aes(x = Age, y = BA_LDL_Diff)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(
    title = "Difference vs Age: LDL",
    x     = "Age",
    y     = "Framingham_LDL – HH-CHD"
  ) +
  theme_minimal()

ggsave("modern_diff_vs_age_TC.png",  p_diff_age_tc,  width = 6, height = 4, dpi = 300)
ggsave("modern_diff_vs_age_LDL.png", p_diff_age_ldl, width = 6, height = 4, dpi = 300)

# 7. Scatter plots -----------------------------------------------------------
p_scatter_tc <- ggplot(risk_data, aes(
  x = Framingham_Ten_Year_Risk_TC,
  y = HH_Absolute_Survival
)) +
  geom_point(alpha = 0.3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "blue") +
  scale_x_continuous(name = "Framingham TC", limits = c(0,1), breaks = seq(0,1,0.2)) +
  scale_y_continuous(name = "HH-CHD", limits = c(0,1), breaks = seq(0,1,0.2)) +
  labs(title = "Framingham TC vs HH-CHD") +
  theme_minimal()

p_scatter_ldl <- ggplot(risk_data, aes(
  x = Framingham_Ten_Year_Risk_LDL,
  y = HH_Absolute_Survival
)) +
  geom_point(alpha = 0.3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "blue") +
  scale_x_continuous(name = "Framingham LDL", limits = c(0,1), breaks = seq(0,1,0.2)) +
  scale_y_continuous(name = "HH-CHD", limits = c(0,1), breaks = seq(0,1,0.2)) +
  labs(title = "Framingham LDL vs HH-CHD") +
  theme_minimal()

ggsave("modern_scatter_TC_vs_HH.png",  p_scatter_tc,  width = 6, height = 4, dpi = 300)
ggsave("modern_scatter_LDL_vs_HH.png", p_scatter_ldl, width = 6, height = 4, dpi = 300)

# 8. Summary statistics & export ---------------------------------------------
summary_stats <- tibble::tibble(
  Metric = c(
    "Pearson TC vs HH", "Spearman TC vs HH", "ICC TC",
    "Mean Diff TC", "Mean Abs Diff TC", "LoA ± TC",
    "Pearson LDL vs HH", "Spearman LDL vs HH", "ICC LDL",
    "Mean Diff LDL", "Mean Abs Diff LDL", "LoA ± LDL"
  ),
  Value = c(
    pearson_TC, spearman_TC, icc_TC$value,
    mean(risk_data$BA_TC_Diff, na.rm = TRUE),
    mean(risk_data$ABS_Diff_TC, na.rm = TRUE),
    1.96 * sd(risk_data$BA_TC_Diff, na.rm = TRUE),
    pearson_LDL, spearman_LDL, icc_LDL$value,
    mean(risk_data$BA_LDL_Diff, na.rm = TRUE),
    mean(risk_data$ABS_Diff_LDL, na.rm = TRUE),
    1.96 * sd(risk_data$BA_LDL_Diff, na.rm = TRUE)
  )
)

subgroup_sex <- risk_data %>%
  group_by(Sex) %>%
  summarize(
    Pearson_TC   = cor(Framingham_Ten_Year_Risk_TC, HH_Absolute_Survival, use = "complete.obs"),
    Spearman_TC  = cor(Framingham_Ten_Year_Risk_TC, HH_Absolute_Survival, method = "spearman", use = "complete.obs"),
    Bias_TC      = mean(BA_TC_Diff, na.rm = TRUE),
    LoA_TC       = 1.96 * sd(BA_TC_Diff, na.rm = TRUE),
    Pearson_LDL  = cor(Framingham_Ten_Year_Risk_LDL, HH_Absolute_Survival, use = "complete.obs"),
    Spearman_LDL = cor(Framingham_Ten_Year_Risk_LDL, HH_Absolute_Survival, method = "spearman", use = "complete.obs"),
    Bias_LDL     = mean(BA_LDL_Diff, na.rm = TRUE),
    LoA_LDL      = 1.96 * sd(BA_LDL_Diff, na.rm = TRUE)
  )

subgroup_age <- risk_data %>%
  group_by(Age_grp) %>%
  summarize(
    Pearson_TC   = cor(Framingham_Ten_Year_Risk_TC, HH_Absolute_Survival, use = "complete.obs"),
    Spearman_TC  = cor(Framingham_Ten_Year_Risk_TC, HH_Absolute_Survival, method = "spearman", use = "complete.obs"),
    Bias_TC      = mean(BA_TC_Diff, na.rm = TRUE),
    LoA_TC       = 1.96 * sd(BA_TC_Diff, na.rm = TRUE),
    Pearson_LDL  = cor(Framingham_Ten_Year_Risk_LDL, HH_Absolute_Survival, use = "complete.obs"),
    Spearman_LDL = cor(Framingham_Ten_Year_Risk_LDL, HH_Absolute_Survival, method = "spearman", use = "complete.obs"),
    Bias_LDL     = mean(BA_LDL_Diff, na.rm = TRUE),
    LoA_LDL      = 1.96 * sd(BA_LDL_Diff, na.rm = TRUE)
  )

# 9. ANCOVA on Bland–Altman differences --------------------------------------
ancova_tc  <- aov(BA_TC_Diff  ~ BA_TC_Mean  + Sex * Age, data = risk_data)
ancova_ldl <- aov(BA_LDL_Diff ~ BA_LDL_Mean + Sex * Age, data = risk_data)

# Simple‐slopes data grid
mean_BA_TC  <- mean(risk_data$BA_TC_Mean,  na.rm=TRUE)
mean_BA_LDL <- mean(risk_data$BA_LDL_Mean, na.rm=TRUE)

grid_tc <- expand.grid(
  Age        = seq(min(risk_data$Age), max(risk_data$Age), length = 200),
  Sex        = c("Female","Male"),
  BA_TC_Mean = mean_BA_TC
)
grid_ldl <- expand.grid(
  Age         = seq(min(risk_data$Age), max(risk_data$Age), length = 200),
  Sex         = c("Female","Male"),
  BA_LDL_Mean = mean_BA_LDL
)

pred_tc  <- predict(ancova_tc,  newdata = grid_tc,  se.fit = TRUE)
pred_ldl <- predict(ancova_ldl, newdata = grid_ldl, se.fit = TRUE)

grid_tc$fit  <- pred_tc$fit
grid_tc$se   <- pred_tc$se.fit
grid_tc$upr  <- grid_tc$fit + 1.96 * grid_tc$se
grid_tc$lwr  <- grid_tc$fit - 1.96 * grid_tc$se

grid_ldl$fit  <- pred_ldl$fit
grid_ldl$se   <- pred_ldl$se.fit
grid_ldl$upr  <- grid_ldl$fit + 1.96 * grid_ldl$se
grid_ldl$lwr  <- grid_ldl$fit - 1.96 * grid_ldl$se

# Plot simple‐slopes
p_tc_slopes <- ggplot(grid_tc, aes(x = Age, y = fit, color = Sex, fill = Sex)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.2, color = NA) +
  geom_line(size = 1) +
  labs(
    title = "Simple‐Slopes: TC Bias vs Age by Sex (at Mean Risk)",
    x     = "Age (years)",
    y     = "Predicted Bias (Framingham − HH-CHD TC)"
  ) +
  theme_minimal() +
  theme(legend.position="bottom")

p_ldl_slopes <- ggplot(grid_ldl, aes(x = Age, y = fit, color = Sex, fill = Sex)) +
  geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.2, color = NA) +
  geom_line(size = 1) +
  labs(
    title = "Simple‐Slopes: LDL Bias vs Age by Sex (at Mean Risk)",
    x     = "Age (years)",
    y     = "Predicted Bias (Framingham − HH-CHD LDL)"
  ) +
  theme_minimal() +
  theme(legend.position="bottom")

ggsave("modern_simple_slopes_TC.png",  p_tc_slopes,  width = 7, height = 5, dpi = 300)
ggsave("modern_simple_slopes_LDL.png", p_ldl_slopes, width = 7, height = 5, dpi = 300)

# 10. Type II ANOVA tables with MS & partial η² -------------------------------
anova_tc <- Anova(ancova_tc, type = "II") %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Term") %>%
  rename(
    Sum_Sq  = `Sum Sq`,
    Df      = Df,
    F_value = `F value`,
    Pr_F    = `Pr(>F)`
  ) %>%
  mutate(Model = "TC")

anova_ldl <- Anova(ancova_ldl, type = "II") %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Term") %>%
  rename(
    Sum_Sq  = `Sum Sq`,
    Df      = Df,
    F_value = `F value`,
    Pr_F    = `Pr(>F)`
  ) %>%
  mutate(Model = "LDL")

anova_results <- bind_rows(anova_tc, anova_ldl) %>%
  group_by(Model) %>%
  mutate(
    MS     = Sum_Sq / Df,
    Eta2_p = Sum_Sq / (Sum_Sq + Sum_Sq[Term == "Residuals"])
  ) %>%
  ungroup()

# 11. Adjusted means & contrasts via emmeans ---------------------------------
emm_tc_sex  <- emmeans(ancova_tc,  ~ Sex)
contrast_tc <- contrast(emm_tc_sex, method = "pairwise", adjust = "bonferroni")

emm_ldl_sex <- emmeans(ancova_ldl, ~ Sex)
contrast_ldl  <- contrast(emm_ldl_sex, method = "pairwise", adjust = "bonferroni")

# 12. Age trends via emtrends ------------------------------------------------
age_trends_tc  <- emtrends(ancova_tc,  ~ Sex, var = "Age")
age_trends_ldl <- emtrends(ancova_ldl, ~ Sex, var = "Age")

age_trends_df <- bind_rows(
  as.data.frame(summary(age_trends_tc,  infer = TRUE))  %>% mutate(Model = "TC"),
  as.data.frame(summary(age_trends_ldl, infer = TRUE))  %>% mutate(Model = "LDL")
) %>%
  dplyr::select(Model, Sex, Age.trend, SE, df, t.ratio, p.value)

# 13. Prepare adjusted means & contrasts tables ------------------------------
adjmeans_df <- bind_rows(
  as.data.frame(summary(emm_tc_sex,  infer = TRUE))  %>% mutate(Model = "TC"),
  as.data.frame(summary(emm_ldl_sex, infer = TRUE))  %>% mutate(Model = "LDL")
) %>%
  dplyr::select(Model, Sex, emmean, SE, df, lower.CL, upper.CL)

contrasts_df <- bind_rows(
  as.data.frame(summary(contrast_tc, infer = TRUE))  %>% mutate(Model = "TC"),
  as.data.frame(summary(contrast_ldl, infer = TRUE)) %>% mutate(Model = "LDL")
) %>%
  dplyr::select(Model, contrast, estimate, SE, df, lower.CL, upper.CL, p.value)

# 14. Figures for age‐slopes & adjusted means by Sex --------------------------
p_age_slopes <- ggplot(age_trends_df, aes(x = Sex, y = Age.trend, color = Sex)) +
  geom_point(size=3) +
  geom_errorbar(aes(ymin = Age.trend - SE, ymax = Age.trend + SE), width=0.2) +
  facet_wrap(~ Model) +
  labs(
    title = "Age-related Drift in BA Bias by Sex",
    x     = "Sex",
    y     = "Slope of Bias per Year"
  ) +
  theme_minimal()
ggsave("age_slopes_by_sex.png", p_age_slopes, width = 8, height = 4, dpi = 300)

p_adj_means <- ggplot(adjmeans_df, aes(x = Sex, y = emmean, fill = Sex)) +
  geom_col(position="dodge", width=0.6) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width=0.2) +
  facet_wrap(~ Model) +
  labs(
    title = "Adjusted BA Bias by Sex (at Mean Risk)",
    x     = "Sex",
    y     = "Adjusted Mean Bias"
  ) +
  theme_minimal() +
  theme(legend.position="none")
ggsave("adjusted_means_by_sex.png", p_adj_means, width = 8, height = 4, dpi = 300)

# 15. Export all results to Excel --------------------------------------------
writexl::write_xlsx(
  list(
    Individual_Results    = risk_data,
    Summary_Statistics    = summary_stats,
    Subgroup_By_Sex       = subgroup_sex,
    Subgroup_By_Age_Group = subgroup_age,
    ANCOVA_Results        = anova_results,
    Age_Slopes            = age_trends_df,
    Adjusted_Means_Sex    = adjmeans_df,
    Sex_Contrasts         = contrasts_df
  ),
  path = "validation_analysis_Framingham_vs_HH_summary.xlsx"
)

message("✅ Analysis complete: results saved to validation_analysis_Framingham_vs_HH_summary.xlsx")
