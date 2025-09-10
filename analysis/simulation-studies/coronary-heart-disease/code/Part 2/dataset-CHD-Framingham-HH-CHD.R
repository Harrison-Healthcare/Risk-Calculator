# ----------------------------------------------------------------
# 0. Setup and Configuration
# ----------------------------------------------------------------

# Set working directory
setwd("/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset Framingham vs HH_CHD/")

# Load required packages with installation check
# Note: Loading packages in a specific order to avoid conflicts
required_packages <- c("dplyr", "MASS", "tidyr", "ggplot2", "writexl", "purrr", "readxl", "readr")

install_and_load <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

invisible(lapply(required_packages, install_and_load))

# -------------------------------
# Set seed for reproducibility
# -------------------------------
set.seed(123)

# ----------------------------------------------------------------
# 1. Simulation Parameters
# ----------------------------------------------------------------

# Sample sizes based on Framingham study proportions
n_men <- 4800  # Male participants
n_women <- 5200  # Female participants

# Mean values and standard deviations for continuous variables (Framingham-like)
# Order: Age, SBP, DBP, BMI, Total_Chol, LDL, HDL
# These values are based on Framingham study population characteristics

# Male population parameters
men_means <- c(
  Age = 48.6,  # Mean age
  SBP = 130,   # Mean systolic blood pressure
  DBP = 80,    # Mean diastolic blood pressure
  BMI = 26,    # Mean BMI
  Total_Chol = 210,  # Mean total cholesterol
  LDL = 130,   # Mean LDL cholesterol
  HDL = 45     # Mean HDL cholesterol
)
men_sds <- c(
  Age = 11.7,  # Age standard deviation
  SBP = 15,    # SBP standard deviation
  DBP = 10,    # DBP standard deviation
  BMI = 3,     # BMI standard deviation
  Total_Chol = 30,  # Total cholesterol standard deviation
  LDL = 25,    # LDL cholesterol standard deviation
  HDL = 10     # HDL cholesterol standard deviation
)

# Female population parameters
women_means <- c(
  Age = 49.8,  # Mean age
  SBP = 125,   # Mean systolic blood pressure
  DBP = 75,    # Mean diastolic blood pressure
  BMI = 27,    # Mean BMI
  Total_Chol = 220,  # Mean total cholesterol
  LDL = 140,   # Mean LDL cholesterol
  HDL = 55     # Mean HDL cholesterol
)
women_sds <- c(
  Age = 12.0,  # Age standard deviation
  SBP = 15,    # SBP standard deviation
  DBP = 10,    # DBP standard deviation
  BMI = 3,     # BMI standard deviation
  Total_Chol = 30,  # Total cholesterol standard deviation
  LDL = 25,    # LDL cholesterol standard deviation
  HDL = 10     # HDL cholesterol standard deviation
)

# ----------------------------------------------------------------
# 2. Correlation Matrix
# ----------------------------------------------------------------
# Define correlation matrix for continuous variables
# Order: Age, SBP, DBP, BMI, Total_Chol, LDL, HDL
# 
# Correlation matrix based on Framingham study data:
# - Strong correlation between SBP and DBP (0.70)
# - Moderate correlation between Age and BP (0.30-0.40)
# - Strong correlation between Total_Chol and LDL (0.80)
# - Negative correlation between HDL and other cholesterol measures (-0.20 to -0.30)
# - Weak correlations with BMI (0.20-0.40)

# Create correlation matrix (7x7)
cor_mat <- matrix(c(
  # Age
  1.00, 0.30, 0.20, 0.20, 0.20, 0.20, 0.10,
  # SBP
  0.30, 1.00, 0.70, 0.40, 0.20, 0.20, 0.00,
  # DBP
  0.20, 0.70, 1.00, 0.30, 0.20, 0.20, 0.00,
  # BMI
  0.20, 0.40, 0.30, 1.00, 0.30, 0.30, -0.30,
  # Total_Chol
  0.20, 0.20, 0.20, 0.30, 1.00, 0.80, 0.30,
  # LDL
  0.20, 0.20, 0.20, 0.30, 0.80, 1.00, -0.20,
  # HDL
  0.10, 0.00, 0.00, -0.30, 0.30, -0.20, 1.00
), nrow = 7, byrow = TRUE)

# Compute covariance matrices
men_cov <- outer(men_sds, men_sds) * cor_mat
women_cov <- outer(women_sds, women_sds) * cor_mat

# ----------------------------------------------------------------
# 3. Data Simulation
# ----------------------------------------------------------------

# 3a. Generate multivariate normal data for men and women
# Using covariance matrices derived from correlation matrix and standard deviations
men_data <- as.data.frame(mvrnorm(n = n_men, mu = men_means, Sigma = men_cov))
women_data <- as.data.frame(mvrnorm(n = n_women, mu = women_means, Sigma = women_cov))

# 3b. Apply age constraints (Framingham study age range: 30-74)
men_data$Age <- pmax(pmin(men_data$Age, 74), 30)
women_data$Age <- pmax(pmin(women_data$Age, 74), 30)

# 3c. Round variables to appropriate precision
# - Age, SBP, DBP, cholesterol values: integers
# - BMI: one decimal place
men_data <- men_data %>%
  mutate(
    Age = round(Age, 0),
    SBP = round(SBP, 0),
    DBP = round(DBP, 0),
    BMI = round(BMI, 1),
    Total_Chol = round(Total_Chol, 0),
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

# 3d. Add sex identifier
men_data$Sex <- "Male"
women_data$Sex <- "Female"

# --------------------------------------------------
# 3. Combine male and female datasets into sim_data
# --------------------------------------------------
sim_data <- bind_rows(men_data, women_data) %>%
  # Clamp all lipids into realistic physiological ranges
  mutate(
    Total_Chol = pmin(pmax(Total_Chol, 100), 400),  # keep TC between 100–400 mg/dL
    LDL        = pmin(pmax(LDL,        30), 300),  # keep LDL between  30–300 mg/dL
    HDL        = pmin(pmax(HDL,        20), 100)   # keep HDL between  20–100 mg/dL
  )

# 3a. Force Framingham BP‐category prevalences exactly
library(truncnorm)

# Framingham JNC‐V prevalences (Table 1)
p_bp_m <- c(
  "Normal (<130)"         = 0.440,
  "High-normal (130–139)" = 0.209,
  "Stage I (140–159)"     = 0.222,
  "Stage II–IV (>=160)"   = 0.120
)
p_bp_w <- c(
  "Normal (<130)"         = 0.555,
  "High-normal (130–139)" = 0.159,
  "Stage I (140–159)"     = 0.191,
  "Stage II–IV (>=160)"   = 0.105
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
      BP_cat == "Normal (<130)"         ~ draw_sbp(1, lower = 100, upper = 130),
      BP_cat == "High-normal (130–139)" ~ draw_sbp(1, lower = 130, upper = 140),
      BP_cat == "Stage I (140–159)"     ~ draw_sbp(1, lower = 140, upper = 160),
      BP_cat == "Stage II–IV (>=160)"   ~ draw_sbp(1, lower = 160, upper = 200),
      TRUE                               ~ NA_real_
    ), 0),
    
    DBP = round(case_when(
      Sex == "Male"   & BP_cat == "Normal (<130)"         ~ draw_dbp(1, mean = 80, lower = 50,  upper = 85),
      Sex == "Male"   & BP_cat == "High-normal (130–139)" ~ draw_dbp(1, mean = 80, lower = 85,  upper = 90),
      Sex == "Male"   & BP_cat == "Stage I (140–159)"     ~ draw_dbp(1, mean = 80, lower = 90,  upper = 100),
      Sex == "Male"   & BP_cat == "Stage II–IV (>=160)"   ~ draw_dbp(1, mean = 80, lower = 100, upper = 120),
      Sex == "Female" & BP_cat == "Normal (<130)"         ~ draw_dbp(1, mean = 75, lower = 50,  upper = 85),
      Sex == "Female" & BP_cat == "High-normal (130–139)" ~ draw_dbp(1, mean = 75, lower = 85,  upper = 90),
      Sex == "Female" & BP_cat == "Stage I (140–159)"     ~ draw_dbp(1, mean = 75, lower = 90,  upper = 100),
      Sex == "Female" & BP_cat == "Stage II–IV (>=160)"   ~ draw_dbp(1, mean = 75, lower = 100, upper = 120),
      TRUE                                                 ~ NA_real_
    ), 0)
  ) %>%
  ungroup()


# 3b: Treatment prevalences (Wilson et al. Table 2)
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

# 3c: Diabetes prevalences
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

# 3d: Smoking prevalences
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
      sample(c("Yes","No"), 1, prob = c(p_treat_m[BP_cat], 1 - p_treat_m[BP_cat])),
      sample(c("Yes","No"), 1, prob = c(p_treat_w[BP_cat], 1 - p_treat_w[BP_cat]))
    ),
    Diabetes = if_else(
      Sex == "Male",
      sample(c("Yes","No"), 1, prob = c(p_dm_m[BP_cat], 1 - p_dm_m[BP_cat])),
      sample(c("Yes","No"), 1, prob = c(p_dm_w[BP_cat], 1 - p_dm_w[BP_cat]))
    ),
    Smoking_Status = if_else(
      Sex == "Male",
      sample(c("Current","Never"), 1, prob = c(p_sm_m[BP_cat], 1 - p_sm_m[BP_cat])),
      sample(c("Current","Never"), 1, prob = c(p_sm_w[BP_cat], 1 - p_sm_w[BP_cat]))
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
write_xlsx(sim_data, "simulation_dataset_final_Framingham.xlsx")

library(readr)   # at top of script, if not already loaded

# Only these factors have numeric Min/Max
numeric_factors <- c(
  "Older age",
  "High BP",
  "Cholesterol - HDL",
  "Cholesterol - LDL",
  "Total_Cholesterol_mmol_L"
)

# ----------------------------------------------------------------
# HH Risk Calculator Integration (UPDATED FOR SEX-SPECIFIC PR)
# Using only the variables included in Framingham
# ----------------------------------------------------------------

# 1) Read & clean the Excel table
hh_table <- read_excel(
  "HH_Framingham CHD Risk Dial Risk Calculator Simualtion Study.xlsx",
  sheet = 1
) %>%
  mutate(
    `Relative risk`    = parse_number(as.character(`Relative risk`)),
    `Prevalence (0-1)` = parse_number(as.character(`Prevalence (0-1)`)),
    MinValue = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MinValue)),
      NA_real_
    ),
    MaxValue = if_else(
      Factor %in% numeric_factors,
      parse_number(as.character(MaxValue)),
      NA_real_
    )
  )

# 2) Keep only the factors we need
included_factors <- c(
  "Cigarette smoking", "Diabetes", "Older age",
  "Cholesterol - HDL", "Cholesterol - LDL",
  "Total_Cholesterol_mmol_L", "High BP"
)
hh_table_subset <- hh_table %>%
  filter(Factor %in% included_factors)

# 3) Helper to compute prevalence-weighted RR for one factor/sex
compute_WPR_for_factor_sex_HH <- function(df, factor_name, sex_value) {
  subset_df <- df %>% filter(Factor == factor_name, Sex == sex_value)
  if (nrow(subset_df) == 0) return(1)
  sum(subset_df$`Prevalence (0-1)` * subset_df$`Relative risk`)
}

# 4) Compute the overall PR by sex
PRs <- hh_table_subset %>%
  group_by(Sex, Factor) %>%
  summarize(
    WPR = sum(`Prevalence (0-1)` * `Relative risk`),
    .groups = "drop"
  ) %>%
  group_by(Sex) %>%
  summarize(PR = prod(WPR), .groups="drop")

PR_male   <- PRs$PR[PRs$Sex == "Male"]
PR_female <- PRs$PR[PRs$Sex == "Female"]

# 5) Lookup an individual’s RR for one factor
get_individual_rr_HH <- function(df, factor_name, sex_value,
                                 answer = NA, numeric_value = NA) {
  subset_df <- df %>% filter(Factor == factor_name, Sex == sex_value)
  if (nrow(subset_df) == 0) return(1)
  
  if (!is.na(numeric_value)) {
    num_rows  <- subset_df %>% filter(!is.na(MinValue), !is.na(MaxValue))
    row_match <- num_rows %>%
      filter(MinValue <= numeric_value, numeric_value < MaxValue)
    return(if (nrow(row_match)) row_match$`Relative risk`[1] else 1)
  }
  
  if (!is.na(answer)) {
    cat_rows <- subset_df %>% filter(Answer == answer)
    return(if (nrow(cat_rows)) cat_rows$`Relative risk`[1] else 1)
  }
  
  1
}

# 6) Compute each person’s combined RR (CIR)
compute_CIR_HH <- function(df, patient) {
  factors <- unique(df$Factor)
  rr_vals <- sapply(factors, function(f) {
    switch(f,
           "Cigarette smoking" = get_individual_rr_HH(df, f, patient$Sex,
                                                      answer = patient$Smoking_Status),
           "Diabetes"          = get_individual_rr_HH(df, f, patient$Sex,
                                                      answer = patient$Diabetes),
           "Older age"         = get_individual_rr_HH(df, f, patient$Sex,
                                                      numeric_value = patient$Age),
           "High BP"           = get_individual_rr_HH(df, f, patient$Sex,
                                                      numeric_value = patient$SBP),
           "Cholesterol - HDL" = get_individual_rr_HH(df, f, patient$Sex,
                                                      numeric_value = patient$HDL_Cholesterol_mmol_L),
           "Cholesterol - LDL" = get_individual_rr_HH(df, f, patient$Sex,
                                                      numeric_value = patient$LDL_Cholesterol_mmol_L),
           "Total_Cholesterol_mmol_L" = get_individual_rr_HH(df, f, patient$Sex,
                                                             numeric_value = patient$Total_Cholesterol_mmol_L),
           1
    )
  })
  prod(rr_vals)
}

# 7) Apply it to your data
sim_data <- sim_data %>%
  rowwise() %>%
  mutate(
    HH_CIR        = compute_CIR_HH(hh_table_subset, as.list(pick(everything()))),
    HH_PR         = if_else(Sex == "Female", PR_female, PR_male),
    log_CIR       = log(HH_CIR),
    log_PR        = log(HH_PR),
    HH_Risk_Value = exp(log_CIR - log_PR),    # stable RR ratio = CIR/PR
    HH_Absolute_Survival  = case_when(
      Sex == "Male"   ~ 1 - S0_male^HH_Risk_Value,
      Sex == "Female" ~ 1 - S0_female^HH_Risk_Value
    )
  ) %>%
  ungroup()

# 8) Add absolute‐risk and survival
S0_male   <- 0.90015
S0_female <- 0.96246

sim_data <- sim_data %>%
  rowwise() %>%
  mutate(
    HH_Absolute_Incidence = case_when(
      Sex == "Male"   ~ 0.10   * HH_Risk_Value,
      Sex == "Female" ~ 0.0375 * HH_Risk_Value
    ),
    HH_Absolute_Survival  = case_when(
      Sex == "Male"   ~ 1 - S0_male^HH_Risk_Value,
      Sex == "Female" ~ 1 - S0_female^HH_Risk_Value
    )
  ) %>%
  ungroup()

# 9) Quick summaries
summary(sim_data$HH_Absolute_Incidence)
summary(sim_data$HH_Absolute_Survival)


# Compute and display summary statistics for all four risk scores

risk_scores <- sim_data %>%
  dplyr::select(
    Framingham_Ten_Year_Risk_TC,
    Framingham_Ten_Year_Risk_LDL,
    HH_Absolute_Incidence,
    HH_Absolute_Survival
  )

# 1. Summary (min, 1st Qu., median, mean, 3rd Qu., max)
summary(risk_scores)

# 2. Standard deviation for each
sapply(risk_scores, sd, na.rm = TRUE)


# -------------------------------
# Final Check and Export of HH_Framingham Dataset
# -------------------------------
cat("Summary of Framingham Ten-Year Risk (TC model):\n")
print(summary(sim_data$Framingham_Ten_Year_Risk_TC))
cat("Summary of Framingham Ten-Year Risk (LDL model):\n")
print(summary(sim_data$Framingham_Ten_Year_Risk_LDL))
cat("Summary of HH_CIR:\n")
print(summary(sim_data$HH_CIR))
cat("Summary of HH_PR:\n")
print(summary(sim_data$HH_PR))
cat("Summary of HH_Risk_Value:\n")
print(summary(sim_data$HH_Risk_Value))

cat("Saving updated dataset to CSV and Excel files...\n")
write.csv(sim_data, "/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset Framingham vs HH_CHD/simulation_dataset_final_Framingham.csv", row.names = FALSE)
write_xlsx(sim_data, "/Users/juliablumkaitis-bosankic/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset Framingham vs HH_CHD/simulation_dataset_final_Framingham.xlsx")
cat("Files saved successfully!\n")

library(dplyr)   # make sure dplyr is loaded/resident

sim_data %>%
  # 1) Assign each SBP into the Framingham BP categories
  mutate(
    BP_cat = cut(
      SBP,
      breaks = c(100, 130, 140, 160, 200),
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
# Create Plots Comparing Risk Estimates (all four models)
# --------------------------------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

# 1) Gather into long form (drop only NAs)
risk_data_full <- sim_data %>%
  dplyr::select(
    Framingham_Ten_Year_Risk_TC,
    Framingham_Ten_Year_Risk_LDL,
    HH_Absolute_Incidence,
    HH_Absolute_Survival
  ) %>%
  tidyr::pivot_longer(
    cols      = everything(),
    names_to  = "Risk_Model",
    values_to = "Risk_Value"
  ) %>%
  filter(!is.na(Risk_Value))

# 2) Axis limits & breaks
x_min    <- 0.0
x_max    <- 0.9
x_breaks <- seq(x_min, x_max, by = 0.1)

# ----------------------------
# A) Boxplot
# ----------------------------
ggplot(risk_data_full, aes(Risk_Model, Risk_Value, fill = Risk_Model)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(x_min, x_max)) +
  scale_y_continuous(breaks = x_breaks) +
  labs(
    title = "Risk Estimates by Model (Boxplot)",
    x     = NULL,
    y     = "Risk Value"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x     = element_text(angle = 45, hjust = 1),
    legend.position = "none",
    panel.spacing   = unit(1, "lines")
  )

# ----------------------------
# B) Faceted histogram
# ----------------------------
ggplot(risk_data_full, aes(Risk_Value, fill = Risk_Model)) +
  geom_histogram(
    binwidth = 0.01,
    boundary = 0,
    alpha    = 0.7
  ) +
  facet_wrap(~ Risk_Model, scales = "free_y", ncol = 2) +
  coord_cartesian(xlim = c(x_min, x_max)) +
  scale_x_continuous(
    breaks = x_breaks,
    labels = number_format(accuracy = 0.1)
  ) +
  labs(
    title = "Distribution of Risk Estimates by Model",
    x     = "Risk Value",
    y     = "Frequency"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x     = element_text(angle = 45, hjust = 1),
    legend.position = "none",
    panel.spacing   = unit(1, "lines")
  )

# ----------------------------
# C) Overlaid density
# ----------------------------
ggplot(risk_data_full, aes(Risk_Value, color = Risk_Model)) +
  geom_density(linewidth = 1.2, na.rm = TRUE) +
  coord_cartesian(xlim = c(x_min, x_max)) +
  scale_x_continuous(
    breaks = x_breaks,
    labels = number_format(accuracy = 0.1)
  ) +
  labs(
    title = "Density of Risk Estimates by Model",
    x     = "Risk Value",
    y     = "Density"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    axis.text.x     = element_text(angle = 45, hjust = 1),
    legend.position = "right",
    panel.spacing   = unit(1, "lines")
  )
