# ----------------------------------------------------------------
# 0. Setup and Configuration
# ----------------------------------------------------------------

setwd("~/Desktop/Simulation Dataset DemPoRT vs HH_Dementia")

required_packages <- c(
  "dplyr", "MASS", "tidyr", "ggplot2",
  "writexl", "purrr", "readxl", "readr", "truncnorm"
)

install_and_load <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos="https://cloud.r-project.org")
    library(pkg, character.only = TRUE)
  }
}
invisible(lapply(required_packages, install_and_load))

library(dplyr)

set.seed(123)

# Clamp x into sex‐specific bounds
clamp_sex <- function(x, sex, low_m, high_m, low_f, high_f) {
  ifelse(
    sex == "Male",
    pmin(pmax(x, low_m), high_m),
    pmin(pmax(x, low_f), high_f)
  )
}

# ----------------------------------------------------------------
# 1. IQRs to SDs ((table 2), sample sizes, and simulation parameters
# ----------------------------------------------------------------

# current, former≥5y, and former<5y IQRs to one IQR
men_q1s   <- c(23.5,  7.2, 27.6)   # current, former≥5y, former<5y
men_q3s   <- c(55.7, 36.8, 61.3)

women_q1s <- c(17.6, 5.0, 18.0)
women_q3s <- c(47.0, 27.0, 53.1)

male_q1   <- min(men_q1s)
male_q3   <- max(men_q3s)
female_q1 <- min(women_q1s)
female_q3 <- max(women_q3s)

calc_params <- function(stats_list) {
  means <- sapply(stats_list, `[`, 1)
  iqrs  <- sapply(stats_list, function(x) x[3] - x[2])
  sds   <- iqrs / 1.35
  list(means = means, sds = sds)
}

# Here each vector is: c(mean, 25th‐percentile, 75th‐percentile)
male_stats <- list(
  Age       = c(67.5, 60.0, 74.0),
  PackYears = c(21.2, male_q1, male_q3),
  Alcohol   = c( 4.96,  0.0,  8.0),
  FruitVeg  = c( 4.47,  3.1,  5.7),
  METs      = c( 2.0, 0.5,  3.0),
  BMI       = c(27.1, 24.2, 29.2)
)

female_stats <- list(
  Age       = c(68.8, 61.0, 76.0),
  PackYears = c(11.3, female_q1, female_q3),
  Alcohol   = c( 1.92,  0.0,  9.0),
  FruitVeg  = c( 5.19,  3.7,  6.6),
  METs      = c( 1.61,  0.3,  2.3),
  BMI       = c(26.5, 22.8, 29.0)
)

male_params   <- calc_params(male_stats)
female_params <- calc_params(female_stats)

n_total  <- 50000
n_female <- round(n_total * 0.571)  # ≈ 28550
n_male   <- n_total - n_female      # ≈ 21450

men_means   <- male_params$means
men_sds_est <- male_params$sds

women_means   <- female_params$means
women_sds_est <- female_params$sds

cor_mat <- matrix(c(
  1.00,  0.32, -0.17,  0.12, -0.26,  0.23,
  0.32,  1.00,  0.05, -0.13, -0.11, -0.08,
  -0.17,  0.05,  1.00, -0.10,  0.04,  0.01,
  0.12, -0.13, -0.10,  1.00,  0.14, -0.12,
  -0.26, -0.11,  0.04,  0.14,  1.00, -0.27,
  0.23, -0.08,  0.01, -0.12, -0.27,  1.00
), nrow=6, byrow=TRUE)
colnames(cor_mat) <- rownames(cor_mat) <- names(men_means)

men_cov   <- cor_mat * (men_sds_est   %o% men_sds_est)
women_cov <- cor_mat * (women_sds_est %o% women_sds_est)

# ----------------------------------------------------------------
# 2. Simulate Multivariate Normal Draws
# ----------------------------------------------------------------

men_data_cont <- as.data.frame(
  MASS::mvrnorm(n = n_male, mu = men_means, Sigma = men_cov)
)
women_data_cont <- as.data.frame(
  MASS::mvrnorm(n = n_female, mu = women_means, Sigma = women_cov)
)

# rename the simulated columns into “raw” versions
men_data_cont <- men_data_cont %>%
  rename(
    Age_raw       = Age,
    PackYears_raw = PackYears,
    Alcohol_raw   = Alcohol,
    FruitVeg_raw  = FruitVeg,
    METs_raw      = METs,
    BMI_raw       = BMI
  )

women_data_cont <- women_data_cont %>%
  rename(
    Age_raw       = Age,
    PackYears_raw = PackYears,
    Alcohol_raw   = Alcohol,
    FruitVeg_raw  = FruitVeg,
    METs_raw      = METs,
    BMI_raw       = BMI
  )

# ----------------------------------------------------------------
# 3. Clamp & Round to Valid Ranges (table 1)
# ----------------------------------------------------------------

men_data_cont <- men_data_cont %>%
  mutate(
    Age              = round(clamp_sex(Age_raw,       "Male",   55, 102,  55, 101)),
    PackYears        = round(clamp_sex(PackYears_raw, "Male",    0, 112,   0,  78), 1),
    Drinks_Last_Week = round(clamp_sex(Alcohol_raw,    "Male",    0,  50,   0,  24), 1),
    FruitVeg         = round(clamp_sex(FruitVeg_raw,   "Male",    0,  48,   0,  31), 1),
    METs_Leisure     = round(clamp_sex(METs_raw,       "Male",    0,  16,   0,  12), 2),
    BMI              = round(clamp_sex(BMI_raw,        "Male",   10,  44,  10,  47), 1)
  )

women_data_cont <- women_data_cont %>%
  mutate(
    Age              = round(clamp_sex(Age_raw,       "Female", 55, 102,  55, 101)),
    PackYears        = round(clamp_sex(PackYears_raw, "Female",  0, 112,   0,  78), 1),
    Drinks_Last_Week = round(clamp_sex(Alcohol_raw,    "Female",  0,  50,   0,  24), 1),
    FruitVeg         = round(clamp_sex(FruitVeg_raw,   "Female",  0,  48,   0,  31), 1),
    METs_Leisure     = round(clamp_sex(METs_raw,       "Female",  0,  16,   0,  12), 2),
    BMI              = round(clamp_sex(BMI_raw,        "Female", 10,  44,  10,  47), 1)
  )

# ----------------------------------------------------------------
# 4a. Bind, Verify & Rename
# ----------------------------------------------------------------

men_data_cont$Sex   <- "Male"
women_data_cont$Sex <- "Female"

synthetic_continuous <- bind_rows(men_data_cont, women_data_cont) %>%
  
  # clamp & round each raw into its final variable
  mutate(
    Age = round(
      clamp_sex(Age_raw, Sex,
                low_m = 55, high_m = 102,
                low_f = 55, high_f = 101)
    ),
    PackYears = round(
      clamp_sex(PackYears_raw, Sex,
                low_m = 0,   high_m = 112,
                low_f = 0,   high_f =  78),
      1
    ),
    Drinks_Last_Week = round(
      clamp_sex(Alcohol_raw, Sex,
                low_m = 0,  high_m = 50,
                low_f = 0,  high_f = 24),
      1
    ),
    FruitVeg = round(
      clamp_sex(FruitVeg_raw, Sex,
                low_m = 0, high_m = 48,
                low_f = 0, high_f = 31),
      1
    ),
    METs_Leisure = round(
      clamp_sex(METs_raw, Sex,
                low_m = 0,  high_m = 16,
                low_f = 0,  high_f = 12),
      2
    ),
    BMI = round(
      clamp_sex(BMI_raw, Sex,
                low_m = 10, high_m = 44,
                low_f = 10, high_f = 47),
      1
    )
  ) %>%
  
  # drop all the “_raw” columns so nothing collides later
  dplyr::select(-dplyr::ends_with("_raw"))

# ----------------------------------------------------------------
# 5a. Simulate Categorical / Binary Variables (prevalence values (table 2))
# ----------------------------------------------------------------

sex_vec <- synthetic_continuous$Sex
n       <- length(sex_vec)

draw_bin <- function(pf, pm) {
  rbinom(n, 1, ifelse(sex_vec=="Female", pf, pm))
}

draw_cat <- function(levels, pf, pm) {
  pf <- pf / sum(pf)
  pm <- pm / sum(pm)
  sapply(sex_vec, function(s) {
    sample(levels, size = 1,
           prob = if (s=="Female") pf else pm)
  })
}

# ————————————————————————————————————————————————————————————————
# 5b. Generic (all sexes) categorical / binary variables
# ————————————————————————————————————————————————————————————————

# Stress (5 levels)
stress_lvls <- c("Not at all","Not very","A bit","Quite a bit","Extremely")
stress_pf   <- c(0.187,0.314,0.345,0.123,0.027)
stress_pm   <- c(0.238,0.313,0.317,0.105,0.024)
Stress <- factor(draw_cat(stress_lvls, stress_pf, stress_pm), levels = stress_lvls)

# Smoking status (4 levels)
sm_lvls <- c("Non-smoker","Current","Former<5y","Former>=5y")
sm_pf   <- c(0.146,0.416,0.049,0.277)
sm_pm   <- c(0.161,0.183,0.066,0.483)
Smoking_Status <- factor(draw_cat(sm_lvls, sm_pf, sm_pm), levels = sm_lvls)

# Drinking status (binary)
Former_Drinker <- factor(draw_bin(0.242, 0.172), levels=0:1, labels=c("No","Yes"))

# Number of activities needing help (0–6)
act_counts_m <- c(14272,816,351,246,166,143,112)
act_counts_f <- c(16460,2227,1143,688,380,242,151)
Activities_Need_Help <- factor(
  draw_cat(levels = 0:6, pf = act_counts_f, pm = act_counts_m),
  levels = 0:6
)

# Generic health conditions (binary)
Heart_Disease <- factor(draw_bin(0.148, 0.189), levels=0:1, labels=c("No","Yes"))
Stroke        <- factor(draw_bin(0.032, 0.037), levels=0:1, labels=c("No","Yes"))
Diabetes      <- factor(draw_bin(0.115, 0.153), levels=0:1, labels=c("No","Yes"))
Mood_Disorder <- factor(draw_bin(0.067, 0.041), levels=0:1, labels=c("No","Yes"))
High_BP       <- factor(draw_bin(0.423, 0.366), levels=0:1, labels=c("No","Yes"))
COPD          <- factor(draw_bin(0.076, 0.070), levels=0:1, labels=c("No","Yes"))

# ————————————————————————————————————————————————————————————————
# 5c. Female-only factors
# ————————————————————————————————————————————————————————————————

female_i <- which(sex_vec == "Female")
Education <- rep(NA_character_, n)
edu_lvls <- c(
  "Less than secondary school",
  "Secondary school graduation",
  "Some post-secondary",
  "Post-secondary graduation"
)
edu_pf <- c(0.345, 0.202, 0.053, 0.391)
Education[female_i] <- sample(
  edu_lvls, size=length(female_i), replace=TRUE, prob=edu_pf
)
Education <- factor(Education, levels=edu_lvls)

# Epilepsy (same tiny prevalence)
Epilepsy <- rep(NA_character_, n)
Epilepsy[female_i] <- as.character(
  factor(rbinom(length(female_i),1,0.004), levels=0:1, labels=c("No","Yes"))
)
Epilepsy <- factor(Epilepsy, levels=c("No","Yes"))

# Marital status
Marital_Status <- rep(NA_character_, n)
marital_lvls <- c("Now married/common law",
                  "Separated/divorced",
                  "Widowed",
                  "Single")
marital_pf   <- c(0.480, 0.117, 0.354, 0.049)
Marital_Status[female_i] <- sample(
  marital_lvls, size=length(female_i), replace=TRUE, prob=marital_pf
)
Marital_Status <- factor(Marital_Status, levels=marital_lvls)

# ————————————————————————————————————————————————————————————————
# 5d. Male-only factors
# ————————————————————————————————————————————————————————————————

male_i <- which(sex_vec == "Male")

# Ethnicity
Ethnicity <- rep(NA_character_, n)
eth_lvls <- c("White",
              "South Asian/Arab/West Asian",
              "South East Asian/Chinese/Japanese/Korean/Filipino",
              "Other/multiple/unknown")
eth_counts_m <- c(19145, 347, 274, 637)
eth_probs_m  <- eth_counts_m / sum(eth_counts_m)
Ethnicity[male_i] <- sample(
  eth_lvls, size=length(male_i), replace=TRUE, prob=eth_probs_m
)
Ethnicity <- factor(Ethnicity, levels=eth_lvls)

# Multilingualism
Multilingualism <- rep(NA_character_, n)
ml_probs_m <- c(0.684, 0.316)
ml_lvls    <- c("Yes","No")
Multilingualism[male_i] <- sample(
  ml_lvls, size=length(male_i), replace=TRUE, prob=ml_probs_m
)
Multilingualism <- factor(Multilingualism, levels=ml_lvls)

# Self-rated health
Self_Rated_Health <- rep(NA_character_, n)
srh_lvls   <- c("Excellent","Very good","Good","Fair","Poor")
srh_counts <- c(3038, 6241, 6385, 1442, 3376)
srh_probs  <- srh_counts / sum(srh_counts)
Self_Rated_Health[male_i] <- sample(
  srh_lvls, size=length(male_i), replace=TRUE, prob=srh_probs
)
Self_Rated_Health <- factor(Self_Rated_Health, levels=srh_lvls)

# ----------------------------------------------------------------
# 6a. Assemble Full Synthetic Dataset
# ----------------------------------------------------------------

synthetic_full <- synthetic_continuous %>%
  mutate(
    Stress               = Stress,
    Smoking_Status       = Smoking_Status,
    PackYears            = round(PackYears,      1),
    Drinks_Last_Week     = round(Drinks_Last_Week,1),
    Former_Drinker       = Former_Drinker,
    FruitVeg             = round(FruitVeg,       1),
    METs_Leisure         = METs_Leisure,
    Activities_Need_Help = Activities_Need_Help,
    
    # female-only
    Education            = Education,
    Epilepsy             = Epilepsy,
    Marital_Status       = Marital_Status,
    
    # male-only
    Ethnicity            = Ethnicity,
    Multilingualism      = Multilingualism,
    Self_Rated_Health    = Self_Rated_Health,
    
    # generic health
    Heart_Disease        = Heart_Disease,
    Stroke               = Stroke,
    Diabetes             = Diabetes,
    Mood_Disorder        = Mood_Disorder,
    High_BP              = High_BP,
    COPD                 = COPD, 
    
    # continuous
    Age                   = Age,
    BMI                   = BMI
  ) %>%
  dplyr::select(
    Sex, Age,
    Stress, Smoking_Status, PackYears, Drinks_Last_Week,
    Former_Drinker, FruitVeg, METs_Leisure, Activities_Need_Help,
    
    # female-only
    Education, Marital_Status, Epilepsy,
    
    # male-only
    Ethnicity, Multilingualism, Self_Rated_Health,
    
    # generic health
    Heart_Disease, Stroke, Diabetes, Mood_Disorder, High_BP, COPD, 
    
    # continuous
    BMI
  )

glimpse(synthetic_full)
summary(synthetic_full)

# ————————————————————————————————————————————
# 6b. Export raw synthetic data for DemPoRT
# ————————————————————————————————————————————
writexl::write_xlsx(
  synthetic_full,
  "simulation_dataset_raw_DemPoRT.xlsx"
)

# --------------------------------------------------
# 7. Prepare variables for DemPoRT risk calculation
# --------------------------------------------------

if (!require(Hmisc)) install.packages("Hmisc", repos="https://cloud.r-project.org")
if (!require(dplyr)) install.packages("dplyr", repos="https://cloud.r-project.org")
library(Hmisc)
library(dplyr)

# Spline helper
make_splines <- function(x, knots, prefix) {
  m <- rcspline.eval(x, knots=knots, inclx=TRUE)
  colnames(m) <- paste0(prefix, "_rcs", seq_len(ncol(m)))
  as.data.frame(m)
}

# Published centering constants
cent_m <- list(
  Age = 67.5, PackYears = 21.2, Drinks = 4.96, FruitVeg = 4.47,
  PA = 2.00, BMI = 27.1,
  StressNotVery = 0.312, StressABit = 0.323,
  StressQuite = 0.109, StressExtremely = 0.0236,
  SmokeFormer5Plus = 0.553, SmokeFormer0to5 = 0.0914,
  SmokeCurrent = 0.161, FormerDrinker = 0.158,
  HeartDisease = 0.187, Stroke = 0.0351, Diabetes = 0.166,
  MoodDisorder = 0.0569, Hypertension = 0.388,
  COPD = 0.0723,
  SRHealthPoor = 0.314, SRHealthFair = 0.315,
  SRHealthGood = 0.159, SRHealthVGood = 0.066,
  EthnSEAsian = 0.0172, EthnOther = 0.0349, EthnSWAsian = 0.0168,
  Multilingual = 0.307,
  NH1 = 0.052, NH2 = 0.0238, NH3 = 0.016,
  NH4 = 0.011, NH5 = 0.00898, NH6 = 0.00783
)
cent_f <- list(
  Age = 68.8, PackYears = 11.3, Drinks = 1.92, FruitVeg = 5.19,
  PA = 1.61, BMI = 26.5,
  StressNotVery = 0.310, StressABit = 0.352,
  StressQuite = 0.131, StressExtremely = 0.0275,
  SmokeFormer5Plus = 0.383, SmokeFormer0to5 = 0.0613,
  SmokeCurrent = 0.145, FormerDrinker = 0.212,
  HeartDisease = 0.140, Stroke = 0.031, Diabetes = 0.122,
  MoodDisorder = 0.0899, Hypertension = 0.434, Epilepsy = 0.00626,
  COPD = 0.0835,
  EduHSGrad = 0.208, EduSomePS = 0.0496, EduPSGrad = 0.432,
  MSDivorced = 0.123, MSWidowed = 0.338, MSSingle = 0.0535,
  NH1 = 0.103, NH2 = 0.0529, NH3 = 0.0312,
  NH4 = 0.0184, NH5 = 0.0118, NH6 = 0.00866
)

# Knot lists
knots_m <- list(
  AgeC              = c(-11.5,  -6.5,  -1.5,   5.5,  16.5),
  PackYearsC        = c(-21.2, -10.35,  34.8),
  DrinksLastWeekC   = c(-4.96, -3.96,   9.04),
  FruitVegC         = c(-2.37,  -0.27,   2.83),
  PhysicalActivityC = c(-1.9,   -0.1,    2.7),
  BMIC              = c(-4.8,   -0.67,   5.46592)
)
knots_f <- list(
  AgeC              = c(-12.8,  -7.8,   -0.8,   6.2,  16.2),
  PackYearsC        = c(-11.3,  -8.8,   28.7),
  DrinksLastWeekC   = c(-1.92,   0.08,  5.08),
  FruitVegC         = c(-2.69,  -0.29,   3.01),
  PhysicalActivityC = c(-1.51,  -0.11,   2.49),
  BMIC              = c(-5.76,  -0.87,   6.52)
)

# Split data set
df_m <- synthetic_full %>%
  filter(Sex == "Male") %>%
  transmute(
    Sex,
    Age_c   = Age   - cent_m$Age,
    Pack_c  = PackYears        - cent_m$PackYears,
    Drink_c = Drinks_Last_Week - cent_m$Drinks,
    FV_c    = FruitVeg         - cent_m$FruitVeg,
    PA_c    = METs_Leisure     - cent_m$PA,
    BMI_c   = BMI              - cent_m$BMI,
    StressNotVeryC_cat   = (Stress=="Not very")     - cent_m$StressNotVery,
    StressABitC_cat      = (Stress=="A bit")        - cent_m$StressABit,
    StressQuiteC_cat     = (Stress=="Quite a bit")  - cent_m$StressQuite,
    StressExtremelyC_cat = (Stress=="Extremely")    - cent_m$StressExtremely,
    SmokeFormer5PlusC_cat = (Smoking_Status=="Former>=5y") - cent_m$SmokeFormer5Plus,
    SmokeFormer0to5C_cat  = (Smoking_Status=="Former<5y")  - cent_m$SmokeFormer0to5,
    SmokeCurrentC_cat     = (Smoking_Status=="Current")    - cent_m$SmokeCurrent,
    FormerDrinkerC_cat    = (Former_Drinker=="Yes")        - cent_m$FormerDrinker,
    HeartDisC_cat         = (Heart_Disease=="Yes")         - cent_m$HeartDisease,
    StrokeC_cat           = (Stroke=="Yes")                - cent_m$Stroke,
    DiabetesC_cat         = (Diabetes=="Yes")              - cent_m$Diabetes,
    MoodC_cat             = (Mood_Disorder=="Yes")         - cent_m$Mood,
    HypertensionC_cat     = (High_BP=="Yes")               - cent_m$Hypertension,
    COPDC_cat             = (COPD=="Yes")                  - cent_m$COPD,
    SRHealthPoorC_cat     = (Self_Rated_Health=="Poor")    - cent_m$SRHealthPoor,
    SRHealthFairC_cat     = (Self_Rated_Health=="Fair")    - cent_m$SRHealthFair,
    SRHealthGoodC_cat     = (Self_Rated_Health=="Good")    - cent_m$SRHealthGood,
    SRHealthVGoodC_cat    = (Self_Rated_Health=="Very good") - cent_m$SRHealthVGood,
    EthnSEAsian4C_cat     = (Ethnicity=="Southeast Asian") - cent_m$EthnSEAsian,
    EthnOther4C_cat       = (Ethnicity=="Other")           - cent_m$EthnOther,
    EthnSWAsian4C_cat     = (Ethnicity=="Southwest Asian") - cent_m$EthnSWAsian,
    MultilingualC_cat     = (Multilingualism == "Yes")     - cent_m$Multilingual,
    NeedHelp1C_cat = (Activities_Need_Help==1) - cent_m$NH1,
    NeedHelp2C_cat = (Activities_Need_Help==2) - cent_m$NH2,
    NeedHelp3C_cat = (Activities_Need_Help==3) - cent_m$NH3,
    NeedHelp4C_cat = (Activities_Need_Help==4) - cent_m$NH4,
    NeedHelp5C_cat = (Activities_Need_Help==5) - cent_m$NH5,
    NeedHelp6C_cat = (Activities_Need_Help==6) - cent_m$NH6
  )

df_f <- synthetic_full %>%
  filter(Sex == "Female") %>%
  transmute(
    Sex,
    Age_c   = Age   - cent_f$Age,
    Pack_c  = PackYears        - cent_f$PackYears,
    Drink_c = Drinks_Last_Week - cent_f$Drinks,
    FV_c    = FruitVeg         - cent_f$FruitVeg,
    PA_c    = METs_Leisure     - cent_f$PA,
    BMI_c   = BMI              - cent_f$BMI,
    StressNotVeryC_cat   = (Stress=="Not very")     - cent_f$StressNotVery,
    StressABitC_cat      = (Stress=="A bit")        - cent_f$StressABit,
    StressQuiteC_cat     = (Stress=="Quite a bit")  - cent_f$StressQuite,
    StressExtremelyC_cat = (Stress=="Extremely")    - cent_f$StressExtremely,
    SmokeFormer5PlusC_cat = (Smoking_Status=="Former>=5y") - cent_f$SmokeFormer5Plus,
    SmokeFormer0to5C_cat  = (Smoking_Status=="Former<5y")  - cent_f$SmokeFormer0to5,
    SmokeCurrentC_cat     = (Smoking_Status=="Current")    - cent_f$SmokeCurrent,
    FormerDrinkerC_cat    = (Former_Drinker=="Yes")        - cent_f$FormerDrinker,
    HeartDisC_cat         = (Heart_Disease=="Yes")         - cent_f$HeartDisease,
    StrokeC_cat           = (Stroke=="Yes")                - cent_f$Stroke,
    DiabetesC_cat         = (Diabetes=="Yes")              - cent_f$Diabetes,
    MoodC_cat             = (Mood_Disorder=="Yes")         - cent_f$Mood,
    HypertensionC_cat     = (High_BP=="Yes")               - cent_f$Hypertension,
    EpilepsyC_cat         = (Epilepsy=="Yes")              - cent_f$Epilepsy,
    COPDC_cat             = (COPD=="Yes")                  - cent_f$COPD,
    EduHSGrad2C_cat       = (Education=="Secondary school graduation") - cent_f$EduHSGrad,
    EduSomePS2C_cat       = (Education=="Some post-secondary")         - cent_f$EduSomePS,
    EduPSGrad2C_cat       = (Education=="Post-secondary graduation")   - cent_f$EduPSGrad,
    MSDivorcedC_cat       = (Marital_Status=="Divorced")               - cent_f$MSDivorced,
    MSWidowedC_cat        = (Marital_Status=="Widowed")               - cent_f$MSWidowed,
    MSSingleC_cat         = (Marital_Status=="Single")                - cent_f$MSSingle,
    NeedHelp1C_cat = (Activities_Need_Help==1) - cent_f$NH1,
    NeedHelp2C_cat = (Activities_Need_Help==2) - cent_f$NH2,
    NeedHelp3C_cat = (Activities_Need_Help==3) - cent_f$NH3,
    NeedHelp4C_cat = (Activities_Need_Help==4) - cent_f$NH4,
    NeedHelp5C_cat = (Activities_Need_Help==5) - cent_f$NH5,
    NeedHelp6C_cat = (Activities_Need_Help==6) - cent_f$NH6
  )

# Add interaction terms
df_m <- df_m %>%
  mutate(
    AgeCXPackYearsC_int        = Age_c * Pack_c,
    AgeCXSmokeFormer5PlusC_int = Age_c * SmokeFormer5PlusC_cat,
    AgeCXSmokeFormer0to5C_int  = Age_c * SmokeFormer0to5C_cat,
    AgeCXSmokeCurrentC_int     = Age_c * SmokeCurrentC_cat,
    AgeCXDrinksLastWeekC_int   = Age_c * Drink_c,
    AgeCXFormerDrinkerC_int    = Age_c * FormerDrinkerC_cat,
    AgeCXFruitVegC_int         = Age_c * FV_c,
    AgeCXPhysicalActivityC_int = Age_c * PA_c,
    AgeCXCOPDC_int             = Age_c * COPDC_cat,
    AgeCXHeartDisC_int         = Age_c * HeartDisC_cat,
    AgeCXStrokeC_int           = Age_c * StrokeC_cat,
    AgeCXDiabetesC_int         = Age_c * DiabetesC_cat,
    AgeCXMoodC_int             = Age_c * MoodC_cat,
    AgeCXHypertensionC_int     = Age_c * HypertensionC_cat,
    AgeCXBMIC_int              = Age_c * BMI_c,
    AgeCXNeedHelp1C_int        = Age_c * NeedHelp1C_cat,
    AgeCXNeedHelp2C_int        = Age_c * NeedHelp2C_cat,
    AgeCXNeedHelp3C_int        = Age_c * NeedHelp3C_cat,
    AgeCXNeedHelp4C_int        = Age_c * NeedHelp4C_cat,
    AgeCXNeedHelp5C_int        = Age_c * NeedHelp5C_cat,
    AgeCXNeedHelp6C_int        = Age_c * NeedHelp6C_cat
  )

df_f <- df_f %>%
  mutate(
    AgeCXPackYearsC_int        = Age_c * Pack_c,
    AgeCXSmokeFormer5PlusC_int = Age_c * SmokeFormer5PlusC_cat,
    AgeCXSmokeFormer0to5C_int  = Age_c * SmokeFormer0to5C_cat,
    AgeCXSmokeCurrentC_int     = Age_c * SmokeCurrentC_cat,
    AgeCXDrinksLastWeekC_int   = Age_c * Drink_c,
    AgeCXFormerDrinkerC_int    = Age_c * FormerDrinkerC_cat,
    AgeCXFruitVegC_int         = Age_c * FV_c,
    AgeCXPhysicalActivityC_int = Age_c * PA_c,
    AgeCXCOPDC_int             = Age_c * COPDC_cat,
    AgeCXHeartDisC_int         = Age_c * HeartDisC_cat,
    AgeCXStrokeC_int           = Age_c * StrokeC_cat,
    AgeCXDiabetesC_int         = Age_c * DiabetesC_cat,
    AgeCXMoodC_int             = Age_c * MoodC_cat,
    AgeCXHypertensionC_int     = Age_c * HypertensionC_cat,
    AgeCXEpilepsyC_int         = Age_c * EpilepsyC_cat,
    AgeCXBMIC_int              = Age_c * BMI_c,
    AgeCXNeedHelp1C_int        = Age_c * NeedHelp1C_cat,
    AgeCXNeedHelp2C_int        = Age_c * NeedHelp2C_cat,
    AgeCXNeedHelp3C_int        = Age_c * NeedHelp3C_cat,
    AgeCXNeedHelp4C_int        = Age_c * NeedHelp4C_cat,
    AgeCXNeedHelp5C_int        = Age_c * NeedHelp5C_cat,
    AgeCXNeedHelp6C_int        = Age_c * NeedHelp6C_cat
  )

# Spline‐expand the centred cont’s:
df_m_spl <- bind_cols(
  df_m,
  make_splines(df_m$Age_c,   knots_m$AgeC,            "AgeC"),
  make_splines(df_m$Pack_c,  knots_m$PackYearsC,      "PackYearsC"),
  make_splines(df_m$Drink_c, knots_m$DrinksLastWeekC, "DrinksLastWeekC"),
  make_splines(df_m$FV_c,    knots_m$FruitVegC,       "FruitVegC"),
  make_splines(df_m$PA_c,    knots_m$PhysicalActivityC,"PhysicalActivityC"),
  make_splines(df_m$BMI_c,   knots_m$BMIC,            "BMIC")
)
df_f_spl <- bind_cols(
  df_f,
  make_splines(df_f$Age_c,   knots_f$AgeC,            "AgeC"),
  make_splines(df_f$Pack_c,  knots_f$PackYearsC,      "PackYearsC"),
  make_splines(df_f$Drink_c, knots_f$DrinksLastWeekC, "DrinksLastWeekC"),
  make_splines(df_f$FV_c,    knots_f$FruitVegC,       "FruitVegC"),
  make_splines(df_f$PA_c,    knots_f$PhysicalActivityC,"PhysicalActivityC"),
  make_splines(df_f$BMI_c,   knots_f$BMIC,            "BMIC")
)

df_spl <- bind_rows(df_m_spl, df_f_spl)

# β‐vectors
beta_m <- c(
  AgeC_rcs1 =  0.187761068, AgeC_rcs2 = -0.217650805,
  AgeC_rcs3 =  0.508558798, AgeC_rcs4 = -0.629083588,
  EthnSEAsian4C_cat = -0.613728468, EthnOther4C_cat = 0.020330101,
  EthnSWAsian4C_cat = -0.415853824, MultilingualC_cat = 0.066602120,
  StressNotVeryC_cat = -0.011475124, StressABitC_cat = 0.122988924,
  StressQuiteC_cat = 0.226566025, StressExtremelyC_cat = 0.241430647,
  SRHealthPoorC_cat = 0.032454228, SRHealthFairC_cat = 0.173588064,
  SRHealthGoodC_cat = 0.154652620, SRHealthVGoodC_cat = 0.103639855,
  PackYearsC_rcs1 = -0.007538736, PackYearsC_rcs2 = 0.015230383,
  SmokeFormer5PlusC_cat = 0.042471004, SmokeFormer0to5C_cat = -0.048161163,
  SmokeCurrentC_cat = 0.094669893, FormerDrinkerC_cat = 0.127400898,
  DrinksLastWeekC_rcs1 = -0.015677555, DrinksLastWeekC_rcs2 = 0.058555464,
  FruitVegC_rcs1 = -0.064186910, FruitVegC_rcs2 = 0.073403255,
  PhysicalActivityC_rcs1 = -0.055754756, PhysicalActivityC_rcs2 = 0.038475324,
  COPDC_cat = -0.093301802, HeartDisC_cat = -0.139571534,
  StrokeC_cat = 0.437790265, DiabetesC_cat = 0.145147156,
  MoodC_cat = 0.187227029, HypertensionC_cat = -0.082890932,
  BMIC_rcs1 = -0.019794479, BMIC_rcs2 = 0.009216159,
  NeedHelp1C_cat = 0.450023168, NeedHelp2C_cat = 0.202616363,
  NeedHelp3C_cat = 0.333814021, NeedHelp4C_cat = 0.475480250,
  NeedHelp5C_cat = 0.815997542, NeedHelp6C_cat = 0.238077031,
  AgeCXPackYearsC_int = 0.000028995,
  AgeCXSmokeFormer5PlusC_int = -0.007018043,
  AgeCXSmokeFormer0to5C_int  = -0.005431465,
  AgeCXSmokeCurrentC_int     = -0.008428458,
  AgeCXDrinksLastWeekC_int   = 0.000612868,
  AgeCXFormerDrinkerC_int    = 0.000063706,
  AgeCXFruitVegC_int         = 0.001340961,
  AgeCXPhysicalActivityC_int = 0.001926513,
  AgeCXCOPDC_int             = -0.011006979,
  AgeCXHeartDisC_int         = -0.001031514,
  AgeCXStrokeC_int           = -0.005902235,
  AgeCXDiabetesC_int         = -0.009620360,
  AgeCXMoodC_int             = -0.011586927,
  AgeCXHypertensionC_int     = -0.008981298,
  AgeCXBMIC_int              = 0.000453647,
  AgeCXNeedHelp1C_int        = -0.020141545,
  AgeCXNeedHelp2C_int        = -0.008129332,
  AgeCXNeedHelp3C_int        = -0.011319569,
  AgeCXNeedHelp4C_int        = -0.035552059,
  AgeCXNeedHelp5C_int        = -0.036987918,
  AgeCXNeedHelp6C_int        = -0.030839803
)
beta_f <- c(
  AgeC_rcs1 =  0.245279263, AgeC_rcs2 = -0.59957265,
  AgeC_rcs3 =  1.106105622, AgeC_rcs4 = -0.835209921,
  MSDivorcedC_cat = 0.106533382, MSWidowedC_cat = 0.054321533,
  MSSingleC_cat = 0.088459004,
  EduHSGrad2C_cat = -0.066693097, EduSomePS2C_cat = -0.126138518,
  EduPSGrad2C_cat = -0.109690884,
  StressNotVeryC_cat = -0.070428472, StressABitC_cat = 0.021273964,
  StressQuiteC_cat = 0.07269401, StressExtremelyC_cat = 0.122294467,
  PackYearsC_rcs1 = 0.00696192, PackYearsC_rcs2 = -0.052875288,
  SmokeFormer5PlusC_cat = 0.02632212, SmokeFormer0to5C_cat = 0.123883776,
  SmokeCurrentC_cat = 0.039406677, FormerDrinkerC_cat = 0.131370158,
  DrinksLastWeekC_rcs1 = -0.028630605, DrinksLastWeekC_rcs2 = 0.027864201,
  FruitVegC_rcs1 = -0.064852024, FruitVegC_rcs2 = 0.040922731,
  PhysicalActivityC_rcs1 = -0.046545656, PhysicalActivityC_rcs2 = 0.065910843,
  COPDC_cat = -0.18354168, HeartDisC_cat = 0.067801038,
  StrokeC_cat = 0.368505128, DiabetesC_cat = 0.40951651,
  MoodC_cat = 0.304972654, HypertensionC_cat = -0.004768246,
  EpilepsyC_cat = 0.357291218,
  BMIC_rcs1 = -0.041788926, BMIC_rcs2 = 0.018017794,
  NeedHelp1C_cat = 0.259410494, NeedHelp2C_cat = 0.39347433,
  NeedHelp3C_cat = 0.475296526, NeedHelp4C_cat = 0.466321125,
  NeedHelp5C_cat = 0.33186687,  NeedHelp6C_cat = 0.628219989,
  AgeCXPackYearsC_int = -0.000155971,
  AgeCXSmokeFormer5PlusC_int = 0.002122531,
  AgeCXSmokeFormer0to5C_int  = -0.007432523,
  AgeCXSmokeCurrentC_int     = -0.01222868,
  AgeCXDrinksLastWeekC_int   = 0.0000386,
  AgeCXFormerDrinkerC_int    = -0.005918187,
  AgeCXFruitVegC_int         = 0.001669135,
  AgeCXPhysicalActivityC_int = -0.001253917,
  AgeCXCOPDC_int             = -0.006717978,
  AgeCXHeartDisC_int         = -0.018081279,
  AgeCXStrokeC_int           = 0.000146041,
  AgeCXDiabetesC_int         = -0.024582615,
  AgeCXMoodC_int             = -0.002786065,
  AgeCXHypertensionC_int     = -0.013929878,
  AgeCXEpilepsyC_int         = -0.034946372,
  AgeCXBMIC_int              = 0.000671524,
  AgeCXNeedHelp1C_int        = -0.024609867,
  AgeCXNeedHelp2C_int        = -0.016608818,
  AgeCXNeedHelp3C_int        = -0.036957964,
  AgeCXNeedHelp4C_int        = -0.025498419,
  AgeCXNeedHelp5C_int        = -0.023488379,
  AgeCXNeedHelp6C_int        = -0.060376248
)

# Baseline hazards
h0 <- c(Male=0.03026372, Female=0.08718073)
h0_m_dementia <- 0.03026372
h0_f_dementia <- 0.08718073
  
# --------------------------------------------------
# 10. DemPoRT 5-year risk calculation
# --------------------------------------------------

# Men and women β-vectors into named list
beta_list <- list(Male = beta_m, Female = beta_f)

# Zero-pad any predictors that one sex has but the other doesn’t
all_preds     <- union(names(beta_m), names(beta_f))
missing_preds <- setdiff(all_preds, names(df_spl))
df_spl_full   <- df_spl
for(col in missing_preds) df_spl_full[[col]] <- 0

# Rowwise linear predictor and 5-year risk
library(dplyr)

# Pre-compute each sex’s linear predictor (Score)
#   * Grab the design matrices
Xm <- as.matrix(df_spl_full[ , names(beta_m)])
Xf <- as.matrix(df_spl_full[ , names(beta_f)])

#   * Matrix-multiply by the β-vectors
lp_m <- as.numeric(Xm %*% beta_m)
lp_f <- as.numeric(Xf %*% beta_f)

# Combine into one data frame with Score + Risk5yr
df_risk <- df_spl_full %>%
  mutate(
    Score   = if_else(Sex=="Male",   lp_m, lp_f),
    Risk5yr = 1 - exp(- h0[Sex] * exp(Score))
  )

calculate_DemPoRT_risk <- function(df_spl){
  # ensure every predictor in beta_m/beta_f is present
  all_preds     <- union(names(beta_m), names(beta_f))
  missing_preds <- setdiff(all_preds, names(df_spl))
  df_full <- df_spl
  for(col in missing_preds) df_full[[col]] <- 0
  
  # build each sex’s design matrix
  Xm <- as.matrix(df_full[ , names(beta_m)])
  Xf <- as.matrix(df_full[ , names(beta_f)])
  
  # linear predictors
  lp_m <- as.numeric(Xm %*% beta_m)
  lp_f <- as.numeric(Xf %*% beta_f)
  
  # compute Score & 5-year risk
  df_full %>%
    mutate(
      Score   = if_else(Sex=="Male", lp_m, lp_f),
      Risk5yr = 1 - exp(- h0[Sex] * exp(Score))
    )
}
df_risk <- calculate_DemPoRT_risk(df_spl)

# --------------------------------------------------
# 11. Tidy, summarize & save your DemPoRT dataset
# --------------------------------------------------

# Summary of the new DemPoRT 5-year risk
cat("Summary of DemPoRT 5-Year Risk:\n")
print(summary(df_risk$Risk5yr))

# Label variable groups for export
raw_vars <- names(synthetic_full)
centered_vars <- names(df_spl)[
  grepl("_c$|_cat$", names(df_spl)) & !grepl("int$", names(df_spl))
]
spline_vars <- names(df_spl)[grepl("_rcs", names(df_spl))]
interaction_vars <- names(df_spl)[grepl("_int$", names(df_spl))]

# Final ordered variable list
final_order <- c(
  "Sex",
  centered_vars,
  spline_vars,
  interaction_vars,
  "Score", "Risk5yr"
)

simulation_dataset_final_DemPoRT <- df_risk %>%
  dplyr::select(all_of(names(df_spl_full)), Score, Risk5yr)

writexl::write_xlsx(
  simulation_dataset_final_DemPoRT,
  "simulation_dataset_final_DemPoRT.xlsx"
)

# --------------------------------------------------
# 12. Run example
# --------------------------------------------------

library(dplyr)
example_patient <- tibble(
  Sex                = "Female",
  Age                 = 75,
  Stress              = "A bit",             # from “Considers life a bit stressful”
  Smoking_Status      = "Former>=5y",
  PackYears           = 20,
  Drinks_Last_Week    = 2,
  Former_Drinker      = "Yes",
  FruitVeg            = 5,
  METs_Leisure        = 1.61,                # set = mean so spline basis ≈ 0
  Activities_Need_Help= 1,                   # needs help managing finances
  Education           = "Secondary school graduation",
  Heart_Disease       = "No",
  Stroke              = "No",
  Diabetes            = "Yes",
  Mood_Disorder       = "No",
  High_BP             = "Yes",
  Epilepsy            = "No",
  COPD                = "No",
  BMI                 = 30
)

# Center + dummy‐encode (using cent_f, knots_f, etc)
example_spl <- example_patient %>%
  mutate(
    Age_c    = Age   - cent_f$Age,
    Pack_c   = PackYears        - cent_f$PackYears,
    Drink_c  = Drinks_Last_Week - cent_f$Drinks,
    FV_c     = FruitVeg         - cent_f$FruitVeg,
    PA_c     = METs_Leisure     - cent_f$PA,
    BMI_c    = BMI              - cent_f$BMI,
    
    StressNotVeryC_cat   = (Stress=="Not very")    - cent_f$StressNotVery,
    StressABitC_cat      = (Stress=="A bit")       - cent_f$StressABit,
    StressQuiteC_cat     = (Stress=="Quite a bit") - cent_f$StressQuite,
    StressExtremelyC_cat = (Stress=="Extremely")   - cent_f$StressExtremely,
    
    SmokeFormer5PlusC_cat = (Smoking_Status=="Former>=5y") - cent_f$SmokeFormer5Plus,
    SmokeFormer0to5C_cat  = (Smoking_Status=="Former<5y")  - cent_f$SmokeFormer0to5,
    SmokeCurrentC_cat     = (Smoking_Status=="Current")    - cent_f$SmokeCurrent,
    FormerDrinkerC_cat    = (Former_Drinker=="Yes")     - cent_f$FormerDrinker,
    
    HeartDisC_cat     = (Heart_Disease=="Yes")      - cent_f$HeartDisease,
    StrokeC_cat       = (Stroke=="Yes")             - cent_f$Stroke,
    DiabetesC_cat     = (Diabetes=="Yes")           - cent_f$Diabetes,
    MoodC_cat         = (Mood_Disorder=="Yes")      - cent_f$Mood,
    HypertensionC_cat = (High_BP=="Yes")            - cent_f$Hypertension,
    EpilepsyC_cat     = (Epilepsy=="Yes")           - cent_f$Epilepsy,
    COPDC_cat         = (COPD == "Yes")             - cent_f$COPD,
    
    EduHSGrad2C_cat = (Education=="Secondary school graduation") - cent_f$EduHSGrad,
    EduSomePS2C_cat = (Education=="Some post-secondary")         - cent_f$EduSomePS,
    EduPSGrad2C_cat = (Education=="Post-secondary graduation")   - cent_f$EduPSGrad,
    
    NeedHelp1C_cat = (Activities_Need_Help==1) - cent_f$NH1,
    NeedHelp2C_cat = (Activities_Need_Help==2) - cent_f$NH2,
    NeedHelp3C_cat = (Activities_Need_Help==3) - cent_f$NH3,
    NeedHelp4C_cat = (Activities_Need_Help==4) - cent_f$NH4,
    NeedHelp5C_cat = (Activities_Need_Help==5) - cent_f$NH5,
    NeedHelp6C_cat = (Activities_Need_Help==6) - cent_f$NH6,
    
    # Add interactions
    AgeCXPackYearsC_int        = Age_c * Pack_c,
    AgeCXSmokeFormer5PlusC_int = Age_c * SmokeFormer5PlusC_cat,
    AgeCXSmokeFormer0to5C_int  = Age_c * SmokeFormer0to5C_cat,
    AgeCXSmokeCurrentC_int     = Age_c * SmokeCurrentC_cat,
    AgeCXDrinksLastWeekC_int   = Age_c * Drink_c,
    AgeCXFormerDrinkerC_int    = Age_c * FormerDrinkerC_cat,
    AgeCXFruitVegC_int         = Age_c * FV_c,
    AgeCXPhysicalActivityC_int = Age_c * PA_c,
    AgeCXCOPDC_int             = Age_c * COPDC_cat,
    AgeCXHeartDisC_int         = Age_c * HeartDisC_cat,
    AgeCXStrokeC_int           = Age_c * StrokeC_cat,
    AgeCXDiabetesC_int         = Age_c * DiabetesC_cat,
    AgeCXMoodC_int             = Age_c * MoodC_cat,
    AgeCXHypertensionC_int     = Age_c * HypertensionC_cat,
    AgeCXEpilepsyC_int         = Age_c * EpilepsyC_cat,
    AgeCXBMIC_int              = Age_c * BMI_c,
    AgeCXNeedHelp1C_int        = Age_c * NeedHelp1C_cat,
    AgeCXNeedHelp2C_int        = Age_c * NeedHelp2C_cat,
    AgeCXNeedHelp3C_int        = Age_c * NeedHelp3C_cat,
    AgeCXNeedHelp4C_int        = Age_c * NeedHelp4C_cat,
    AgeCXNeedHelp5C_int        = Age_c * NeedHelp5C_cat,
    AgeCXNeedHelp6C_int        = Age_c * NeedHelp6C_cat
  ) %>%
  # Spline‐expand centred continuous vars
  bind_cols(
    make_splines(.$Age_c,   knots_f$AgeC,            "AgeC"),
    make_splines(.$Pack_c,  knots_f$PackYearsC,      "PackYearsC"),
    make_splines(.$Drink_c, knots_f$DrinksLastWeekC, "DrinksLastWeekC"),
    make_splines(.$FV_c,    knots_f$FruitVegC,       "FruitVegC"),
    make_splines(.$PA_c,    knots_f$PhysicalActivityC,"PhysicalActivityC"),
    make_splines(.$BMI_c,   knots_f$BMIC,            "BMIC")
  )

# Call risk function
result <- calculate_DemPoRT_risk(example_spl)

# Inspect the one‐row output:
result[, c("Score", "Risk5yr")]

# Convert h0 to 5-year baseline survival (S0 = exp(−h0)):
S0_male   <- exp(-h0_m_dementia)   # ≈ 0.9702
S0_female <- exp(-h0_f_dementia)   # ≈ 0.9165

# ----------------------------------------------------------------
# 13. HH Risk Calculator integration 
# ----------------------------------------------------------------

library(readxl)
library(tidyr)
library(purrr)
library(dplyr)

# 13a. Read sHR sheet, compute log-betas, & add RR
shr_path <- file.path("Model inputs", "DemPoRT_sHR_raw.xlsx")

hr_raw <- read_excel(path = shr_path, sheet = "Sheet1") %>%
  rename(FactorName = `Factor name in model`, Var = Factor) %>%
  mutate(
    beta = log(sHR),
    S0   = if_else(Sex == "Male", S0_male, S0_female),
    RR   = dplyr::case_when(
      grepl("^REF_", FactorName) ~ 1,
      is.na(sHR)                 ~ NA_real_,
      TRUE                       ~ (1 - S0^(sHR)) / (1 - S0)
    )
  )

# write back to the same Excel file, appending RR as a new column on Sheet1
writexl::write_xlsx(list("Sheet1" = dplyr::select(hr_raw, -S0)), path = shr_path)

# 13b. Continuous‐only RRs via RCS splines
# Extract only the spline rows
hr_cont <- hr_raw %>% filter(grepl("_rcs[0-9]+$", FactorName))

# Pivot to get one beta per spline term, by sex
beta_wide <- hr_cont %>%
  dplyr::select(Sex, FactorName, beta) %>%
  tidyr::pivot_wider(names_from = FactorName, values_from = beta, values_fill = list(beta = 0))

beta_m_cont <- beta_wide %>% filter(Sex=="Male")   %>% dplyr::select(-Sex) %>% unlist()
beta_f_cont <- beta_wide %>% filter(Sex=="Female") %>% dplyr::select(-Sex) %>% unlist()

# Ensure df_spl_full has all those columns
all_cont_preds <- union(names(beta_m_cont), names(beta_f_cont))
for(col in setdiff(all_cont_preds, names(df_spl_full))) {
  df_spl_full[[col]] <- 0
}

# Compute continuous score & RR_cont
Xm <- as.matrix(df_spl_full[, names(beta_m_cont)])
Xf <- as.matrix(df_spl_full[, names(beta_f_cont)])

df_hh <- df_spl_full %>%
  mutate(
    Score_cont = if_else(
      Sex == "Male",
      as.numeric(Xm %*% beta_m_cont),
      as.numeric(Xf %*% beta_f_cont)
    ),
    RR_cont = exp(Score_cont)
  )

# 13c. Categorical factors → RR_cat via CIF
hr_cat <- hr_raw %>%
  filter(grepl("_cat$", FactorName) | grepl("^REF_", FactorName))

cat_rr <- hr_cat %>%
  mutate(
    S0      = if_else(Sex=="Male", S0_male, S0_female),
    CIF_ref = 1 - S0^1,                 # baseline CIF for reference (LP=0)
    CIF_exp = 1 - S0^exp(beta),         # CIF at this category’s beta
    RR_cat  = CIF_exp / CIF_ref         # relative risk for this category
  ) %>%
  dplyr::select(
    Var,            
    Answer,         
    Sex,
    RR_cat
  )

# 13d. Attach each categorical RR (making REF_ → RR=1)

# Define the list of categorical variable names
cat_vars <- intersect(unique(cat_rr$Var), names(synthetic_full))

# Re-attach the raw factor columns for lookup
for (v in cat_vars) {
  df_hh[[v]] <- synthetic_full[[v]]
}

# Force them to character so the paste0 lookup works
df_hh <- df_hh %>%
  mutate(across(all_of(cat_vars), as.character))

# Build each <Var>_RR column from lookup table
for (v in cat_vars) {
  lookup   <- filter(cat_rr, Var == v)
  keys     <- paste0(df_hh$Sex, "|", df_hh[[v]])
  ref_keys <- paste0(lookup$Sex, "|", lookup$Answer)
  rr_vals  <- lookup$RR_cat[match(keys, ref_keys)]
  rr_vals[is.na(rr_vals)] <- 1
  df_hh[[paste0(v, "_RR")]] <- rr_vals
}

# CIR_cat will be the product of those *_RR columns
rr_cols <- paste0(cat_vars, "_RR")
df_hh <- df_hh %>%
  rowwise() %>%
  mutate(CIR_cat = prod(c_across(all_of(rr_cols)), na.rm = TRUE)) %>%
  ungroup()

# 13e. Aggregate & finish

# Population-average continuous RR
PR_cont <- df_hh %>%
  group_by(Sex) %>%
  summarise(PR_cont = mean(RR_cont, na.rm=TRUE), .groups="drop")

# Recompute CIR_cat, join PR_cont, and calculate all HH metrics
df_hh <- df_hh %>%
  rowwise() %>%
  mutate(CIR_cat = prod(c_across(all_of(rr_cols)), na.rm = TRUE)) %>%
  ungroup() %>%
  left_join(PR_cont, by = "Sex") %>%
  mutate(
    CIR_all       = CIR_cat * RR_cont,
    PR_all        = PR_cont,
    RR_all        = CIR_all / PR_all,
    h0            = if_else(Sex == "Male", -log(S0_male), -log(S0_female)),
    HH_Incidence  = h0 * RR_all,
    HH_Survival   = exp(-HH_Incidence),
    HH_CIR        = 1 - HH_Survival
  )

# Define export column ordering
raw_vars <- c(
  "Sex", "Age", "PackYears", "Drinks_Last_Week", "FruitVeg", "METs_Leisure", "BMI",
  "Stress", "Smoking_Status", "Former_Drinker", "Heart_Disease", "Stroke",
  "Diabetes", "Mood_Disorder", "High_BP", "COPD", "Self_Rated_Health",
  "Activities_Need_Help", "Ethnicity", "Multilingualism",
  "Education", "Epilepsy", "Marital_Status"
)
demo_outputs <- c("DemPoRT_Score", "DemPoRT_Risk5yr")
hh_metrics   <- c("CIR_cat", "PR_cont", "CIR_all", "PR_all", "RR_all", "HH_Incidence", "HH_Survival", "HH_CIR")
export_cols  <- c(raw_vars, demo_outputs, hh_metrics)

# Build and export final dataset
combined <- bind_cols(
  synthetic_full %>% dplyr::select(all_of(raw_vars)),
  tibble(
    DemPoRT_Score   = df_risk$Score,
    DemPoRT_Risk5yr = df_risk$Risk5yr
  ),
  df_hh %>% dplyr::select(all_of(hh_metrics))
)

simulation_dataset_final_HH_DemPoRT <- combined %>%
  dplyr::select(all_of(export_cols))

writexl::write_xlsx(
  simulation_dataset_final_HH_DemPoRT,
  "simulation_dataset_final_HH_DemPoRT.xlsx"
)

# --------------------------------------------------
# 14. Prepare sim_data with risk scores & HH outputs
# --------------------------------------------------

sim_data <- simulation_dataset_final_HH_DemPoRT

# --------------------------------------------------
# 15. Summary statistics for key scores
# --------------------------------------------------
risk_scores <- sim_data %>%
  dplyr::select(DemPoRT_Risk5yr, HH_CIR, HH_Incidence, HH_Survival)

# 1) Five-number summary + mean
print(summary(risk_scores))

# 2) Standard deviation
print(sapply(risk_scores, sd, na.rm = TRUE))

# --------------------------------------------------
# 17. Create plots comparing DemPoRT vs. HH metrics
# --------------------------------------------------
library(tidyr)
library(ggplot2)
library(scales)

# 1) Gather into long form, drop NAs
risk_data_full <- sim_data %>%
  dplyr::select(DemPoRT_Risk5yr, HH_CIR, HH_Incidence, HH_Survival) %>%
  pivot_longer(cols = everything(), names_to  = "Risk_Model", values_to = "Risk_Value") %>%
  filter(!is.na(Risk_Value))

# 2) Axis limits & breaks
x_min    <- 0.0
x_max    <- 1.0
x_breaks <- seq(x_min, x_max, by = 0.1)

# A) Boxplot
ggplot(risk_data_full, aes(Risk_Model, Risk_Value, fill = Risk_Model)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(x_min, x_max)) +
  scale_y_continuous(breaks = x_breaks) +
  labs(title = "Risk Estimates by Model (Boxplot)", x = NULL, y = "Risk") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# B) Faceted histogram
ggplot(risk_data_full, aes(Risk_Value, fill = Risk_Model)) +
  geom_histogram(binwidth = 0.01, boundary = 0, alpha = 0.7) +
  facet_wrap(~ Risk_Model, scales = "free_y", ncol = 1) +
  coord_cartesian(xlim = c(x_min, x_max)) +
  scale_x_continuous(breaks = x_breaks, labels = number_format(accuracy = 0.1)) +
  labs(title = "Distribution of Risk Estimates by Model", x = "Risk", y = "Frequency") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

# C) Overlaid density
ggplot(risk_data_full, aes(Risk_Value, color = Risk_Model)) +
  geom_density(linewidth = 1.2, na.rm = TRUE) +
  coord_cartesian(xlim = c(x_min, x_max)) +
  scale_x_continuous(breaks = x_breaks, labels = number_format(accuracy = 0.1)) +
  labs(title = "Density of Risk Estimates by Model", x = "Risk", y = "Density") +
  theme_minimal(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "right")

# --------------------------------------------------
# 18. Descriptive statistics on continuous variables
# --------------------------------------------------
descriptive_stats <- sim_data %>%
  dplyr::select(Age, PackYears, Drinks_Last_Week, FruitVeg, METs_Leisure, BMI) %>%
  pivot_longer(
    cols      = everything(),
    names_to  = "Variable",
    values_to = "Value"
  ) %>%
  group_by(Variable) %>%
  summarise(
    Mean   = mean(Value,   na.rm = TRUE),
    SD     = sd(Value,     na.rm = TRUE),
    Min    = min(Value,    na.rm = TRUE),
    Median = median(Value, na.rm = TRUE),
    Max    = max(Value,    na.rm = TRUE),
    IQR    = IQR(Value,    na.rm = TRUE),
    .groups = "drop"
  )

print(descriptive_stats)

writexl::write_xlsx(
  descriptive_stats,
  "Descriptive_Statistics_Continuous_Variables.xlsx"
)