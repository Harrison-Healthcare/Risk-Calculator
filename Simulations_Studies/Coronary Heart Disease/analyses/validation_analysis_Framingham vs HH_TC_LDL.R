# validation_analysis_TC_LDL.R

# 1. Install & load core packages -------------------------------------------
pkgs <- c("dplyr", "readxl", "ggplot2", "writexl", "broom", "psych", "irr")
for (p in pkgs) { 
  if (!requireNamespace(p, quietly = TRUE)) install.packages(p)
  library(p, character.only = TRUE)
}

# 1b. Install & load ANCOVA packages ----------------------------------------
if (!requireNamespace("car",     quietly = TRUE)) install.packages("car")
if (!requireNamespace("emmeans", quietly = TRUE)) install.packages("emmeans")
library(car)
library(emmeans)
# for Games–Howell post-hoc
if (!requireNamespace("rstatix", quietly=TRUE)) install.packages("rstatix")
library(rstatix)



# 2. Read in your final simulated dataset ------------------------------------
sim_data <- readxl::read_excel(
  "simulation_dataset_final_HH_Framingham_TC_LDL.xlsx"
)

# 3. Build a clean comparison table ------------------------------------------
risk_data <- sim_data %>%
  dplyr::select(
    Sex,
    Age,
    Framingham_Ten_Year_Risk_TC,
    Framingham_Ten_Year_Risk_LDL,
    HH_Survival_TC,
    HH_Survival_LDL
  ) %>%
  mutate(
    # Bland–Altman means & differences
    BA_TC_Mean  = (Framingham_Ten_Year_Risk_TC + HH_Survival_TC) / 2,
    BA_TC_Diff  = Framingham_Ten_Year_Risk_TC - HH_Survival_TC,
    BA_LDL_Mean = (Framingham_Ten_Year_Risk_LDL + HH_Survival_LDL) / 2,
    BA_LDL_Diff = Framingham_Ten_Year_Risk_LDL - HH_Survival_LDL,
    # Absolute differences
    ABS_Diff_TC  = abs(BA_TC_Diff),
    ABS_Diff_LDL = abs(BA_LDL_Diff),
    # Age‐group strata
    Age_grp = cut(
      Age,
      breaks = c(-Inf, 50, 70, Inf),
      labels = c("<50", "50–70", ">70")
    )
  )
# 3b. Bland–Altman summary statistics ----------------------------------------
library(dplyr)

BA_stats <- tibble::tibble(
  Model     = c("TC", "LDL"),
  Mean_Diff = c(
    mean(risk_data$BA_TC_Diff,  na.rm = TRUE),
    mean(risk_data$BA_LDL_Diff, na.rm = TRUE)
  ),
  SD_Diff   = c(
    sd(risk_data$BA_TC_Diff,  na.rm = TRUE),
    sd(risk_data$BA_LDL_Diff, na.rm = TRUE)
  )
) %>%
  mutate(
    LoA_Lower = Mean_Diff - 1.96 * SD_Diff,
    LoA_Upper = Mean_Diff + 1.96 * SD_Diff
  )

# 4. Overall Pearson & Spearman correlations ---------------------------------
cor_TC  <- cor(risk_data$Framingham_Ten_Year_Risk_TC,
               risk_data$HH_Survival_TC,
               use = "complete.obs")
cor_LDL <- cor(risk_data$Framingham_Ten_Year_Risk_LDL,
               risk_data$HH_Survival_LDL,
               use = "complete.obs")
spear_TC  <- cor(risk_data$Framingham_Ten_Year_Risk_TC,
                 risk_data$HH_Survival_TC,
                 method = "spearman", use = "complete.obs")
spear_LDL <- cor(risk_data$Framingham_Ten_Year_Risk_LDL,
                 risk_data$HH_Survival_LDL,
                 method = "spearman", use = "complete.obs")

# 4b. Overall Spearman correlations
spearman_TC  <- cor(risk_data$Framingham_Ten_Year_Risk_TC,
                    risk_data$HH_Survival_TC,
                    method = "spearman",
                    use    = "complete.obs")
spearman_LDL <- cor(risk_data$Framingham_Ten_Year_Risk_LDL,
                    risk_data$HH_Survival_LDL,
                    method = "spearman",
                    use    = "complete.obs")

message("Spearman correlation (TC vs HH Survival): ", round(spearman_TC, 3))
message("Spearman correlation (LDL vs HH Survival): ", round(spearman_LDL, 3))
message("Pearson correlation (TC vs HH Survival): ", round(cor_TC, 3))
message("Spearman correlation (TC vs HH Survival): ", round(spear_TC, 3))
message("Pearson correlation (LDL vs HH Survival): ", round(cor_LDL, 3))
message("Spearman correlation (LDL vs HH Survival): ", round(spear_LDL, 3))

# 5. ICC (two-way, absolute agreement) ---------------------------------------
icc_data <- risk_data %>%
  dplyr::select(Framingham_Ten_Year_Risk_TC, HH_Survival_TC,
                Framingham_Ten_Year_Risk_LDL, HH_Survival_LDL)
icc_tc <- irr::icc(icc_data[, c(1,2)], model="twoway", type="agreement")
icc_ldl <- irr::icc(icc_data[, c(3,4)], model="twoway", type="agreement")
message("ICC (TC): ", round(icc_tc$value, 3), " (", icc_tc$interpretation, ")")
message("ICC (LDL): ", round(icc_ldl$value, 3), " (", icc_ldl$interpretation, ")")

# 6. Scatterplots -------------------------------------------------------------
p_tc <- ggplot(risk_data,
               aes(x = Framingham_Ten_Year_Risk_TC, y = HH_Survival_TC)) +
  geom_point(alpha = 0.3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  scale_x_continuous(
    name   = "Framingham TC",
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.2),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name   = "HH-CHD TC",
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.2),
    expand = c(0, 0)
  ) +
  labs(title = "Framingham TC vs HH-CHD TC") +
  theme_minimal()

p_ldl <- ggplot(risk_data,
                aes(x = Framingham_Ten_Year_Risk_LDL, y = HH_Survival_LDL)) +
  geom_point(alpha = 0.3) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
  scale_x_continuous(
    name   = "Framingham LDL",
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.2),
    expand = c(0, 0)
  ) +
  scale_y_continuous(
    name   = "HH-CHD LDL",
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.2),
    expand = c(0, 0)
  ) +
  labs(title = "Framingham LDL vs HH-CHD LDL") +
  theme_minimal()

ggsave("scatter_TC_vs_HH_CHD_TC.png", p_tc, width = 6, height = 4)
ggsave("scatter_LDL_vs_HH_CHD_LDL.png", p_ldl, width = 6, height = 4)


# 7. Bland–Altman Analysis with Enhanced Diagnostics -------------------------
library(ggplot2)
library(dplyr)

# Bland-Altman Plot Function for Total Cholesterol
bland_altman_tc <- function(data) {
  # Calculate mean difference and standard deviation
  mean_diff <- mean(data$BA_TC_Diff, na.rm = TRUE)
  sd_diff <- sd(data$BA_TC_Diff, na.rm = TRUE)
  
  # Create base plot
  p <- ggplot(data, aes(x = Framingham_Ten_Year_Risk_TC, y = BA_TC_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    
    # Mean difference line
    geom_hline(yintercept = mean_diff, color = "blue", linetype = "solid") +
    
    # Upper and lower limits of agreement
    geom_hline(yintercept = mean_diff + 1.96 * sd_diff, 
               color = "red", linetype = "dashed") +
    geom_hline(yintercept = mean_diff - 1.96 * sd_diff, 
               color = "red", linetype = "dashed") +
    
    # Smooth trend line to check for systematic bias
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    
    # Annotations
    annotate("text", x = max(data$Framingham_Ten_Year_Risk_TC) * 0.8, 
             y = mean_diff + 1.96 * sd_diff, 
             label = paste("Upper LoA:", round(mean_diff + 1.96 * sd_diff, 3)), 
             vjust = -0.5) +
    annotate("text", x = max(data$Framingham_Ten_Year_Risk_TC) * 0.8, 
             y = mean_diff - 1.96 * sd_diff, 
             label = paste("Lower LoA:", round(mean_diff - 1.96 * sd_diff, 3)), 
             vjust = 1.5) +
    
    # Titles and labels
    labs(
      title = "Bland-Altman Plot: Framingham TC vs HH-CHD TC",
      x = "Framingham TC Risk",
      y = "Difference (Framingham TC - HH-CHD TC)"
    ) +
    
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5),
      axis.title = element_text(face = "bold")
    )
  p <- p + 
    scale_x_continuous(
      name = "Framingham TC Risk",
      limits = c(0, 1),
      breaks = seq(0, 1, by = 0.2),
      expand = c(0, 0)
    ) +
    scale_y_continuous(
      breaks = pretty(data$BA_TC_Diff, n = 10)
    )
  
  return(p)
}

# Bland-Altman Plot Function for LDL Cholesterol (similar to TC function)
bland_altman_ldl <- function(data) {
  # Calculate mean difference and standard deviation
  mean_diff <- mean(data$BA_LDL_Diff, na.rm = TRUE)
  sd_diff <- sd(data$BA_LDL_Diff, na.rm = TRUE)
  
  # Create base plot
  p <- ggplot(data, aes(x = Framingham_Ten_Year_Risk_LDL, y = BA_LDL_Diff)) +
    geom_point(alpha = 0.3, color = "blue") +
    
    # Mean difference line
    geom_hline(yintercept = mean_diff, color = "blue", linetype = "solid") +
    
    # Upper and lower limits of agreement
    geom_hline(yintercept = mean_diff + 1.96 * sd_diff, 
               color = "red", linetype = "dashed") +
    geom_hline(yintercept = mean_diff - 1.96 * sd_diff, 
               color = "red", linetype = "dashed") +
    
    # Smooth trend line to check for systematic bias
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    
    # Annotations
    annotate("text", x = max(data$Framingham_Ten_Year_Risk_LDL) * 0.8, 
             y = mean_diff + 1.96 * sd_diff, 
             label = paste("Upper LoA:", round(mean_diff + 1.96 * sd_diff, 3)), 
             vjust = -0.5) +
    annotate("text", x = max(data$Framingham_Ten_Year_Risk_LDL) * 0.8, 
             y = mean_diff - 1.96 * sd_diff, 
             label = paste("Lower LoA:", round(mean_diff - 1.96 * sd_diff, 3)), 
             vjust = 1.5) +
    
    # Titles and labels
    labs(
      title = "Bland-Altman Plot: Framingham LDL vs HH-CHD LDL",
      x = "Framingham LDL Risk",
      y = "Difference (Framingham LDL - HH-CHD LDL)"
    ) +
    
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5),
      axis.title = element_text(face = "bold")
    )
  
  p <- p + 
    scale_x_continuous(
      name = "Framingham LDL Risk",
      limits = c(0, 1),
      breaks = seq(0, 1, by = 0.2),
      expand = c(0, 0)
    ) +
    scale_y_continuous(
      breaks = pretty(data$BA_LDL_Diff, n = 10)
    )
  
  return(p)
}

# Stratified Bland-Altman Plots
bland_altman_stratified <- function(data, stratification_var, cholesterol_type) {
  risk_col <- paste0("Framingham_Ten_Year_Risk_", cholesterol_type)
  diff_col <- paste0("BA_", cholesterol_type, "_Diff")
  
  p <- ggplot(data, aes_string(x = risk_col, y = diff_col)) +
    geom_point(alpha = 0.3, color = "blue") +
    facet_wrap(as.formula(paste("~", stratification_var))) +
    geom_smooth(method = "loess", color = "green", se = TRUE) +
    labs(
      title = paste("Bland-Altman Plot by", stratification_var, ":", cholesterol_type),
      x = paste("Framingham", cholesterol_type, "Risk"),
      y = paste("Difference (Framingham", cholesterol_type, "- HH-CHD", cholesterol_type, ")")
    ) +
    theme_minimal()
  p <- p +
    scale_x_continuous(
      name = paste("Framingham", cholesterol_type, "Risk"),
      limits = c(0, 1),
      breaks = seq(0, 1, by = 0.2),
      expand = c(0, 0)
    ) +
    scale_y_continuous(
      breaks = pretty(data[[paste0("BA_", cholesterol_type, "_Diff")]], n = 10)
    )

  return(p)
}

# Generate and save plots
p_ba_tc <- bland_altman_tc(risk_data)
p_ba_ldl <- bland_altman_ldl(risk_data)

# Stratified plots
p_ba_tc_by_sex <- bland_altman_stratified(risk_data, "Sex", "TC")
p_ba_ldl_by_sex <- bland_altman_stratified(risk_data, "Sex", "LDL")
p_ba_tc_by_age <- bland_altman_stratified(risk_data, "Age_grp", "TC")
p_ba_ldl_by_age <- bland_altman_stratified(risk_data, "Age_grp", "LDL")

# Save plots
ggsave("BA_TC_overall.png", p_ba_tc, width = 8, height = 6)
ggsave("BA_LDL_overall.png", p_ba_ldl, width = 8, height = 6)
ggsave("BA_TC_by_sex.png", p_ba_tc_by_sex, width = 10, height = 6)
ggsave("BA_LDL_by_sex.png", p_ba_ldl_by_sex, width = 10, height = 6)
ggsave("BA_TC_by_age.png", p_ba_tc_by_age, width = 10, height = 6)
ggsave("BA_LDL_by_age.png", p_ba_ldl_by_age, width = 10, height = 6)

# 8. Subgroup (sex & age) summaries ------------------------------------------
sex_stats <- risk_data %>%
  group_by(Sex) %>%
  summarize(
    bias_TC       = mean(BA_TC_Diff, na.rm = TRUE),
    LoA_TC        = 1.96 * sd(BA_TC_Diff, na.rm = TRUE),
    pearson_TC    = cor(Framingham_Ten_Year_Risk_TC, HH_Survival_TC, use = "complete.obs"),
    spearman_TC   = cor(Framingham_Ten_Year_Risk_TC, HH_Survival_TC, method = "spearman", use = "complete.obs"),
    bias_LDL      = mean(BA_LDL_Diff, na.rm = TRUE),
    LoA_LDL       = 1.96 * sd(BA_LDL_Diff, na.rm = TRUE),
    pearson_LDL   = cor(Framingham_Ten_Year_Risk_LDL, HH_Survival_LDL, use = "complete.obs"),
    spearman_LDL  = cor(Framingham_Ten_Year_Risk_LDL, HH_Survival_LDL, method = "spearman", use = "complete.obs")
  )

age_stats <- risk_data %>%
  group_by(Age_grp) %>%
  summarize(
    bias_TC       = mean(BA_TC_Diff, na.rm = TRUE),
    LoA_TC        = 1.96 * sd(BA_TC_Diff, na.rm = TRUE),
    pearson_TC    = cor(Framingham_Ten_Year_Risk_TC, HH_Survival_TC, use = "complete.obs"),
    spearman_TC   = cor(Framingham_Ten_Year_Risk_TC, HH_Survival_TC, method = "spearman", use = "complete.obs"),
    bias_LDL      = mean(BA_LDL_Diff, na.rm = TRUE),
    LoA_LDL       = 1.96 * sd(BA_LDL_Diff, na.rm = TRUE),
    pearson_LDL   = cor(Framingham_Ten_Year_Risk_LDL, HH_Survival_LDL, use = "complete.obs"),
    spearman_LDL  = cor(Framingham_Ten_Year_Risk_LDL, HH_Survival_LDL, method = "spearman", use = "complete.obs")
  )

# 9. ANOVA and Post-hoc Analysis ---------------------------------------------
library(car)
library(stats)
library(rstatix)

# Modify the function to return and print post-hoc results
perform_welch_tests <- function(data, diff_col, group_col) {
  data[[group_col]] <- as.factor(data[[group_col]])
  levene_test <- car::leveneTest(
    as.formula(paste(diff_col, "~", group_col)), data = data
  )
  welch_anova <- oneway.test(
    as.formula(paste(diff_col, "~", group_col)), 
    data = data, var.equal = FALSE
  )
  games_howell <- if (welch_anova$p.value < 0.05) {
    rstatix::games_howell_test(
      data, formula = as.formula(paste(diff_col, "~", group_col))
    )
  } else {
    NULL
  }
  if (!is.null(games_howell)) {
    message("Games-Howell Post-hoc for ", diff_col, " by ", group_col)
    print(games_howell)
  }
  list(
    levene_test  = levene_test,
    welch_anova  = welch_anova,
    games_howell = games_howell
  )
}

# Perform tests with post-hoc analysis
tc_sex_test  <- perform_welch_tests(risk_data, "BA_TC_Diff",  "Sex")
ldl_sex_test <- perform_welch_tests(risk_data, "BA_LDL_Diff", "Sex")
tc_age_test  <- perform_welch_tests(risk_data, "BA_TC_Diff",  "Age_grp")
ldl_age_test <- perform_welch_tests(risk_data, "BA_LDL_Diff", "Age_grp")

# Prepare post-hoc results for export
export_post_hoc <- function(test_result, analysis_name) {
  if (!is.null(test_result$games_howell)) {
    return(test_result$games_howell %>% mutate(Analysis = analysis_name))
  }
  NULL
}

# 1. Grab a sample post-hoc to get the real column names
sample_ph <- export_post_hoc(tc_sex_test, "TC Difference by Sex")

# 2. Build and combine post-hoc results into one tibble
post_hoc_results <- list(
  TC_Sex  = export_post_hoc(tc_sex_test,  "TC Difference by Sex"),
  LDL_Sex = export_post_hoc(ldl_sex_test, "LDL Difference by Sex"),
  TC_Age  = export_post_hoc(tc_age_test,  "TC Difference by Age"),
  LDL_Age = export_post_hoc(ldl_age_test, "LDL Difference by Age")
)
post_hoc_export <- dplyr::bind_rows(post_hoc_results)

# 3. If empty, slice a zero-row template from our sample
if (nrow(post_hoc_export) == 0) {
  post_hoc_export <- sample_ph[0, ]
}


# 10. ANCOVA on Bland–Altman differences ------------------------------------
#    Adjusting for mean risk, testing Sex × continuous Age
ancova_tc <- aov(BA_TC_Diff ~ BA_TC_Mean + Sex * Age, data = risk_data)
ancova_ldl <- aov(BA_LDL_Diff ~ BA_LDL_Mean + Sex * Age, data = risk_data)

# ─────────────────────────────────────────────────────────────────────────────
# After your ANCOVA fits (ancova_tc, ancova_ldl), add this:
# ─────────────────────────────────────────────────────────────────────────────
library(ggplot2)

# 1. Compute the sample-mean of each BA_Mean
mean_BA_TC  <- mean(risk_data$BA_TC_Mean,  na.rm=TRUE)
mean_BA_LDL <- mean(risk_data$BA_LDL_Mean, na.rm=TRUE)

# 2. Build a grid of new data: Age over its range, both sexes, at mean risk
grid_tc <- expand.grid(
  Age        = seq(min(risk_data$Age), max(risk_data$Age), length=200),
  Sex        = c("Female","Male"),
  BA_TC_Mean = mean_BA_TC
)
grid_ldl <- expand.grid(
  Age         = seq(min(risk_data$Age), max(risk_data$Age), length=200),
  Sex         = c("Female","Male"),
  BA_LDL_Mean = mean_BA_LDL
)

# 3. Get predictions + standard errors
pred_tc  <- predict(ancova_tc,  newdata=grid_tc,  se.fit=TRUE)
pred_ldl <- predict(ancova_ldl, newdata=grid_ldl, se.fit=TRUE)

grid_tc$fit  <- pred_tc$fit
grid_tc$se   <- pred_tc$se.fit
grid_tc$upr  <- grid_tc$fit + 1.96 * grid_tc$se
grid_tc$lwr  <- grid_tc$fit - 1.96 * grid_tc$se

grid_ldl$fit  <- pred_ldl$fit
grid_ldl$se   <- pred_ldl$se.fit
grid_ldl$upr  <- grid_ldl$fit + 1.96 * grid_ldl$se
grid_ldl$lwr  <- grid_ldl$fit - 1.96 * grid_ldl$se

# 4. Plot for TC
p_tc_slopes <- ggplot(grid_tc, aes(x=Age, y=fit, color=Sex, fill=Sex)) +
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2, color=NA) +
  geom_line(size=1) +
  labs(
    title = "Simple-Slopes: TC Bias vs Age by Sex (at Mean Risk)",
    x     = "Age (years)",
    y     = "Predicted Bias (Framingham – HH-CHD TC)"
  ) +
  theme_minimal() +
  theme(legend.position="bottom")
ggsave("Framingham_simple_slopes_TC.png", p_tc_slopes, width=7, height=5)

# 5. Plot for LDL
p_ldl_slopes <- ggplot(grid_ldl, aes(x=Age, y=fit, color=Sex, fill=Sex)) +
  geom_ribbon(aes(ymin=lwr, ymax=upr), alpha=0.2, color=NA) +
  geom_line(size=1) +
  labs(
    title = "Simple-Slopes: LDL Bias vs Age by Sex (at Mean Risk)",
    x     = "Age (years)",
    y     = "Predicted Bias (Framingham – HH-CHD LDL)"
  ) +
  theme_minimal() +
  theme(legend.position="bottom")
ggsave("Framingham_simple_slopes_LDL.png", p_ldl_slopes, width=7, height=5)


# 11. Type II ANOVA tables with MS & partial η² --------------------------------
anova_tc <- car::Anova(ancova_tc, type = "II") %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Term") %>%
  mutate(Model = "TC")
anova_ldl <- car::Anova(ancova_ldl, type = "II") %>%
  as.data.frame() %>%
  tibble::rownames_to_column("Term") %>%
  mutate(Model = "LDL")
anova_results <- bind_rows(anova_tc, anova_ldl) %>%
  rename(
    Sum_Sq = `Sum Sq`,
    Df     = Df,
    F_value = `F value`,
    Pr_F    = `Pr(>F)`
  ) %>%
  group_by(Model) %>%
  mutate(
    MS     = Sum_Sq / Df,
    Eta2_p = Sum_Sq / (Sum_Sq + Sum_Sq[Term == "Residuals"])
  ) %>%
  ungroup()

# 12. Adjusted means and contrasts for Sex -----------------------------------
emm_tc_sex <- emmeans(ancova_tc, ~ Sex)
contrast_tc_sex <- contrast(emm_tc_sex, method = "pairwise", adjust = "bonferroni")

emm_ldl_sex <- emmeans(ancova_ldl, ~ Sex)
contrast_ldl_sex <- contrast(emm_ldl_sex, method = "pairwise", adjust = "bonferroni")

# 13. Age slopes by Sex via emtrends ------------------------------------------------------
age_trends_tc  <- emtrends(ancova_tc,  ~ Sex, var="Age")
age_trends_ldl <- emtrends(ancova_ldl, ~ Sex, var="Age")

# ─────────────────────────────────────────────────────────────────────────────
# 14. Tables & Figures for Age-Slopes and Adjusted Means by Sex
# ─────────────────────────────────────────────────────────────────────────────

# 14a. Age-slopes by sex (continuous Age) with inference
age_trends_tc  <- emtrends(ancova_tc,  ~ Sex, var = "Age")
age_trends_ldl <- emtrends(ancova_ldl, ~ Sex, var = "Age")

age_trends_df <- dplyr::bind_rows(
  as.data.frame(summary(age_trends_tc,  infer = c(TRUE, TRUE))) %>% 
    dplyr::mutate(Model = "TC"),
  as.data.frame(summary(age_trends_ldl, infer = c(TRUE, TRUE))) %>% 
    dplyr::mutate(Model = "LDL")
) %>%
  dplyr::select(Model, Sex, Age.trend, SE, df, t.ratio, p.value)

# 14b. Adjusted means and pairwise sex-contrasts WITH 95% CIs
emm_tc_df  <- as.data.frame(summary(emm_tc_sex,  infer = c(TRUE, TRUE))) %>% dplyr::mutate(Model = "TC")
emm_ldl_df <- as.data.frame(summary(emm_ldl_sex, infer = c(TRUE, TRUE))) %>% dplyr::mutate(Model = "LDL")

contrast_tc_df  <- as.data.frame(summary(contrast_tc_sex, infer = c(TRUE, TRUE))) %>% dplyr::mutate(Model = "TC")
contrast_ldl_df <- as.data.frame(summary(contrast_ldl_sex, infer = c(TRUE, TRUE))) %>% dplyr::mutate(Model = "LDL")

adjmeans_df <- dplyr::bind_rows(emm_tc_df, emm_ldl_df) %>%
  dplyr::select(Model, Sex, emmean, SE, df, lower.CL, upper.CL)

contrasts_df <- dplyr::bind_rows(contrast_tc_df, contrast_ldl_df) %>%
  dplyr::select(Model, contrast, estimate, SE, df, lower.CL, upper.CL, p.value)

# 14c. Figure: Age-slope lines by Sex
p_age_slopes <- ggplot(age_trends_df, aes(x = Sex, y = Age.trend, color = Sex)) +
  geom_point(size=3) +
  geom_errorbar(aes(ymin = Age.trend - SE, ymax = Age.trend + SE), width=0.2) +
  facet_wrap(~ Model) +
  labs(
    title = "Age-related Drift in Bland–Altman Bias by Sex",
    x     = "Sex",
    y     = "Slope of Bias per Year of Age"
  ) +
  theme_minimal()
ggsave("Framingham_age_slopes_by_sex.png", p_age_slopes, width=8, height=4)

# 14d. Figure: Adjusted means (95% CI) by Sex
p_adj_means <- ggplot(adjmeans_df, aes(x = Sex, y = emmean, fill = Sex)) +
  geom_col(position="dodge", width=0.6) +
  geom_errorbar(aes(ymin = lower.CL, ymax = upper.CL), width=0.2) +
  facet_wrap(~ Model) +
  labs(
    title = "Adjusted Bland–Altman Bias by Sex (at Mean Risk Level)",
    x     = "Sex",
    y     = "Adjusted Mean Bias"
  ) +
  theme_minimal() +
  theme(legend.position="none")
ggsave("Framingham_adjusted_means_by_sex.png", p_adj_means, width=8, height=4)


# 15. Export all results to Excel --------------------------------------------
writexl::write_xlsx(
  list(
    Correlations            = tibble::tibble(
      Model    = c("TC","LDL"),
      Pearson  = c(cor_TC, cor_LDL),
      Spearman = c(spearman_TC, spear_LDL),
      ICC      = c(icc_tc$value, icc_ldl$value)
    ),
    Bland_Altman_Summary    = BA_stats,
    Subgroup_By_Sex         = sex_stats,
    Subgroup_By_Age_Group   = age_stats,
    ANCOVA_Results          = anova_results,
    Age_Slopes              = age_trends_df,
    Adjusted_Means_Sex      = adjmeans_df,
    Sex_Contrasts           = contrasts_df,
    Post_Hoc_Results        = post_hoc_export
  ),
  path = "validation_analysis_TC_LDL_summary.xlsx"
)

message("✅ Analysis complete: results saved to validation_analysis_TC_LDL_summary.xlsx")
