# -------------------------------
# Set Working Directory and Load Packages
# -------------------------------
setwd("/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset Framingham vs HH_CHD/")

# Install if needed
if (!require("dplyr"))    install.packages("dplyr")
if (!require("MASS"))     install.packages("MASS")
if (!require("tidyr"))    install.packages("tidyr")
if (!require("ggplot2"))  install.packages("ggplot2")
if (!require("writexl"))  install.packages("writexl")
if (!require("purrr"))    install.packages("purrr")
if (!require("readxl"))   install.packages("readxl")
if (!require("readr"))    install.packages("readr")

# Load in order so that dplyr masks any conflicting functions last
library(MASS)
library(tidyr)
library(ggplot2)
library(writexl)
library(purrr)
library(readxl)
library(readr)

# Finally, load dplyr to ensure its verbs (select, filter, etc.) take precedence
library(dplyr)

# -------------------------------
# Set seed for reproducibility
# -------------------------------
set.seed(123)

# --------------------------------------------------
# 1. Define sample sizes and simulation parameters
# --------------------------------------------------
n_men <- 4800
n_women <- 5200

# Define means and SDs for key continuous variables (Framingham-like)
# Order: Age, SBP, DBP, BMI, Total_Chol, LDL, HDL
men_means   <- c(Age = 48.6, SBP = 130, DBP = 80, BMI = 26, Total_Chol = 210, LDL = 130, HDL = 45)
men_sds     <- c(Age = 11.7, SBP = 15, DBP = 10, BMI = 3, Total_Chol = 30, LDL = 25, HDL = 10)
women_means <- c(Age = 49.8, SBP = 125, DBP = 75, BMI = 27, Total_Chol = 220, LDL = 140, HDL = 55)
women_sds   <- c(Age = 12.0, SBP = 15, DBP = 10, BMI = 3, Total_Chol = 30, LDL = 25, HDL = 10)

# Define an approximate 7x7 correlation matrix for the continuous variables
cor_mat <- matrix(c(
  1.00, 0.30, 0.20, 0.20, 0.20, 0.20, 0.10,
  0.30, 1.00, 0.70, 0.40, 0.20, 0.20, 0.00,
  0.20, 0.70, 1.00, 0.30, 0.20, 0.20, 0.00,
  0.20, 0.40, 0.30, 1.00, 0.30, 0.30, -0.30,
  0.20, 0.20, 0.20, 0.30, 1.00, 0.80, 0.30,
  0.20, 0.20, 0.20, 0.30, 0.80, 1.00, -0.20,
  0.10, 0.00, 0.00, -0.30, 0.30, -0.20, 1.00
), nrow = 7, byrow = TRUE)

# Compute covariance matrices
men_cov <- outer(men_sds, men_sds) * cor_mat
women_cov <- outer(women_sds, women_sds) * cor_mat

# --------------------------------------------------
# 2. Simulate continuous variables for men and women
# --------------------------------------------------
men_data <- as.data.frame(mvrnorm(n = n_men, mu = men_means, Sigma = men_cov))
women_data <- as.data.frame(mvrnorm(n = n_women, mu = women_means, Sigma = women_cov))

# Truncate Age to the allowed range (30–74)
men_data$Age <- pmax(pmin(men_data$Age, 74), 30)
women_data$Age <- pmax(pmin(women_data$Age, 74), 30)

# Round all numeric variables (all as integers except BMI, which retains one decimal)
men_data <- men_data %>%
  mutate(
    Age = round(Age, 0),
    SBP = round(SBP, 0),
    DBP = round(DBP, 0),
    BMI = round(BMI, 1),
    Total_Chol = round(Total_Chol, 0),  # Use Total_Chol (with underscore)
    LDL = round(LDL, 0),
    HDL = round(HDL, 0)
  )
women_data <- women_data %>%
  mutate(
    Age = round(Age, 0),
    SBP = round(SBP, 0),
    DBP = round(DBP, 0),
    BMI = round(BMI, 1),
    Total_Chol = round(Total_Chol, 0),
    LDL = round(LDL, 0),
    HDL = round(HDL, 0)
  )

# Add Sex variable (add before combining)
men_data$Sex <- "Male"
women_data$Sex <- "Female"

library(dplyr)
library(writexl)

# 3. Combine male and female datasets into sim_data
# --------------------------------------------------
sim_data <- bind_rows(men_data, women_data) %>%
  # 3a. Clamp all lipids into realistic physiological ranges
  mutate(
    Total_Chol = pmin(pmax(Total_Chol, 100), 400),  # TC ∈ [100,400]
    LDL        = pmin(pmax(LDL,        30), 300),  # LDL ∈ [30,300]
    HDL        = pmin(pmax(HDL,        20), 100)   # HDL ∈ [20,100]
  )

# 4. Now continue with your rounding, BP categorization, treatments, etc.


# 1) Define 10-year breaks from 30 up to 75
age_breaks <- c(30, 40, 50, 60, 70, 75)
age_labels <- c("30–39", "40–49", "50–59", "60–69", "70–74")

# 2) Tag each person with their 10-year Age_cat
sim_data <- sim_data %>%
  mutate(
    Age_cat = cut(
      Age,
      breaks = age_breaks,
      labels = age_labels,
      right = FALSE,
      include.lowest = TRUE
    )
  )

# 3) Count + compute prevalence by Sex (denominator = total of that sex)
age_prev <- sim_data %>%
  count(Sex, Age_cat) %>%
  group_by(Sex) %>%
  mutate(Prevalence = n / sum(n)) %>%
  ungroup() %>%
  dplyr::select(Sex, Age_cat, Prevalence)

# 4) (Optional) write out for inspection or to paste into your HH table
write_xlsx(age_prev, "Age_Prevalence_10yrBins_by_Sex.xlsx")


# --------------------------------------------------
# 3a. Force Framingham BP‐category prevalences exactly
#    (with integer SBP & DBP)
# --------------------------------------------------
library(truncnorm)

# Framingham JNC-V prevalences (Table 1)
p_bp_m <- c(
  `Normal (<130)`         = 0.440,
  `High-normal (130–139)` = 0.209,
  `Stage I (140–159)`     = 0.222,
  `Stage II–IV (>=160)`   = 0.120
)
p_bp_w <- c(
  `Normal (<130)`         = 0.555,
  `High-normal (130–139)` = 0.159,
  `Stage I (140–159)`     = 0.191,
  `Stage II–IV (>=160)`   = 0.105
)

draw_sbp <- function(n, mean=130, sd=15, lower, upper) {
  rtruncnorm(n, a=lower, b=upper, mean=mean, sd=sd)
}
draw_dbp <- function(n, mean, sd=10, lower, upper) {
  rtruncnorm(n, a=lower, b=upper, mean=mean, sd=sd)
}

sim_data <- sim_data %>%
  rowwise() %>%
  mutate(
    BP_cat = if_else(
      Sex == "Male",
      sample(names(p_bp_m), 1, prob = p_bp_m),
      sample(names(p_bp_w), 1, prob = p_bp_w)
    ),
    
    SBP = round(case_when(
      BP_cat == "Normal (<130)"         ~ draw_sbp(1, mean=130, sd=15, lower=100, upper=130),
      BP_cat == "High-normal (130–139)" ~ draw_sbp(1, mean=130, sd=15, lower=130,  upper=140),
      BP_cat == "Stage I (140–159)"     ~ draw_sbp(1, mean=130, sd=15, lower=140,  upper=160),
      BP_cat == "Stage II–IV (>=160)"   ~ draw_sbp(1, mean=130, sd=15, lower=160,  upper=199)
    ), 0),
    
    DBP = round(case_when(
      Sex == "Male"   & BP_cat == "Normal (<130)"         ~ draw_dbp(1, mean=80, sd=10, lower=-Inf, upper=85),
      Sex == "Male"   & BP_cat == "High-normal (130–139)" ~ draw_dbp(1, mean=80, sd=10, lower=85,  upper=90),
      Sex == "Male"   & BP_cat == "Stage I (140–159)"     ~ draw_dbp(1, mean=80, sd=10, lower=90,  upper=100),
      Sex == "Male"   & BP_cat == "Stage II–IV (>=160)"   ~ draw_dbp(1, mean=80, sd=10, lower=100, upper=Inf),
      
      Sex == "Female" & BP_cat == "Normal (<130)"         ~ draw_dbp(1, mean=75, sd=10, lower=-Inf, upper=85),
      Sex == "Female" & BP_cat == "High-normal (130–139)" ~ draw_dbp(1, mean=75, sd=10, lower=85,  upper=90),
      Sex == "Female" & BP_cat == "Stage I (140–159)"     ~ draw_dbp(1, mean=75, sd=10, lower=90,  upper=100),
      Sex == "Female" & BP_cat == "Stage II–IV (>=160)"   ~ draw_dbp(1, mean=75, sd=10, lower=100, upper=Inf)
    ), 0)
  ) %>%
  ungroup()

# --------------------------------------------------
# 3b–3d. BP treatment, diabetes & smoking (Wilson et al. Table 2)
# --------------------------------------------------

# 3b: Antihypertensive treatment prevalences by BP_cat
p_treat_m <- c(
  `Normal (<130)`         = 0.016,
  `High-normal (130–139)` = 0.027,
  `Stage I (140–159)`     = 0.101,
  `Stage II–IV (>=160)`   = 0.250
)
p_treat_w <- c(
  `Normal (<130)`         = 0.039,
  `High-normal (130–139)` = 0.094,
  `Stage I (140–159)`     = 0.180,
  `Stage II–IV (>=160)`   = 0.336
)

# 3c: Diabetes prevalences by BP_cat
p_dm_m <- c(
  `Normal (<130)`         = 0.036,
  `High-normal (130–139)` = 0.061,
  `Stage I (140–159)`     = 0.040,
  `Stage II–IV (>=160)`   = 0.112
)
p_dm_w <- c(
  `Normal (<130)`         = 0.026,
  `High-normal (130–139)` = 0.034,
  `Stage I (140–159)`     = 0.049,
  `Stage II–IV (>=160)`   = 0.098
)

# 3d: Smoking prevalences by BP_cat
p_sm_m <- c(
  `Normal (<130)`         = 0.431,
  `High-normal (130–139)` = 0.418,
  `Stage I (140–159)`     = 0.354,
  `Stage II–IV (>=160)`   = 0.382
)
p_sm_w <- c(
  `Normal (<130)`         = 0.394,
  `High-normal (130–139)` = 0.373,
  `Stage I (140–159)`     = 0.339,
  `Stage II–IV (>=160)`   = 0.359
)

sim_data <- sim_data %>%
  rowwise() %>%
  mutate(
    Hypertension_Treatment = if_else(
      Sex == "Male",
      sample(c("Yes","No"), 1, replace=TRUE,
             prob = c(p_treat_m[BP_cat], 1 - p_treat_m[BP_cat])),
      sample(c("Yes","No"), 1, replace=TRUE,
             prob = c(p_treat_w[BP_cat], 1 - p_treat_w[BP_cat]))
    ),
    Diabetes = if_else(
      Sex == "Male",
      sample(c("Yes","No"), 1, replace=TRUE,
             prob = c(p_dm_m[BP_cat], 1 - p_dm_m[BP_cat])),
      sample(c("Yes","No"), 1, replace=TRUE,
             prob = c(p_dm_w[BP_cat], 1 - p_dm_w[BP_cat]))
    ),
    Smoking_Status = if_else(
      Sex == "Male",
      sample(c("Current","Never"), 1, replace=TRUE,
             prob = c(p_sm_m[BP_cat], 1 - p_sm_m[BP_cat])),
      sample(c("Current","Never"), 1, replace=TRUE,
             prob = c(p_sm_w[BP_cat], 1 - p_sm_w[BP_cat]))
    )
  ) %>%
  ungroup()

# --------------------------------------------------
# 5. Prepare variables for Framingham risk calculation
# --------------------------------------------------
sim_data <- sim_data %>%
  mutate(
    smoker = if_else(Smoking_Status == "Current", 1, 0),
    diabetic = if_else(Diabetes == "Yes", 1, 0)
  )

# ---- NEW: Convert blood biomarkers to Canadian (HH) units ----
sim_data <- sim_data %>%
  mutate(
    Total_Cholesterol_mmol_L = Total_Chol / 38.67,
    LDL_Cholesterol_mmol_L = LDL / 38.67,
    HDL_Cholesterol_mmol_L = HDL / 38.67
  )

# --------------------------------------------------
# 6. Framingham Risk Calculation Function (TC and LDL)
# (Using published coefficient sets; this remains unchanged)
# --------------------------------------------------
calculate_framingham_risk <- function(age, Total_Chol, LDL, HDL, SBP, smoker, diabetic, 
                                      sex, lipid_type = "TC", risk_horizon = "10year") {
  if (age < 30 || age > 74) {
    return(list(risk = NA_real_, L_total = NA_real_))
  }
  
  if (sex == "Male") {
    if (lipid_type == "TC") {
      coef_set <- list(
        age = 0.04826,
        Total_Chol_cat = c("<160" = -0.65945, "160-199" = 0, "200-239" = 0.17692, 
                           "240-279" = 0.50539, ">=280" = 0.65713),
        hdl_cat = c("<35" = 0.49744, "35-44" = 0.24310, "45-49" = 0, 
                    "50-59" = -0.05107, ">=60" = -0.48660),
        bp_cat = c("optimal" = -0.00226, "normal" = 0, "high_normal" = 0.28320, 
                   "stage1" = 0.52168, "stage2" = 0.61859),
        smoker = 0.52337,
        diabetes = 0.42839,
        S0 = 0.90015,
        L_mean = 3.0975
      )
    } else if (lipid_type == "LDL") {
      coef_set <- list(
        age = 0.04808,
        ldl_cat = c("<100" = -0.69281, "100-129" = 0, "130-159" = 0.00389, 
                    "160-189" = 0.26755, ">=190" = 0.56705),
        hdl_cat = c("<35" = 0.48598, "35-44" = 0.21643, "45-49" = 0, 
                    "50-59" = -0.04710, ">=60" = -0.34190),
        bp_cat = c("optimal" = -0.02642, "normal" = 0, "high_normal" = 0.30104, 
                   "stage1" = 0.55714, "stage2" = 0.65107),
        smoker = 0.54377,
        diabetes = 0.42146,
        S0 = 0.90017,
        L_mean = 3.00069
      )
    }
  } else if (sex == "Female") {
    if (lipid_type == "TC") {
      coef_set <- list(
        age = 0.33766,
        age2 = -0.00268,
        Total_Chol_cat = c("<160" = -0.26138, "160-199" = 0, "200-239" = 0.20771, 
                           "240-279" = 0.24385, ">=280" = 0.53513),
        hdl_cat = c("<35" = 0.84312, "35-44" = 0.37796, "45-49" = 0.19785, 
                    "50-59" = 0, ">=60" = -0.42951),
        bp_cat = c("optimal" = -0.53363, "normal" = 0, "high_normal" = -0.06773, 
                   "stage1" = 0.26288, "stage2" = 0.46573),
        smoker = 0.29246,
        diabetes = 0.59626,
        S0 = 0.96246,
        L_mean = 9.92545
      )
    } else if (lipid_type == "LDL") {
      coef_set <- list(
        age = 0.33994,
        age2 = -0.00270,
        ldl_cat = c("<100" = -0.42515, "100-129" = 0, "130-159" = 0.01366, 
                    "160-189" = 0.26948, ">=190" = 0.33251),
        hdl_cat = c("<35" = 0.88121, "35-44" = 0.36312, "45-49" = 0, 
                    "50-59" = 0, ">=60" = -0.35404),
        bp_cat = c("optimal" = -0.51204, "normal" = 0, "high_normal" = -0.03484, 
                   "stage1" = 0.28533, "stage2" = 0.50403),
        smoker = 0.29737,
        diabetes = 0.61313,
        S0 = 0.96280,
        L_mean = 9.914136
      )
    }
  }
  
  if (lipid_type == "TC") {
    Total_Chol_cat <- ifelse(Total_Chol < 160, "<160",
                             ifelse(Total_Chol < 200, "160-199",
                                    ifelse(Total_Chol < 240, "200-239",
                                           ifelse(Total_Chol < 280, "240-279", ">=280"))))
    L_lipids <- ifelse(Total_Chol_cat == "160-199", 0, coef_set$Total_Chol_cat[Total_Chol_cat])
  } else if (lipid_type == "LDL") {
    ldl_cat <- ifelse(LDL < 100, "<100",
                      ifelse(LDL < 130, "100-129",
                             ifelse(LDL < 160, "130-159",
                                    ifelse(LDL < 190, "160-189", ">=190"))))
    L_lipids <- ifelse(ldl_cat == "100-129", 0, coef_set$ldl_cat[ldl_cat])
  }
  
  hdl_cat <- ifelse(HDL < 35, "<35",
                    ifelse(HDL < 45, "35-44",
                           ifelse(HDL < 50, "45-49",
                                  ifelse(HDL < 60, "50-59", ">=60"))))
  L_hdl <- ifelse(hdl_cat == "45-49", 0, coef_set$hdl_cat[hdl_cat])
  
  bp_cat <- ifelse(SBP < 120, "optimal",
                   ifelse(SBP < 130, "normal",
                          ifelse(SBP < 140, "high_normal",
                                 ifelse(SBP < 160, "stage1", "stage2"))))
  L_bp <- coef_set$bp_cat[bp_cat]
  
  L_smoker <- coef_set$smoker * smoker
  L_diabetes <- coef_set$diabetes * diabetic
  
  if (sex == "Female") {
    if (lipid_type == "TC") {
      L_total <- coef_set$age * age + (-0.00268) * age^2 + L_lipids + L_hdl + L_bp + L_smoker + L_diabetes
    } else if (lipid_type == "LDL") {
      L_total <- coef_set$age * age + (-0.00270) * age^2 + L_lipids + L_hdl + L_bp + L_smoker + L_diabetes
    }
  } else {
    L_total <- coef_set$age * age + L_lipids + L_hdl + L_bp + L_smoker + L_diabetes
  }
  
  risk_value <- 1 - coef_set$S0^(exp(L_total - coef_set$L_mean))
  return(list(risk = risk_value, L_total = L_total))
}

# --------------------------------------------------
# 7. Apply the Framingham Risk Calculation to sim_data
# --------------------------------------------------
sim_data <- sim_data %>%
  mutate(
    Framingham_Ten_Year_Risk_TC = sapply(
      mapply(
        calculate_framingham_risk,
        age = Age,
        Total_Chol = Total_Chol,
        LDL = LDL,  # Not used in the "TC" model
        HDL = HDL,
        SBP = SBP,
        smoker = smoker,
        diabetic = diabetic,
        sex = Sex,
        MoreArgs = list(lipid_type = "TC", risk_horizon = "10year"),
        SIMPLIFY = FALSE
      ),
      function(x) x$risk
    ),
    Framingham_Ten_Year_Risk_LDL = sapply(
      mapply(
        calculate_framingham_risk,
        age = Age,
        Total_Chol = Total_Chol,  # Provided but not used in the LDL model
        LDL = LDL,
        HDL = HDL,
        SBP = SBP,
        smoker = smoker,
        diabetic = diabetic,
        sex = Sex,
        MoreArgs = list(lipid_type = "LDL", risk_horizon = "10year"),
        SIMPLIFY = FALSE
      ),
      function(x) x$risk
    )
  )

# Rearrange columns so that Sex is the first column
sim_data <- dplyr::select(sim_data, Sex, dplyr::everything())

# Quick summary of the calculated Framingham risks:
cat("Summary of Framingham Ten-Year Risk (TC model):\n")
print(summary(sim_data$Framingham_Ten_Year_Risk_TC))
cat("Summary of Framingham Ten-Year Risk (LDL model):\n")
print(summary(sim_data$Framingham_Ten_Year_Risk_LDL))

# --------------------------------------------------
# Save the Framingham dataset (without HH integration) for reference
# --------------------------------------------------
write_xlsx(sim_data, "simulation_dataset_final_Framingham_TC_LDL.xlsx")

# ----------------------------------------------------------------
# HH Risk Calculator Integration (TC and LDL separately)
# ----------------------------------------------------------------
#library(readr)

# --------------------------------------------------
# 8. Read HH risk tables and parse numeric columns
# --------------------------------------------------

# 8a) First, define which factors belong to each model:
factors_TC  <- c(
  "Cigarette smoking",
  "Diabetes",
  "Older age",
  "Cholesterol - HDL",
  "Total_Cholesterol_mmol_L",
  "High BP"
)
factors_LDL <- c(
  "Cigarette smoking",
  "Diabetes",
  "Older age",
  "Cholesterol - HDL",
  "Cholesterol - LDL",
  "High BP"
)

# 8b) Then, read & parse the sheets, and immediately filter them:
numeric_factors <- c(
  "Older age",
  "High BP",
  "Cholesterol - HDL",
  "Cholesterol - LDL",
  "Total_Cholesterol_mmol_L"
)

hh_TC <- read_excel("TC_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx") %>%
  mutate(
    `Relative risk` = parse_number(as.character(`Relative risk`)),
    MinValue        = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MinValue)),
      NA_real_
    ),
    MaxValue        = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MaxValue)),
      NA_real_
    )
  ) %>%
  filter(Factor %in% factors_TC)   # now factors_TC is defined

hh_LDL <- read_excel("LDL_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx") %>%
  mutate(
    `Relative risk` = parse_number(as.character(`Relative risk`)),
    MinValue        = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MinValue)),
      NA_real_
    ),
    MaxValue        = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MaxValue)),
      NA_real_
    )
  ) %>%
  filter(Factor %in% factors_LDL)  # now factors_LDL is defined

# 8c) Compute factor‐level WPRs and overall PRs  ---
compute_wpr <- function(hh_df, factors) {
  hh_df %>%
    filter(Factor %in% factors) %>%
    group_by(Sex, Factor) %>%
    summarize(WPR = sum(`Prevalence (0-1)` * `Relative risk`),
              .groups = "drop")
}

wpr_TC  <- compute_wpr(hh_TC,  factors_TC)
wpr_LDL <- compute_wpr(hh_LDL, factors_LDL)

PRs_TC  <- wpr_TC  %>% group_by(Sex) %>% summarize(PR_TC  = prod(WPR))
PRs_LDL <- wpr_LDL %>% group_by(Sex) %>% summarize(PR_LDL = prod(WPR))


# --------------------------------------------------
# 9. Instrumented RR lookup with console messages
# --------------------------------------------------
get_individual_rr_HH <- function(df, factor_name, sex_value,
                                 answer=NA, numeric_value=NA) {
  if (is.null(numeric_value)||length(numeric_value)==0) numeric_value <- NA
  if (is.null(answer)       ||length(answer)==0)       answer        <- NA
  
  subset_df <- df %>% filter(Factor==factor_name,Sex==sex_value)
  if (nrow(subset_df)==0) {
    message("⚠️  No rows for factor='",factor_name,
            "' sex='",sex_value,"' → RR=1")
    return(1)
  }
  
  # numeric lookup
  if (!is.na(numeric_value)) {
    numeric_rows <- subset_df %>% filter(!is.na(MinValue),!is.na(MaxValue))
    row_match    <- numeric_rows %>%
      filter(MinValue<=numeric_value,
             numeric_value<MaxValue)
    if (nrow(row_match)>=1) return(row_match$`Relative risk`[1])
    message("⚠️  No numeric match for ",factor_name,
            "=",numeric_value," (sex=",sex_value,") → RR=1")
    return(1)
  }
  
  # categorical lookup
  if (!is.na(answer)) {
    cat_rows <- subset_df %>% filter(Answer==answer)
    if (nrow(cat_rows)>=1) return(cat_rows$`Relative risk`[1])
    message("⚠️  No categorical match for ",factor_name,
            " answer='",answer,"' (sex=",sex_value,") → RR=1")
    return(1)
  }
  
  # default fallback
  message("⚠️  Neither numeric nor answer supplied for ",
          factor_name," → RR=1")
  return(1)
}

compute_CIR_HH <- function(df, patient) {
  factors <- unique(df$Factor)
  rr_vals <- sapply(factors, function(f) {
    if (f == "Cigarette smoking") {
      # force categorical lookup only
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = patient$Smoking_Status,
        numeric_value = NA
      )
    } else if (f == "Diabetes") {
      # force categorical lookup only
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = patient$Diabetes,
        numeric_value = NA
      )
    } else if (f == "Older age") {
      # force numeric lookup only
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = NA,
        numeric_value = patient$Age
      )
    } else if (f == "High BP") {
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = NA,
        numeric_value = patient$SBP
      )
    } else if (f == "Cholesterol - HDL") {
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = NA,
        numeric_value = patient$HDL_Cholesterol_mmol_L
      )
    } else if (f == "Cholesterol - LDL") {
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = NA,
        numeric_value = patient$LDL_Cholesterol_mmol_L
      )
    } else if (f == "Total_Cholesterol_mmol_L") {
      get_individual_rr_HH(
        df, f, patient$Sex,
        answer        = NA,
        numeric_value = patient$Total_Cholesterol_mmol_L
      )
    } else {
      1
    }
  })
  prod(rr_vals)
}

# --------------------------------------------------
# 10. Define Framingham‐model baselines for survival
# --------------------------------------------------
S0_male_TC    <- 0.90015
S0_female_TC  <- 0.96246
S0_male_LDL   <- 0.90017
S0_female_LDL <- 0.96280

# --------------------------------------------------
# 11. Apply to sim_data → CIR, PR, log‐stable RR, incidence & survival
# --------------------------------------------------
sim_data <- sim_data %>%
  rowwise() %>%
  mutate(
    ## TC branch
    HH_CIR_TC         = compute_CIR_HH(hh_TC, as.list(pick(everything()))),
    HH_PR_TC          = PRs_TC$PR_TC[PRs_TC$Sex == Sex],
    log_CIR_TC        = log(HH_CIR_TC),
    log_PR_TC         = log(HH_PR_TC),
    HH_Risk_Value_TC  = exp(log_CIR_TC - log_PR_TC),            # stable RR_ratio = CIR/PR
    HH_Incidence_TC   = case_when(
      Sex == "Male"   ~ 0.10   * HH_Risk_Value_TC,
      Sex == "Female" ~ 0.0375 * HH_Risk_Value_TC
    ),
    HH_Survival_TC    = case_when(
      Sex == "Male"   ~ 1 - (S0_male_TC   ^ HH_Risk_Value_TC),
      Sex == "Female" ~ 1 - (S0_female_TC ^ HH_Risk_Value_TC)
    ),
    
    ## LDL branch
    HH_CIR_LDL        = compute_CIR_HH(hh_LDL, as.list(pick(everything()))),
    HH_PR_LDL         = PRs_LDL$PR_LDL[PRs_LDL$Sex == Sex],
    log_CIR_LDL       = log(HH_CIR_LDL),
    log_PR_LDL        = log(HH_PR_LDL),
    HH_Risk_Value_LDL = exp(log_CIR_LDL - log_PR_LDL),         # stable RR_ratio = CIR/PR
    HH_Incidence_LDL  = case_when(
      Sex == "Male"   ~ 0.10   * HH_Risk_Value_LDL,
      Sex == "Female" ~ 0.0375 * HH_Risk_Value_LDL
    ),
    HH_Survival_LDL   = case_when(
      Sex == "Male"   ~ 1 - (S0_male_LDL   ^ HH_Risk_Value_LDL),
      Sex == "Female" ~ 1 - (S0_female_LDL ^ HH_Risk_Value_LDL)
    )
  ) %>%
  ungroup()



# 12) Summaries 
cat("Summary HH_CIR_TC:\n");        print(summary(sim_data$HH_CIR_TC))
cat("Summary HH_CIR_LDL:\n");       print(summary(sim_data$HH_CIR_LDL))
cat("Summary HH_Risk_Value_TC:\n"); print(summary(sim_data$HH_Risk_Value_TC))
cat("Summary HH_Risk_Value_LDL:\n");print(summary(sim_data$HH_Risk_Value_LDL))
cat("Summary HH_Incidence_TC:\n");  print(summary(sim_data$HH_Incidence_TC))
cat("Summary HH_Incidence_LDL:\n"); print(summary(sim_data$HH_Incidence_LDL))
cat("Summary HH_Survival_TC:\n");   print(summary(sim_data$HH_Survival_TC))
cat("Summary HH_Survival_LDL:\n");  print(summary(sim_data$HH_Survival_LDL))

# 13) Export final enriched dataset
write_xlsx(
  sim_data,
  "simulation_dataset_final_HH_Framingham_TC_LDL.xlsx"
)
# --------------------------------------------------
# Compute and display summary statistics for all six risk scores
# --------------------------------------------------
risk_scores <- sim_data %>%
  dplyr::select(
    Framingham_Ten_Year_Risk_TC,
    Framingham_Ten_Year_Risk_LDL,
    HH_Incidence_TC,
    HH_Incidence_LDL,
    HH_Survival_TC,
    HH_Survival_LDL
  )
  
  # 1) Summary (min, 1st Qu., median, mean, 3rd Qu., max)
  print(summary(risk_scores))
  
  # 2) Standard deviation for each
  print(sapply(risk_scores, sd, na.rm = TRUE))

  
# BP category breakdown
  sim_data %>%
    mutate(
      BP_cat = cut(
        SBP,
        breaks = c(100, 130, 140, 160, 199),
        labels = c("Normal (<130)","High-normal (130–139)",
                   "Stage I (140–159)","Stage II–IV (≥160)")
      )
    ) %>%

  # 2) Count and compute percent by Sex
  count(Sex, BP_cat) %>%
  group_by(Sex) %>%
  mutate(percent = n / sum(n) * 100) %>%
  ungroup() %>%
  # 3) Arrange and format
  arrange(Sex, BP_cat) %>%
  mutate(percent = paste0(round(percent, 1), "%")) %>%
  # 4) Explicitly call dplyr::select
  dplyr::select(Sex, BP_cat, percent) %>%
  print(n = Inf)

  # --------------------------------------------------
  # Create Plots Comparing Selected Risk Estimates
  # --------------------------------------------------
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(scales)
  
  # 1) Gather into long form, drop only NAs
  risk_data_full <- sim_data %>%
    dplyr::select(
      Framingham_Ten_Year_Risk_TC,
      Framingham_Ten_Year_Risk_LDL,
      HH_Survival_TC,
      HH_Survival_LDL
    ) %>%
    tidyr::pivot_longer(
      cols      = everything(),
      names_to  = "Risk_Model",
      values_to = "Risk_Value"
    ) %>%
    dplyr::filter(!is.na(Risk_Value))
  
  # 2) Axis limits & breaks
  x_min    <- 0.0
  x_max    <- 0.9
  x_breaks <- seq(x_min, x_max, by = 0.1)
  
  # A) Boxplot
  ggplot(risk_data_full, aes(Risk_Model, Risk_Value, fill = Risk_Model)) +
    geom_boxplot() +
    coord_cartesian(ylim = c(x_min, x_max)) +
    scale_y_continuous(breaks = x_breaks) +
    labs(title = "Risk Estimates by Model (Boxplot)", x = NULL, y = "Risk Value") +
    theme_minimal(base_size = 12) +
    theme(
      axis.text.x    = element_text(angle = 45, hjust = 1),
      legend.position = "none",
      panel.spacing   = unit(1, "lines")
    )
  
  # B) Faceted histogram
  ggplot(risk_data_full, aes(Risk_Value, fill = Risk_Model)) +
    geom_histogram(binwidth = 0.01, boundary = 0, alpha = 0.7) +
    facet_wrap(~ Risk_Model, scales = "free_y", ncol = 2) +
    coord_cartesian(xlim = c(x_min, x_max)) +
    scale_x_continuous(breaks = x_breaks, labels = number_format(accuracy = 0.1)) +
    labs(title = "Distribution of Risk Estimates by Model", x = "Risk Value", y = "Frequency") +
    theme_minimal(base_size = 12) +
    theme(
      axis.text.x    = element_text(angle = 45, hjust = 1),
      panel.spacing   = unit(1, "lines"),
      legend.position = "none"
    )
  
  # C) Overlaid density
  ggplot(risk_data_full, aes(Risk_Value, color = Risk_Model)) +
    geom_density(linewidth = 1.2, na.rm = TRUE) +
    coord_cartesian(xlim = c(x_min, x_max)) +
    scale_x_continuous(breaks = x_breaks, labels = number_format(accuracy = 0.1)) +
    labs(title = "Density of Risk Estimates by Model", x = "Risk Value", y = "Density") +
    theme_minimal(base_size = 12) +
    theme(
      axis.text.x     = element_text(angle = 45, hjust = 1),
      legend.position = "right",
      panel.spacing   = unit(1, "lines")
    )
 
  
   # Select only the numeric variables (excluding the risk scores)
  numeric_vars <- sim_data %>%
    select(Age, SBP, DBP, BMI, Total_Chol, LDL, HDL)  # Add or remove columns as needed
  
  # Calculate descriptive statistics (mean, sd, min, max, etc.)
  descriptive_stats <- numeric_vars %>%
    summarise(
      Mean = colMeans(numeric_vars, na.rm = TRUE),
      SD = sapply(numeric_vars, sd, na.rm = TRUE),
      Min = sapply(numeric_vars, min, na.rm = TRUE),
      Max = sapply(numeric_vars, max, na.rm = TRUE),
      Median = sapply(numeric_vars, median, na.rm = TRUE),
      IQR = sapply(numeric_vars, IQR, na.rm = TRUE)
    )
  
  # Display the table
  print(descriptive_stats)
  
  # Optionally, save the descriptive stats to an Excel file
  write_xlsx(descriptive_stats, "Descriptive_Statistics_Table_TC_LDL.xlsx")
  
