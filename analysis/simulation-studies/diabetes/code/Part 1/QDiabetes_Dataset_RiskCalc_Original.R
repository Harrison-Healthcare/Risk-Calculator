# ──────────────────────────────── 0. SETUP ─────────────────────────────── #
# (install conflicted once if needed)
if (!requireNamespace("conflicted", quietly = TRUE)) {
  install.packages("conflicted")
}

library(conflicted)    # must come before conflict_prefer()
library(readxl)
library(dplyr)
library(tidyr)
library(writexl)
library(readr)

# prefer dplyr verbs when there are name conflicts
conflict_prefer("select",    "dplyr")
conflict_prefer("filter",    "dplyr")
conflict_prefer("arrange",   "dplyr")
conflict_prefer("mutate",    "dplyr")
conflict_prefer("summarise", "dplyr")

# ───────────────────────────── 1. WORKDIR ────────────────────────────── #
data_dir <- path.expand(
  "~/Research and Development/HealthChart/simulation risk calculator/Simulation Dataset QDiabetes vs HH_Diabetes/QDiabetes Data"
)
if (!dir.exists(data_dir)) stop("Directory not found: ", data_dir)
setwd(data_dir)

# ───────────────────────────── 2. CLEANING FN ─────────────────────────── #
clean_factor <- function(x) {
  x <- tolower(trimws(x))
  # strip footnote markers
  x <- gsub("[*†‡]", "", x)
  x <- gsub(" or ", "/", x, fixed = TRUE)
  x <- gsub("\\s+", " ", x)
  # normalize bipolar/schizophrenia in either order
  x <- gsub("bipolar[/ ]*schizophrenia.*", "bipolar or schizophrenia", x)
  x <- gsub("schizophrenia[/ ]*bipolar.*", "bipolar or schizophrenia", x)
  x <- gsub("white/not recorded", "white or not recorded", x, fixed = TRUE)
  x <- gsub("former smoker", "ex-smoker", x, fixed = TRUE)
  x <- gsub("polycystic ovary syndrome|polycystic ovary.*", "polycystic ovaries", x)
  x <- gsub("other ethnicity", "other", x, fixed = TRUE)
  x <- gsub("^men$", "male", x)
  x <- gsub("^women$", "female", x)
  x
}

# ───────────────────────────── 3. HR → RR10 ───────────────────────────── #
hr_raw <- bind_rows(
  read_excel("QDiabetes_HR_raw.xlsx", sheet = "Female") %>%
    mutate(sex = "F", factor_order = row_number()),
  read_excel("QDiabetes_HR_raw.xlsx", sheet = "Male") %>%
    mutate(sex = "M", factor_order = row_number())
) %>%
  mutate(factor = clean_factor(factor))

hr_long <- hr_raw %>%
  pivot_longer(
    cols         = starts_with("HR_"),
    names_to     = "model",
    names_prefix = "HR_",
    values_to    = "HR"
  )

S0_tbl <- tribble(
  ~sex, ~model, ~S0,
  "F",  "A",    0.986227273941040,
  "F",  "B",    0.990905702114105,
  "F",  "C",    0.988788545131683,
  "M",  "A",    0.978732228279114,
  "M",  "B",    0.985019445419312,
  "M",  "C",    0.981181740760803
)

# ─── Extract baseline survival for Model A once and for all ───
S0_A_F <- S0_tbl %>%
  filter(sex == "F", model == "A") %>%
  pull(S0)

S0_A_M <- S0_tbl %>%
  filter(sex == "M", model == "A") %>%
  pull(S0)

# ─── Extract baseline survival for Model B & C ────────────────────────────
S0_B_F <- S0_tbl %>% filter(sex == "F", model == "B") %>% pull(S0)
S0_B_M <- S0_tbl %>% filter(sex == "M", model == "B") %>% pull(S0)

S0_C_F <- S0_tbl %>% filter(sex == "F", model == "C") %>% pull(S0)
S0_C_M <- S0_tbl %>% filter(sex == "M", model == "C") %>% pull(S0)

# sanity check
message(
  "Baseline 10y survival:\n",
  "  Model A — F=", S0_A_F, "; M=", S0_A_M, "\n",
  "  Model B — F=", S0_B_F, "; M=", S0_B_M, "\n",
  "  Model C — F=", S0_C_F, "; M=", S0_C_M
)
flush.console()


convert_hr_to_rr <- function(hr, S0) {
  (1 - S0^hr) / (1 - S0)
}

hr_rr10 <- hr_long %>%
  left_join(S0_tbl, by = c("sex", "model")) %>%
  mutate(RR10 = convert_hr_to_rr(HR, S0)) %>%
  arrange(sex, factor_order, model) %>%
  select(factor, model, HR, sex, S0, RR10)


# ───────────────────────── 4.  READ & PROCESS PREVALENCE ───────────────────────── #
popchar <- read_excel("QDiabetes Population Characteristics.xlsx")
colnames(popchar) <- make.names(colnames(popchar))

# 1) Raw headers & continuous rows we never want here:
drop_headers <- c(
  "Total cohort",
  "Men", "Women",                # overall counts
  "Age (years)",
  "BMI recorded", "BMI (kg/m²)",
  "Fasting blood glucose recorded",
  "Fasting blood glucose (mmol/L)",
  "HbA1c recorded", "HbA1c (mmol/L)",
  "Complete data*", "Complete data†",
  "Ethnicity recorded", "Smoking recorded"
)

# 2) The exact factor names we have HRs for:
factors_hr      <- unique(hr_rr10$factor)
female_only     <- c("gestational diabetes", "polycystic ovaries")

# 3) Grab only the rows we care about (the % lines for those factors),
#    clean them, and compute prevalence:
pop_tmp <- popchar %>%
  filter(
    !Characteristic %in% drop_headers,
    !is.na(percent) & percent != ""
  ) %>%
  mutate(
    factor     = clean_factor(Characteristic),
    prevalence = as.numeric(percent) / 100
  ) %>%
  filter(factor %in% factors_hr)

# 4a) Female-only factors get a single “F” row:
pop_female <- pop_tmp %>%
  filter(factor %in% female_only) %>%
  mutate(sex = "F")

# 4b) All the other factors need both “M” and “F”:
pop_other <- pop_tmp %>%
  filter(!factor %in% female_only) %>%
  tidyr::expand(factor, sex = c("M","F")) %>%
  left_join(pop_tmp %>% select(factor, prevalence), by = "factor")

# 5) Put them back together, in the right order:
pop_prev <- bind_rows(pop_female, pop_other) %>%
  arrange(factor, sex)

# ────────────────── 6. MERGE & WRITE FINAL (unchanged) ─────────────────────── #
final <- hr_rr10 %>%
  left_join(pop_prev, by = c("factor","sex"))

write_xlsx(
  list(QDiabetes_HR_RR10_prevalence = final),
  "QDiabetes_HR_RR10_prevalence.xlsx"
)
write_csv(final, "QDiabetes_HR_RR10_prevalence.csv")

cat("✅ Merged HR→RR10 + prevalence written to QDiabetes_HR_RR10_prevalence.*\n")


###############################################################################
#  QDiabetes-style cohort simulator
#  • Continuous vars: age, BMI, fasting glucose, HbA1c
#  • Categorical  vars: smoking (5-level ordinal)
#  • Binary vars: famhist, htn, cvd, statin, apsych, steroid
###############################################################################

## ───────────────────────────── 0.  SET-UP ────────────────────────────── ##
# install.packages(c("copula","MASS","data.table"))  # once only
library(copula)     # Gaussian copula engine
library(MASS)       # for mvrnorm helpers
library(data.table) # fast in-memory + on-disk handling  (optional)

set.seed(2025)                         # reproducibility

# ------------------------------------------------------------------
# 1. COHORT SIZE  ← use plain integer literal
# ------------------------------------------------------------------
N <- 500000L      # 8,186,705 rows

## ───────────────────────────── 1.  INPUTS ────────────────────────────── ##
# 1A. Continuous means & SDs (BMJ Table 1)
mu <- c(
  age   = 44.9,   # years
  bmi   = 26.0,   # kg/m^2
  fbg   = 5.0,    # mmol/L
  hba1c = 37.2    # mmol/mol
)

sd <- c(
  age   = 15.3,
  bmi   = 5.0,
  fbg   = 0.6,
  hba1c = 4.5
)

# 1B. Correlation matrix (4 × 4, positive-definite)
cont_corr <- matrix(c(
  1.00,  0.20,  0.25,  0.25,   # age
  0.20,  1.00,  0.40,  0.35,   # BMI
  0.25,  0.40,  1.00,  0.80,   # fasting glucose
  0.25,  0.35,  0.80,  1.00    # HbA1c
), 4, 4, byrow = TRUE,
dimnames = list(names(mu), names(mu)))


## ─────────────────────── 2.  DRAW CONTINUOUS PART ───────────────────── ##
# 2A. Build Gaussian copula object
norm_cop <- normalCopula(P2p(cont_corr), dim = 4, dispstr = "un")
mv <- mvdc(
  copula = norm_cop,
  margins = rep("norm", 4),
  paramMargins = Map(function(m, s) list(mean = m, sd = s), mu, sd)
)

# 2B. Generate and truncate age to 25–84 y
cont <- as.data.frame(rMvdc(N, mv))
names(cont) <- names(mu)

# ─── clamp age ───────────────────────────
cont$age <- pmax(pmin(cont$age, 84), 25)

# ─── clamp FBG & HbA1c at the 1st–99th empirical percentiles ───
lower_fbg <- quantile(cont$fbg, probs = 0.01)
upper_fbg <- quantile(cont$fbg, probs = 0.99)
cont$fbg  <- pmin(pmax(cont$fbg, lower_fbg), upper_fbg)

lower_hba <- quantile(cont$hba1c, probs = 0.01)
upper_hba <- quantile(cont$hba1c, probs = 0.99)
cont$hba1c<- pmin(pmax(cont$hba1c, lower_hba), upper_hba)

# ─── recenter all the continuous vars ─────
cont$age   <- cont$age   - (mean(cont$age)   - mu["age"])
cont$bmi   <- cont$bmi   - (mean(cont$bmi)   - mu["bmi"])
cont$fbg   <- cont$fbg   - (mean(cont$fbg)   - mu["fbg"])
cont$hba1c <- cont$hba1c - (mean(cont$hba1c) - mu["hba1c"])


# ───────────────────────── 3. ASSEMBLE & TAG sim_qd ───────────────────────── #
library(data.table)
sim_qd <- as.data.table(cont)

# 3A) Ordinal smoking
smk_probs <- c(0.543, 0.186, 0.134, 0.059, 0.035)
sim_qd[, smoking := sample(1:5, .N, replace=TRUE, prob=smk_probs)]

# 3B) Assign sex per Table 1
sim_qd[, sex := sample(c("M","F"), .N, replace=TRUE, prob=c(0.496,0.504))]

# 3C) Marginal binaries
# map your internal names → prevalence‐table factor names
factor_map <- c(
  famhist = "family history of diabetes",
  htn     = "treated hypertension",
  cvd     = "cardiovascular disease",
  statin  = "statins",
  apsych  = "atypical antipsychotics",
  steroid = "corticosteroids"
)

for(var in names(factor_map)) {
  target <- factor_map[[var]]
  pF <- pop_prev %>% filter(factor==target, sex=="F") %>% pull(prevalence)
  pM <- pop_prev %>% filter(factor==target, sex=="M") %>% pull(prevalence)
  if(length(pF)!=1 || length(pM)!=1) stop("prevalence lookup failed for ", var)
  sim_qd[sex=="F", (var) := rbinom(.N, 1, pF)]
  sim_qd[sex=="M", (var) := rbinom(.N, 1, pM)]
}

# Optionally convert to data.table for speed & memory gains
sim_qd <- as.data.table(sim_qd)

# ─────────────────── ASSIGN SEX WITH TABLE 1 PROPORTIONS ─────────────────── #
# Table 1: 49.6% men, 50.4% women
sim_qd[, sex := sample(
  c("M","F"),         # male then female
  .N,
  replace = TRUE,
  prob    = c(0.496, 0.504)
)]

# define the vector of your binary columns
bin_vars <- c(
  "famhist", "htn", "cvd", "statin", "apsych", "steroid",
  "gestdiab", "pos",    "learning", "manicschiz"
)

# Quick sanity checks (sample)
print(table(sim_qd$sex) / nrow(sim_qd))
print(summary(sim_qd[, .(age, bmi, fbg, hba1c)]))
print(sapply(sim_qd[, names(bin_vars), with = FALSE], mean))
print(prop.table(table(sim_qd$smoking)))


# Save to disk – choose one
# fwrite(sim_qd, "synthetic_qdiabetes.csv.gz")
# arrow::write_parquet(sim_qd, "synthetic_qdiabetes.parquet")

# after sim_qd is created
data.table::fwrite(sim_qd, "synthetic_qdiabetes.csv.gz")


# ──────────────────── ADD THE FOUR MISSING BINARY FLAGS ───────────────────── #
# Ensure you have a 'sex' column (if not, create it however you want)
# e.g. sim_qd[, sex := sample(c("F","M"), .N, replace = TRUE)]

# 1) Gestational diabetes (female only)
p_gestaF <- pop_prev %>% 
  filter(factor == "gestational diabetes", sex == "F") %>% 
  pull(prevalence)
sim_qd[sex == "F",  gestdiab := rbinom(.N, 1, p_gestaF)]
sim_qd[sex == "M",  gestdiab := 0]

# 2) Polycystic ovaries (female only; named 'pos' in the C code)
p_pcoF <- pop_prev %>% 
  filter(factor == "polycystic ovaries", sex == "F") %>% 
  pull(prevalence)
sim_qd[sex == "F",  pos := rbinom(.N, 1, p_pcoF)]
sim_qd[sex == "M",  pos := 0]

# 3) Learning disability (both sexes)
p_learnF <- pop_prev %>% 
  filter(factor == "learning disability", sex == "F") %>% 
  pull(prevalence)
p_learnM <- pop_prev %>% 
  filter(factor == "learning disability", sex == "M") %>% 
  pull(prevalence)
sim_qd[sex == "F",  learning := rbinom(.N, 1, p_learnF)]
sim_qd[sex == "M",  learning := rbinom(.N, 1, p_learnM)]

# 4) Bipolar or schizophrenia (both sexes; 'manicschiz' in the C code)
p_bsF <- pop_prev %>% 
  filter(factor == "bipolar or schizophrenia", sex == "F") %>% 
  pull(prevalence)
p_bsM <- pop_prev %>% 
  filter(factor == "bipolar or schizophrenia", sex == "M") %>% 
  pull(prevalence)
sim_qd[sex == "F",  manicschiz := rbinom(.N, 1, p_bsF)]
sim_qd[sex == "M",  manicschiz := rbinom(.N, 1, p_bsM)]

# ──────────────────── ADD ETHNICITY + ethrisk INDEX ───────────────────── #
# 1) Define the 9 QDiabetes categories (cleaned factor names)
eth_levels <- c(
  "white or not recorded",
  "indian",
  "pakistani",
  "bangladeshi",
  "other asian",
  "caribbean",
  "black african",
  "chinese",
  "other"
)

# 2) Pre‐extract sex‐specific prevalence vectors (ordered as eth_levels)
p_ethF <- pop_prev %>%
  filter(factor %in% eth_levels, sex=="F") %>%
  arrange(match(factor, eth_levels)) %>%
  pull(prevalence)

p_ethM <- pop_prev %>%
  filter(factor %in% eth_levels, sex=="M") %>%
  arrange(match(factor, eth_levels)) %>%
  pull(prevalence)

# 3) Draw an 'ethnicity' string by sex
sim_qd[sex=="F", ethnicity := sample(eth_levels, .N, replace=TRUE, prob=p_ethF)]
sim_qd[sex=="M", ethnicity := sample(eth_levels, .N, replace=TRUE, prob=p_ethM)]

# 4) Map that to the 0–9 ethrisk index by matching into eth_levels:
#    (so 'white or not recorded' → 1, 'indian' → 2, … 'other' → 9)
sim_qd[, ethrisk := match(ethnicity, eth_levels)]

# Quick sanity check
print(table(sim_qd$gestdiab))
print(table(sim_qd$pos))
print(table(sim_qd$learning))
print(table(sim_qd$manicschiz))
print(table(sim_qd$ethnicity) / nrow(sim_qd))
print(table(sim_qd$ethrisk)    / nrow(sim_qd))

# ─────────────── QDiabetes Model A – Female ───────────────
risk_A_female <- function(
    age, bmi, town,
    ethrisk, smoke_cat,
    b_apsych, b_corticosteroids, b_cvd,
    b_gestdiab, b_learning, b_manicschiz, b_pos,
    b_statin, b_treatedhyp, fh_diab
) {
  S0 <- 0.986227273941040
  
  Iethrisk <- c(0,0,
                1.0695857881565456,1.3430172097414006,1.8029022579794518,
                1.1274654517708020,0.4214631490239910,0.2850919645908353,
                0.8815108797589199,0.3660573343168487
  )
  Ismoke   <- c(0,0.06560169017505906,0.2845098867369837,
                0.3567664381700702,0.5359517110678775)
  
  dage  <- age/10
  age1  <- dage^0.5 - 2.123332023620606
  age2  <- dage^3   - 91.64474487304688
  dbmi  <- bmi/10
  bmi1  <- dbmi     - 2.571253299713135
  bmi2  <- dbmi^3   - 16.999439239501953
  
  # re-introduce town, force to zero:
  townc <- 0
  
  a <- 0
  a <- a + Iethrisk[ethrisk + 1]
  a <- a + Ismoke[smoke_cat]
  
  # continuous
  a <- a + age1 *  4.3400852699139278
  a <- a + age2 * -0.0048771702696158879
  a <- a + bmi1 *  2.9320361259524925
  a <- a + bmi2 * -0.0474002058748434900
  
  # town effect
  a <- a + townc *  0.0373405696180491510
  
  # binary
  a <- a + b_apsych          * 0.5526764611098438
  a <- a + b_corticosteroids * 0.2679223368067460
  a <- a + b_cvd             * 0.1779722905458669
  a <- a + b_gestdiab        * 1.5248871531467574
  a <- a + b_learning        * 0.2783514358717272
  a <- a + b_manicschiz      * 0.2618085210917906
  a <- a + b_pos             * 0.3406173988206666
  a <- a + b_statin          * 0.6590728773280822
  a <- a + b_treatedhyp      * 0.4394758285813712
  a <- a + fh_diab           * 0.5313359456558734
  
  # interactions
  a <- a + age1  * b_apsych     * -0.8031518398316395
  a <- a + age1  * b_learning   * -0.8641596002882057
  a <- a + age1  * b_statin     * -1.9757776696583935
  a <- a + age1  * bmi1         *  0.6553138757562945
  a <- a + age1  * bmi2         * -0.03620965720163018
  a <- a + age1  * fh_diab      * -0.2641171450558896
  a <- a + age2  * b_apsych     *  0.000468404118102105
  a <- a + age2  * b_learning   *  0.000672496880895336
  a <- a + age2  * b_statin     *  0.002375053419434797
  a <- a + age2  * bmi1         * -0.004471966244526305
  a <- a + age2  * bmi2         *  0.0001185479967753342
  a <- a + age2  * fh_diab      *  0.0004161025828904768
  
  100 * (1 - S0^exp(a))
}


# ─────────────── QDiabetes Model A – Male ───────────────
risk_A_male <- function(
    age, bmi, town,
    ethrisk, smoke_cat,
    b_apsych, b_corticosteroids, b_cvd,
    b_learning, b_manicschiz, b_statin, b_treatedhyp, fh_diab
) {
  S0 <- 0.978732228279114
  
  Iethrisk <- c(0,0,
                1.1000230829124793,1.2903840126147210,1.6740908848727458,
                1.1400446789147816,0.4682468169065581,0.6990564996301545,
                0.6894365712711157,0.4172222846773821
  )
  Ismoke   <- c(0,0.1638740910548557,0.3185144911395898,
                0.3220726656778343,0.4505243716340953)
  
  dage  <- age/10
  age1  <- log(dage)        - 1.496392488479614
  age2  <- dage^3           - 89.04817199707031
  dbmi  <- bmi/10
  bmi1  <- (dbmi^2)         - 6.817805767059326
  bmi2  <- (dbmi^3)         - 17.801923751831055
  
  # re-introduce town term
  townc <- 0
  
  a <- 0
  a <- a + Iethrisk[ethrisk + 1]
  a <- a + Ismoke[smoke_cat]
  
  # continuous
  a <- a + age1 *  4.4642324388691348
  a <- a + age2 * -0.004075010801925557
  a <- a + bmi1 *  0.9512902786712068
  a <- a + bmi2 * -0.1435248827788548
  
  # town effect
  a <- a + townc *  0.025918182067678725
  
  # binary
  a <- a + b_apsych          * 0.42101092346005436
  a <- a + b_corticosteroids * 0.22183580932925384
  a <- a + b_cvd             * 0.20269605756290021
  a <- a + b_learning        * 0.23315321407986961
  a <- a + b_manicschiz      * 0.22770449520517727
  a <- a + b_statin          * 0.58490075431141342
  a <- a + b_treatedhyp      * 0.33379392183501078
  a <- a + fh_diab           * 0.64799284899369536
  
  # interactions
  a <- a + age1 * b_apsych     * -0.94637722268534152
  a <- a + age1 * b_learning   * -0.93842375526499833
  a <- a + age1 * b_statin     * -1.74790706530032990
  a <- a + age1 * bmi1         *  0.45147599241879766
  a <- a + age1 * bmi2         * -0.10795481262776381
  a <- a + age1 * fh_diab      * -0.60118530429301198
  a <- a + age2 * b_apsych     * -0.0000519927442172335
  a <- a + age2 * b_learning   *  0.0007102643855968814
  a <- a + age2 * b_statin     *  0.0013508364599531669
  a <- a + age2 * bmi1         * -0.0011797722394560309
  a <- a + age2 * bmi2         *  0.0002147150913931929
  a <- a + age2 * fh_diab      *  0.0004914185594087803
  
  100 * (1 - S0^exp(a))
}

# ──────────── APPLY MODEL A WITH TOWN ────────────── #
sim_qd[, `:=`(
  risk_A_f = risk_A_female(
    age        = age,
    bmi        = bmi,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_gestdiab         = gestdiab,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_pos              = pos,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  ),
  risk_A_m = risk_A_male(
    age        = age,
    bmi        = bmi,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  )
)]

# blank cross‐sex columns if you like
sim_qd[sex=="M", risk_A_f := NA_real_]
sim_qd[sex=="F", risk_A_m := NA_real_]

# write out
data.table::fwrite(sim_qd, "synthetic_qdiabetes_with_riskA.csv.gz")

# using data.table syntax
library(data.table)
# assume sim_qd is already a data.table
summary_riskA <- sim_qd[ , .(
  mean_risk_A_f = mean(risk_A_f, na.rm=TRUE),
  med_risk_A_f  = median(risk_A_f, na.rm=TRUE),
  mean_risk_A_m = mean(risk_A_m, na.rm=TRUE),
  med_risk_A_m  = median(risk_A_m, na.rm=TRUE)
)]

print(summary_riskA)

# ─────────────── QDiabetes Model B – Female ───────────────
risk_B_female <- function(
    age,          # years
    bmi,          # kg/m2
    fbg,          # fasting blood glucose (mmol/L)
    town,         # we’ll force this = 0
    ethrisk,      # 1–10
    smoke_cat,    # 1–5
    b_apsych, b_corticosteroids, b_cvd,
    b_gestdiab, b_learning, b_manicschiz, b_pos,
    b_statin, b_treatedhyp, fh_diab
){
  S0 <- 0.990905702114105
  
  Ieth <- c(
    0,0,
    0.9898906127239111, 1.2511504196326508, 1.4934757568196120,
    0.9673887434565966, 0.4844644519593178, 0.4784214955360103,
    0.7520946270805577, 0.4050880741541424
  )
  Ism <- c(0,0.037415630723696323,0.22529736725144828,
           0.30997364280236628,0.43619421394964175)
  
  dage  <- age/10
  age1  <- dage^0.5    - 2.123332023620606
  age2  <- dage^3      - 91.64474487304688
  dbmi  <- bmi/10
  bmi1  <- dbmi        - 2.571253299713135
  bmi2  <- dbmi^3      - 16.999439239501953
  dfbs  <- fbg
  fbs1  <- dfbs^-1     - 0.208309367299080
  fbs2  <- dfbs^-1*log(dfbs) - 0.326781362295151
  
  townc <- 0
  
  a <- 0
  # conditional
  a <- a + Ieth[ethrisk+1]
  a <- a + Ism[smoke_cat]
  
  # continuous
  a <- a + age1 *  3.7650129507517280
  a <- a + age2 * -0.0056043343436614941
  a <- a + bmi1 *  2.4410935031672469
  a <- a + bmi2 * -0.0421526334799096420
  a <- a + fbs1 * -2.1887891946337308
  a <- a + fbs2 * -69.96084198286603
  a <- a + townc * 0.03580462976631265
  
  # binary
  a <- a + b_apsych          * 0.47483785502538534
  a <- a + b_corticosteroids * 0.37679334437547285
  a <- a + b_cvd             * 0.19672615680665251
  a <- a + b_gestdiab        * 1.06893250336926470
  a <- a + b_learning        * 0.45422934089510347
  a <- a + b_manicschiz      * 0.16161718890842605
  a <- a + b_pos             * 0.35653657895767171
  a <- a + b_statin          * 0.58092873827186675
  a <- a + b_treatedhyp      * 0.28366320201229073
  a <- a + fh_diab           * 0.45221497662061116
  
  # interactions
  a <- a + age1 * b_apsych     * -0.76835916427865225
  a <- a + age1 * b_learning   * -0.79831281242975882
  a <- a + age1 * b_statin     * -1.90335088398332570
  a <- a + age1 * bmi1         *  0.48447476024049152
  a <- a + age1 * bmi2         * -0.031939988307181345
  a <- a + age1 * fbs1         *  2.24429030474043500
  a <- a + age1 * fbs2         * 13.00683886997830300
  a <- a + age1 * fh_diab      * -0.30406273740345013
  
  a <- a + age2 * b_apsych     *  0.00051944556244134762
  a <- a + age2 * b_learning   *  0.00030283275671618906
  a <- a + age2 * b_statin     *  0.00243971114060187110
  a <- a + age2 * bmi1         * -0.00415729766821540570
  a <- a + age2 * bmi2         *  0.00011268821942042522
  a <- a + age2 * fbs1         *  0.01993453085343125500
  a <- a + age2 * fbs2         * -0.07166771875293066800
  a <- a + age2 * fh_diab      *  0.00045236396712023254
  
  100 * (1 - S0^exp(a))
}


# ─────────────── QDiabetes Model B – Male ───────────────
risk_B_male <- function(
    age, bmi, fbg, town,
    ethrisk, smoke_cat,
    b_apsych, b_corticosteroids, b_cvd,
    b_learning, b_manicschiz,
    b_statin, b_treatedhyp, fh_diab
){
  S0 <- 0.985019445419312
  
  Ieth <- c(
    0,0,
    1.0081475800686235, 1.3359138425778705, 1.4815419524892652,
    1.0384996851820663, 0.5202348070887525, 0.8579673418258559,
    0.6413108960765616, 0.4838340220821505
  )
  Ism <- c(0,0.1119475792364163,0.3110132095412205,
           0.3328898469326042,0.4257069026941993)
  
  dage  <- age/10
  age1  <- log(dage)        - 1.4963924884796140
  age2  <- dage^3           - 89.04817199707031
  dbmi  <- bmi/10
  bmi1  <- dbmi^2           - 6.8178057670593260
  bmi2  <- dbmi^3           - 17.801923751831055
  dfbs  <- fbg
  fbs1  <- dfbs^(-0.5)      - 0.4480288326740260
  fbs2  <- dfbs^(-0.5)*log(dfbs) - 0.7194426059722900
  
  townc <- 0
  
  a <- 0
  a <- a + Ieth[ethrisk+1]
  a <- a + Ism[smoke_cat]
  
  # continuous
  a <- a + age1 *  4.1149143302364717
  a <- a + age2 * -0.0047593576668505362
  a <- a + bmi1 *  0.8169361587644297
  a <- a + bmi2 * -0.1250237740343336
  a <- a + fbs1 * -54.8417881280971070
  a <- a + fbs2 * -53.1120784984813600
  a <- a + townc *  0.0253741755198944
  
  # binary
  a <- a + b_apsych          * 0.44179340888895774
  a <- a + b_corticosteroids * 0.34135473483394541
  a <- a + b_cvd             * 0.21589774543727566
  a <- a + b_learning        * 0.40128850275853001
  a <- a + b_manicschiz      * 0.21817693913997793
  a <- a + b_statin          * 0.51476576001117347
  a <- a + b_treatedhyp      * 0.24672092874070373
  a <- a + fh_diab           * 0.57494373339875127
  
  # interactions
  a <- a + age1 * b_apsych     * -0.95022243138231266
  a <- a + age1 * b_learning   * -0.83583701630900453
  a <- a + age1 * b_statin     * -1.81417869192694600
  a <- a + age1 * bmi1         *  0.37484820920783846
  a <- a + age1 * bmi2         * -0.09098365795624874
  a <- a + age1 * fbs1         * 21.01173012176433400
  a <- a + age1 * fbs2         * 23.82446004474697400
  a <- a + age1 * fh_diab      * -0.67806477052916658
  
  a <- a + age2 * b_apsych     *  0.00014729720771628743
  a <- a + age2 * b_learning   *  0.00060129192649664091
  a <- a + age2 * b_statin     *  0.00163934849114054180
  a <- a + age2 * bmi1         * -0.00107747822215317130
  a <- a + age2 * bmi2         *  0.00019110487304583101
  a <- a + age2 * fbs1         * -0.03900460792238353
  a <- a + age2 * fbs2         * -0.04112771980589595
  a <- a + age2 * fh_diab      *  0.00062575882488594993
  
  100 * (1 - S0^exp(a))
}

# ──────────── APPLY MODEL B ────────────
sim_qd[, `:=`(
  risk_B_f = risk_B_female(
    age        = age,
    bmi        = bmi,
    fbg        = fbg,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_gestdiab         = gestdiab,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_pos              = pos,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  ),
  risk_B_m = risk_B_male(
    age        = age,
    bmi        = bmi,
    fbg        = fbg,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  )
)]
# blank cross‐sex Model B
sim_qd[sex=="M", risk_B_f := NA_real_]
sim_qd[sex=="F", risk_B_m := NA_real_]

# write out Model B
data.table::fwrite(sim_qd, "synthetic_qdiabetes_with_riskB.csv.gz")

# summary for Model B
summary_riskB <- sim_qd[ , .(
  mean_risk_B_f = mean(risk_B_f, na.rm=TRUE),
  med_risk_B_f  = median(risk_B_f, na.rm=TRUE),
  mean_risk_B_m = mean(risk_B_m, na.rm=TRUE),
  med_risk_B_m  = median(risk_B_m, na.rm=TRUE)
)]
print(summary_riskB)


# ────────────── QDiabetes Model C – Female ──────────────
risk_C_female <- function(
    age, bmi, hba1c, town,
    ethrisk, smoke_cat,
    b_apsych, b_corticosteroids, b_cvd,
    b_gestdiab, b_learning, b_manicschiz, b_pos,
    b_statin, b_treatedhyp, fh_diab
){
  S0 <- 0.988788545131683
  
  Ieth <- c(
    0,0,
    0.5990951599291541, 0.7832030965635389, 1.1947351247960103,
    0.7141744699168143, 0.1195328468388769, 0.0136688728784904,
    0.5709226537693946, 0.1709107628106929
  )
  Ism <- c(0,0.06584825851000067,0.1458413689734224,
           0.15258642474801187,0.30787416796613976)
  
  dage   <- age/10
  age1   <- dage^0.5    - 2.123332023620606
  age2   <- dage^3      - 91.64474487304688
  dbmi   <- bmi/10
  bmi1   <- dbmi        - 2.571253299713135
  bmi2   <- dbmi^3      - 16.999439239501953
  dhba   <- hba1c/10
  hba1   <- dhba^0.5    - 1.886751174926758
  hba2   <- dhba        - 3.559829950332642
  
  townc  <- 0
  
  a <- 0
  a <- a + Ieth[ethrisk+1]
  a <- a + Ism[smoke_cat]
  
  # continuous
  a <- a + age1 *  3.5655214891947722
  a <- a + age2 * -0.0056158243572733135
  a <- a + bmi1 *  2.5043028874544841
  a <- a + bmi2 * -0.0428758018926904610
  a <- a + hba1 *  8.7368031307362184
  a <- a + hba2 * -0.07823138666994997
  a <- a + townc * 0.03586682205634829
  
  # binary
  a <- a + b_apsych          * 0.54976333110422004
  a <- a + b_corticosteroids * 0.16872205506389704
  a <- a + b_cvd             * 0.16443300362739344
  a <- a + b_gestdiab        * 1.12500981051711400
  a <- a + b_learning        * 0.28912058310739658
  a <- a + b_manicschiz      * 0.31825122490684077
  a <- a + b_pos             * 0.33806444140981745
  a <- a + b_statin          * 0.45593968473811164
  a <- a + b_treatedhyp      * 0.40400222950237580
  a <- a + fh_diab           * 0.44280154048260317
  
  # interactions
  a <- a + age1 * b_apsych     * -0.81254341971621313
  a <- a + age1 * b_learning   * -0.90846657652698082
  a <- a + age1 * b_statin     * -1.85579605855606580
  a <- a + age1 * bmi1         *  0.60232187652352520
  a <- a + age1 * bmi2         * -0.03449503839680447
  a <- a + age1 * fh_diab      * -0.27275713515061872
  a <- a + age1 * hba1         * 25.44120332273671500
  a <- a + age1 * hba2         * -6.80760804215561070
  a <- a + age2 * b_apsych     *  0.00046656113060054280
  a <- a + age2 * b_learning   *  0.00085189801399280065
  a <- a + age2 * b_statin     *  0.00226272509633525370
  a <- a + age2 * bmi1         * -0.00433866456631334250
  a <- a + age2 * bmi2         *  0.00011627785616712089
  a <- a + age2 * fh_diab      *  0.00043545197952207749
  a <- a + age2 * hba1         * -0.05225413558859252
  a <- a + age2 * hba2         *  0.01405482590611445
  
  100 * (1 - S0^exp(a))
}


# ────────────── QDiabetes Model C – Male ──────────────
risk_C_male <- function(
    age, bmi, hba1c, town,
    ethrisk, smoke_cat,
    b_apsych, b_corticosteroids, b_cvd,
    b_learning, b_manicschiz,
    b_statin, b_treatedhyp, fh_diab
){
  S0 <- 0.981181740760803
  
  Ieth <- c(
    0,0,
    0.6757120705498780, 0.8314732504966346, 1.0969133802228563,
    0.7682244636456048, 0.2089752925910850, 0.3809159378197058,
    0.3423583679661269, 0.2204647785343308
  )
  Ism <- c(0,0.11592891206878651,0.14624182637633271,
           0.10781424112493142,0.19848629163668474)
  
  dage <- age/10
  age1 <- log(dage)       - 1.4963924884796140
  age2 <- dage^3          - 89.04817199707031
  dbmi <- bmi/10
  bmi1 <- dbmi^2          - 6.8178057670593260
  bmi2 <- dbmi^3          - 17.801923751831055
  dhba <- hba1c/10
  hba1 <- dhba^0.5        - 1.9002653360366820
  hba2 <- dhba            - 3.611008167266846
  
  townc <- 0
  
  a <- 0
  a <- a + Ieth[ethrisk+1]
  a <- a + Ism[smoke_cat]
  
  # continuous
  a <- a + age1 *  4.0193435623978031
  a <- a + age2 * -0.0048396442306278238
  a <- a + bmi1 *  0.8182916890534933
  a <- a + bmi2 * -0.1255880870135964
  a <- a + hba1 *  8.0511642238857934
  a <- a + hba2 * -0.1465234689391449
  a <- a + townc * 0.025229965184900727
  
  # binary
  a <- a + b_apsych          * 0.45541525220173301
  a <- a + b_corticosteroids * 0.13816187686823922
  a <- a + b_cvd             * 0.14546988896239518
  a <- a + b_learning        * 0.25960466580408570
  a <- a + b_manicschiz      * 0.28523788490585894
  a <- a + b_statin          * 0.42551951901185525
  a <- a + b_treatedhyp      * 0.33169430006459311
  a <- a + fh_diab           * 0.56612325943680619
  
  # interactions
  a <- a + age1 * b_apsych     * -1.00133319090798350
  a <- a + age1 * b_learning   * -0.89164657372215927
  a <- a + age1 * b_statin     * -1.70745611678198170
  a <- a + age1 * bmi1         *  0.45074527472672443
  a <- a + age1 * bmi2         * -0.10851859809165601
  a <- a + age1 * fh_diab      * -0.61410093887097161
  a <- a + age1 * hba1         * 27.67059382714656500
  a <- a + age1 * hba2         * -7.40061348467854340
  
  a <- a + age2 * b_apsych     *  0.00022455973985742407
  a <- a + age2 * b_learning   *  0.00066044360765696482
  a <- a + age2 * b_statin     *  0.00138735093573896190
  a <- a + age2 * bmi1         * -0.00122247361602878650
  a <- a + age2 * bmi2         *  0.00022667310103461260
  a <- a + age2 * fh_diab      *  0.00050602582894772091
  a <- a + age2 * hba1         * -0.05920145812475433
  a <- a + age2 * hba2         *  0.01559208948514999
  
  100 * (1 - S0^exp(a))
}

# ──────────── APPLY MODEL C ────────────
sim_qd[, `:=`(
  risk_C_f = risk_C_female(
    age        = age,
    bmi        = bmi,
    hba1c      = hba1c,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_gestdiab         = gestdiab,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_pos              = pos,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  ),
  risk_C_m = risk_C_male(
    age        = age,
    bmi        = bmi,
    hba1c      = hba1c,
    town       = 0,
    ethrisk    = ethrisk,
    smoke_cat  = smoking,
    b_apsych           = apsych,
    b_corticosteroids  = steroid,
    b_cvd              = cvd,
    b_learning         = learning,
    b_manicschiz       = manicschiz,
    b_statin           = statin,
    b_treatedhyp       = htn,
    fh_diab            = famhist
  )
)]
# blank cross‐sex Model C
sim_qd[sex=="M", risk_C_f := NA_real_]
sim_qd[sex=="F", risk_C_m := NA_real_]

# write out Model C
data.table::fwrite(sim_qd, "synthetic_qdiabetes_with_riskC.csv.gz")

# summary for Model C
summary_riskC <- sim_qd[ , .(
  mean_risk_C_f = mean(risk_C_f, na.rm=TRUE),
  med_risk_C_f  = median(risk_C_f, na.rm=TRUE),
  mean_risk_C_m = mean(risk_C_m, na.rm=TRUE),
  med_risk_C_m  = median(risk_C_m, na.rm=TRUE)
)]
print(summary_riskC)

# ----------------------------------------------------------------
# HH Risk Calculator Integration (QDiabetes-2018 Model A → HH_risk_A)
# ----------------------------------------------------------------

library(readr)
library(dplyr)

# 0) Where is the CSV?
rel_path <- "Research and Development/HealthChart/simulation risk calculator/Simulation Dataset QDiabetes vs HH_Diabetes/QDiabetes Data/QDiabetes_HR_RR10_prevalence.csv"
file_path <- path.expand( file.path("~", rel_path) )
if (!file.exists(file_path)) stop("CSV not found at: ", file_path)

# 1) Load & rename only what we need
qd_rr <- read_csv(file_path, show_col_types = FALSE) %>%
  rename(
    Factor     = factor,      # risk-factor name
    Model      = model,       # “A” / “B” / “C”
    Sex        = sex,         # “M” / “F”
    RR10       = RR10,        # published 10-yr HR
    Prevalence = prevalence,  # 0–1
    Answer     = Characteristic,
    S0         = S0           # baseline survival at 10y
  ) %>%
  filter(Model == "A")  # keep only Model A for now

qd_rr <- qd_rr %>%
  mutate(
    Factor = tolower(Factor),
    Answer = tolower(Factor)   # copy Factor into Answer so individual lookups work too
  )

# 2) Categorical predictors
cat_factors <- c(
    "white or not recorded","indian","pakistani","bangladeshi","other asian",
    "caribbean","black african","chinese","other",
    "non-smoker","light smoker","moderate smoker","heavy smoker","ex-smoker",
    "family history of diabetes","cardiovascular disease","treated hypertension",
    "corticosteroids","statins","atypical antipsychotics",
    "bipolar or schizophrenia","learning disability",
    "gestational diabetes","polycystic ovaries"
  )

# (Optional sanity‐check)
message("Valid factors are: ", paste(sort(unique(qd_rr$Factor)), collapse=", "))
flush.console()

# ─────────── 3) Population PR for categorical ───────────

# define each group of levels for the 12 categorical predictors
cat_groups <- list(
  ethnicity                    = c(
    "white or not recorded","indian","pakistani","bangladeshi",
    "other asian","caribbean","black african","chinese","other"
  ),
  smoking_status               = c(
    "non-smoker","light smoker","moderate smoker","heavy smoker","ex-smoker"
  ),
  family_history_of_diabetes   = "family history of diabetes",
  cardiovascular_disease       = "cardiovascular disease",
  treated_hypertension         = "treated hypertension",
  corticosteroids              = "corticosteroids",
  statins                      = "statins",
  atypical_antipsychotics      = "atypical antipsychotics",
  bipolar_or_schizophrenia     = "bipolar or schizophrenia",
  learning_disability          = "learning disability",
  gestational_diabetes         = "gestational diabetes",
  polycystic_ovaries           = "polycystic ovaries"
)

# helper to compute PR_cat for one sex
compute_pr_cat <- function(sex_i) {
  # for each group, compute a single “weighted‐average RR”
  wprs <- sapply(cat_groups, function(levels) {
    sub <- qd_rr %>% filter(Sex == sex_i, Factor %in% levels)
    if (nrow(sub) == 0) {
      # no data for this group → no effect
      return(1)
    }
    if (length(levels) > 1) {
      # multi‐level categorical → sum(p_i * RR10_i)
      sum(sub$Prevalence * sub$RR10)
    } else {
      # binary → p*RR + (1‐p)*1
      p  <- sub$Prevalence
      rr <- sub$RR10
      p * rr + (1 - p)
    }
  }, simplify = TRUE)
  
  # ensure it’s a numeric vector, then take the product
  wprs <- unlist(wprs)
  # log-sum trick for numerical stability:
  exp( sum(log(wprs)) )
}

PR_cat_female <- compute_pr_cat("F")
PR_cat_male   <- compute_pr_cat("M")

message("PR_cat_female = ", PR_cat_female,
        "; PR_cat_male   = ", PR_cat_male)
flush.console()



# 4) Monte-Carlo PR for Age & BMI, Hba1c, FBS (FPs, μ/σ from Table 1)
num_draws <- 1e4

# initialize progress bar
pb <- txtProgressBar(min = 0, max = 6, style = 3)

# --- Age
mu_age <- 44.9; sd_age <- 15.3
beta_f_age1    <-  4.3400852699139278; beta_f_age2    <- -0.0048771702696158879
mean_fp1_age_f <-  2.123332023620606;  mean_fp2_age_f <- 91.644744873046875
beta_m_age1    <-  4.4642324388691348; beta_m_age2    <- -0.0040750108019255568
mean_fp1_age_m <-  1.496392488479614;  mean_fp2_age_m <- 89.048171997070313

ages <- rnorm(num_draws, mu_age, sd_age)
ages <- pmax(ages, .Machine$double.eps)    # clamp to >0
dage <- ages / 10

PR_age_f <- mean(
  exp(
    beta_f_age1 * (dage^0.5 - mean_fp1_age_f) +
      beta_f_age2 * (dage^3   - mean_fp2_age_f)
  ),
  na.rm = TRUE
)
setTxtProgressBar(pb, 1); flush.console()

PR_age_m <- mean(
  exp(
    beta_m_age1 * (log(dage) - mean_fp1_age_m) +
      beta_m_age2 * (dage^3    - mean_fp2_age_m)
  ),
  na.rm = TRUE
)
setTxtProgressBar(pb, 2); flush.console()

# --- BMI
mu_bmi <- 26.0; sd_bmi <- 5.0
beta_f_bmi1    <-  2.9320361259524925; beta_f_bmi2    <- -0.04740020587484349
mean_fp1_bmi_f <-  2.571253299713135;  mean_fp2_bmi_f <- 16.999439239501953
beta_m_bmi1    <-  0.95129027867120675; beta_m_bmi2    <- -0.14352488277885475
mean_fp1_bmi_m <-  6.817805767059326;   mean_fp2_bmi_m <- 17.801923751831055

bmis <- rnorm(num_draws, mu_bmi, sd_bmi)
bmis <- pmax(bmis, .Machine$double.eps)  # clamp to >0
dbmi <- bmis / 10

PR_bmi_f <- mean(
  exp(
    beta_f_bmi1 * (dbmi       - mean_fp1_bmi_f) +
      beta_f_bmi2 * (dbmi^3     - mean_fp2_bmi_f)
  ),
  na.rm = TRUE
)
setTxtProgressBar(pb, 3); flush.console()

PR_bmi_m <- mean(
  exp(
    beta_m_bmi1 * (dbmi^2     - mean_fp1_bmi_m) +
      beta_m_bmi2 * (dbmi^3     - mean_fp2_bmi_m)
  ),
  na.rm = TRUE
)

# --- Monte-Carlo PR for fasting glucose (Model B) ---
mu_fbg <- mu["fbg"]; sd_fbg <- sd["fbg"]
fbgs <- rnorm(num_draws, mu_fbg, sd_fbg)
fbgs <- pmax(fbgs, .Machine$double.eps)  # clamp to >0
dfbs <- fbgs
# transform & centre using the exact QD constants
fbs1 <- dfbs^-1     - 0.208309367299080
fbs2 <- dfbs^-1*log(dfbs) - 0.326781362295151
# female coefficients from risk_B_female:
beta_f_fbg1 <- -2.1887891946337308
beta_f_fbg2 <- -69.96084198286603
# male coefficients from risk_B_male:
beta_m_fbg1 <- -54.8417881280971070
beta_m_fbg2 <- -53.1120784984813600
# now our two PRs:
PR_fbg_f <- mean(exp(beta_f_fbg1 * fbs1 + beta_f_fbg2 * fbs2))
PR_fbg_m <- mean(exp(beta_m_fbg1 * fbs1 + beta_m_fbg2 * fbs2))

# --- Monte-Carlo PR for HbA1c (Model C) ---
mu_hba <- mu["hba1c"]; sd_hba <- sd["hba1c"]
hbas <- rnorm(num_draws, mu_hba, sd_hba)
hbas <- pmax(hbas, .Machine$double.eps)
dhba <- hbas/10
# transform & centre
hba1 <- dhba^0.5 - 1.886751174926758
hba2 <- dhba     - 3.559829950332642
# female coefficients from risk_C_female:
beta_f_hba1 <-  8.7368031307362184
beta_f_hba2 <- -0.07823138666994997
# male coefficients from risk_C_male:
beta_m_hba1 <- 27.67059382714656500
beta_m_hba2 <- -7.40061348467854340
PR_hba_f <- mean(exp(beta_f_hba1 * hba1 + beta_f_hba2 * hba2))
PR_hba_m <- mean(exp(beta_m_hba1 * hba1 + beta_m_hba2 * hba2))

setTxtProgressBar(pb, 4); flush.console()

# close the bar
close(pb)

# Your four PRs are now:
print(list(
  PR_age_f = PR_age_f,
  PR_age_m = PR_age_m,
  PR_bmi_f = PR_bmi_f,
  PR_bmi_m = PR_bmi_m
))


# 5) Closed-form PR for Townsend (linear β·(X−μ)), sexes from supplement
beta_f_town <- log(1.21)/5; mu_town_f <- 0.2; sd_town_f <- 3.2
beta_m_town <- log(1.15)/5; mu_town_m <- 0.5; sd_town_m <- 3.3
PR_town_f <- exp(0.5 * beta_f_town^2 * sd_town_f^2)
PR_town_m <- exp(0.5 * beta_m_town^2 * sd_town_m^2)

# 6) Total PR by sex for Model A
PR_A_f <- PR_cat_female * PR_age_f * PR_bmi_f * PR_town_f
PR_A_m <- PR_cat_male   * PR_age_m * PR_bmi_m * PR_town_m

# 7) Total PR for Model B (adds fasting‐glucose)
PR_B_f <- PR_A_f * PR_fbg_f
PR_B_m <- PR_A_m * PR_fbg_m

# 8) Total PR for Model C (adds HbA1c)
PR_C_f <- PR_A_f * PR_hba_f
PR_C_m <- PR_A_m * PR_hba_m


# ─────────── 7) Lookup helper for categorical RR₁₀ ───────────
get_individual_rr_HH <- function(df, sex, category) {
  # normalize category to match qd_rr$Factor
  category <- tolower(category)
  if (is.na(category) || category == "") return(1)
  rr_vals <- df %>%
    filter(Factor == category, Sex == sex) %>%
    pull(RR10)
  if (length(rr_vals) == 0) 1 else rr_vals[1]
}

# ─────────── 8) CIR with QDiabetes centring & interactions ───────────

# Model A
compute_CIR_HH_A <- function(
    sex, age, bmi,
    ethnicity, smoking,
    famhist, htn, cvd,
    steroid, statin, apsych,
    gestdiab, pos, learning, manicschiz
) {
  dage <- age / 10
  dbmi <- bmi / 10
  
  if (sex == "F") {
    # fractional polynomials, centred
    age1 <- dage^0.5             - 2.123332023620606
    age2 <- dage^3               - 91.644744873046875
    bmi1 <- dbmi                 - 2.571253299713135
    bmi2 <- dbmi^3               - 16.999439239501953
    
    a <- age1 *  4.340085269913928 +
      age2 * -0.004877170269615888 +
      bmi1 *  2.9320361259524925 +
      bmi2 * -0.04740020587484349
  } else {
    age1 <- log(dage)             - 1.496392488479614
    age2 <- dage^3               - 89.04817199707031
    bmi1 <- dbmi^2               - 6.817805767059326
    bmi2 <- dbmi^3               - 17.801923751831055
    
    a <- age1 *  4.464232438869135 +
      age2 * -0.004075010801925557 +
      bmi1 *  0.9512902786712068 +
      bmi2 * -0.14352488277885475
  }
  
  # conditional (categorical) RRs
  rrs <- c(
    get_individual_rr_HH(qd_rr, sex, ethnicity),
    get_individual_rr_HH(qd_rr, sex,
                         c("non-smoker","light smoker","moderate smoker","heavy smoker","ex-smoker")[smoking]
    ),
    get_individual_rr_HH(qd_rr, sex, "family history of diabetes"),
    get_individual_rr_HH(qd_rr, sex, "treated hypertension"),
    get_individual_rr_HH(qd_rr, sex, "cardiovascular disease"),
    get_individual_rr_HH(qd_rr, sex, "corticosteroids"),
    get_individual_rr_HH(qd_rr, sex, "statins"),
    get_individual_rr_HH(qd_rr, sex, "atypical antipsychotics"),
    get_individual_rr_HH(qd_rr, sex, "bipolar or schizophrenia"),
    get_individual_rr_HH(qd_rr, sex, "learning disability"),
    get_individual_rr_HH(qd_rr, sex, "gestational diabetes"),
    get_individual_rr_HH(qd_rr, sex, "polycystic ovaries")
  )
  a <- a + sum(log(rrs))
  
  # binary main effects
  if (sex == "F") {
    a <- a + apsych   * 0.5526764611098438
    a <- a + steroid  * 0.2679223368067460
    a <- a + cvd      * 0.1779722905458669
    a <- a + gestdiab * 1.5248871531467574
    a <- a + learning * 0.2783514358717272
    a <- a + manicschiz * 0.2618085210917906
    a <- a + pos      * 0.3406173988206666
    a <- a + statin   * 0.6590728773280822
    a <- a + htn      * 0.4394758285813712
    a <- a + famhist  * 0.5313359456558734
  } else {
    a <- a + apsych   * 0.4210109234600544
    a <- a + steroid  * 0.2218358093292538
    a <- a + cvd      * 0.2026960575622757
    a <- a + learning * 0.2331532140798696
    a <- a + manicschiz * 0.2277044956301545
    a <- a + statin   * 0.5849007543111734
    a <- a + htn      * 0.3337939218352929
    a <- a + famhist  * 0.6479928489937514
  }
  
  # interaction terms
  if (sex == "F") {
    a <- a + age1 * apsych     * -0.8031518398316395
    a <- a + age1 * learning   * -0.8641596002882057
    a <- a + age1 * statin     * -1.9757776696583935
    a <- a + age1 * bmi1       *  0.6553138757562945
    a <- a + age1 * bmi2       * -0.03620965720163018
    a <- a + age1 * famhist    * -0.2641171450558896
    a <- a + age2 * apsych     *  0.000468404118102105
    a <- a + age2 * learning   *  0.000672496880895336
    a <- a + age2 * statin     *  0.002375053419434797
    a <- a + age2 * bmi1       * -0.004471966244526305
    a <- a + age2 * bmi2       *  0.0001185479967753342
    a <- a + age2 * famhist    *  0.0004161025828904768
  } else {
    a <- a + age1 * apsych     * -0.9463772226853415
    a <- a + age1 * learning   * -0.9384237552649983
    a <- a + age1 * statin     * -1.7479070653003299
    a <- a + age1 * bmi1       *  0.4514759924187977
    a <- a + age1 * bmi2       * -0.1079548126277638
    a <- a + age1 * famhist    * -0.6011853042930120
    a <- a + age2 * apsych     * -0.000051992744118232
    a <- a + age2 * learning   *  0.0007102643855968814
    a <- a + age2 * statin     *  0.0013508364694347970
    a <- a + age2 * bmi1       * -0.001179772526668030
    a <- a + age2 * bmi2       *  0.0002146744877373330
    a <- a + age2 * famhist    *  0.0004914185582914953
  }
  
  exp(a)
}

# Model B  (adds fasting-glucose fractional polynomials & B-specific coefficients)
compute_CIR_HH_B <- function(
    sex, age, bmi, fbg,
    ethnicity, smoking,
    famhist, htn, cvd,
    steroid, statin, apsych,
    gestdiab, pos, learning, manicschiz
) {
  dage <- age / 10
  dbmi <- bmi / 10
  
  if (sex == "F") {
    age1 <- dage^0.5             - 2.123332023620606
    age2 <- dage^3               - 91.644744873046875
    bmi1 <- dbmi                 - 2.571253299713135
    bmi2 <- dbmi^3               - 16.999439239501953
    dfbs <- fbg
    fbs1 <- dfbs^-1           - 0.208309367299080
    fbs2 <- dfbs^-1 * log(dfbs) - 0.326781362295151
    
    a <- age1 *  3.7650129507517280 +
      age2 * -0.0056043343436614941 +
      bmi1 *  2.4410935031672469 +
      bmi2 * -0.0421526334799096420 +
      fbs1 * -2.1887891946337308 +
      fbs2 * -69.96084198286603
  } else {
    age1 <- log(dage)            - 1.496392488479614
    age2 <- dage^3               - 89.04817199707031
    bmi1 <- dbmi^2               - 6.817805767059326
    bmi2 <- dbmi^3               - 17.801923751831055
    dfbs <- fbg
    fbs1 <- dfbs^(-.5)          - 0.448028832674026
    fbs2 <- dfbs^(-.5) * log(dfbs) - 0.719442605972290
    
    a <- age1 *  4.1149143302364717 +
      age2 * -0.0047593576668505362 +
      bmi1 *  0.8169361587644297 +
      bmi2 * -0.1250237740343336 +
      fbs1 * -54.8417881280971070 +
      fbs2 * -53.11207849848136
  }
  
  # now append the exact same categorical, binary & interaction blocks from Model A
  a <- a + (log(compute_CIR_HH_A(
    sex, age, bmi,
    ethnicity, smoking,
    famhist, htn, cvd,
    steroid, statin, apsych,
    gestdiab, pos, learning, manicschiz
  )))
  
  exp(a)
}

# Model C  (adds HbA1c fractional polynomials & C-specific coefficients)
compute_CIR_HH_C <- function(
    sex, age, bmi, hba1c,
    ethnicity, smoking,
    famhist, htn, cvd,
    steroid, statin, apsych,
    gestdiab, pos, learning, manicschiz
) {
  dage <- age / 10
  dbmi <- bmi / 10
  
  if (sex == "F") {
    age1 <- dage^0.5             - 2.123332023620606
    age2 <- dage^3               - 91.644744873046875
    bmi1 <- dbmi                 - 2.571253299713135
    bmi2 <- dbmi^3               - 16.999439239501953
    dhba <- hba1c / 10
    hba1 <- dhba^0.5             - 1.886751174926758
    hba2 <- dhba                 - 3.559829950332642
    
    a <- age1 *  3.5655214891947722 +
      age2 * -0.0056158243572733135 +
      bmi1 *  2.5043028874544841 +
      bmi2 * -0.0428758018926904610 +
      hba1 *  8.7368031307362184 +
      hba2 * -0.07823138666994997
  } else {
    age1 <- log(dage)            - 1.496392488479614
    age2 <- dage^3               - 89.04817199707031
    bmi1 <- dbmi^2               - 6.817805767059326
    bmi2 <- dbmi^3               - 17.801923751831055
    dhba <- hba1c / 10
    hba1 <- dhba^0.5             - 1.900265336036682
    hba2 <- dhba                 - 3.611008167266846
    
    a <- age1 *  4.0193435623978031 +
      age2 * -0.0048396442306278238 +
      bmi1 *  0.8182916890534933 +
      bmi2 * -0.1255880870135964 +
      hba1 *  8.0511642238857934 +
      hba2 * -0.14652346893914495
  }
  
  # append the same categorical, binary & interaction blocks from Model A
  a <- a + (log(compute_CIR_HH_A(
    sex, age, bmi,
    ethnicity, smoking,
    famhist, htn, cvd,
    steroid, statin, apsych,
    gestdiab, pos, learning, manicschiz
  )))
  
  exp(a)
}

# ─────────── 10a) rowwise CIR ───────────
sim_qd <- sim_qd %>%
  rowwise() %>%
  mutate(
    # Hazard ratios via the HH‐style CIR functions for each QD model
    HR_HH_A = compute_CIR_HH_A(
      sex, age, bmi,
      ethnicity, smoking,
      famhist, htn, cvd,
      steroid, statin, apsych,
      gestdiab, pos, learning, manicschiz
    ),
    HR_HH_B = compute_CIR_HH_B(
      sex, age, bmi, fbg,
      ethnicity, smoking,
      famhist, htn, cvd,
      steroid, statin, apsych,
      gestdiab, pos, learning, manicschiz
    ),
    HR_HH_C = compute_CIR_HH_C(
      sex, age, bmi, hba1c,
      ethnicity, smoking,
      famhist, htn, cvd,
      steroid, statin, apsych,
      gestdiab, pos, learning, manicschiz
    )
  ) %>%
  ungroup()

# 10b) Empirical calibration + hybrid absolute‐risk
PR_emp <- sim_qd %>%
  group_by(sex) %>%
  summarize(
    PR_emp_A = mean(HR_HH_A, na.rm=TRUE),
    PR_emp_B = mean(HR_HH_B, na.rm=TRUE),
    PR_emp_C = mean(HR_HH_C, na.rm=TRUE)
  )

sim_qd <- sim_qd %>%
  left_join(PR_emp, by="sex") %>%
  mutate(
    # model‐specific reference PRs (computed earlier)
    PR_A = if_else(sex=="F", PR_A_f, PR_A_m),
    PR_B = if_else(sex=="F", PR_B_f, PR_B_m),
    PR_C = if_else(sex=="F", PR_C_f, PR_C_m),
    
    # now ratio to the empirical HH mean
    RR_A = HR_HH_A / PR_emp_A,
    RR_B = HR_HH_B / PR_emp_B,
    RR_C = HR_HH_C / PR_emp_C,
    
    # absolute 10-year hybrid risks on the QD baseline
    HH_risk_A = 100 * (1 - if_else(sex=="F", S0_A_F, S0_A_M)^RR_A),
    HH_risk_B = 100 * (1 - if_else(sex=="F", S0_B_F, S0_B_M)^RR_B),
    HH_risk_C = 100 * (1 - if_else(sex=="F", S0_C_F, S0_C_M)^RR_C),
    
    # optional sex-splits
    HH_risk_A_f = if_else(sex=="F", HH_risk_A, NA_real_),
    HH_risk_A_m = if_else(sex=="M", HH_risk_A, NA_real_),
    HH_risk_B_f = if_else(sex=="F", HH_risk_B, NA_real_),
    HH_risk_B_m = if_else(sex=="M", HH_risk_B, NA_real_),
    HH_risk_C_f = if_else(sex=="F", HH_risk_C, NA_real_),
    HH_risk_C_m = if_else(sex=="M", HH_risk_C, NA_real_),
    
    # diagnostics
    log_CIR_A = log(HR_HH_A),
    log_PR_A  = log(PR_emp_A),
    log_RR_A  = log_CIR_A - log_PR_A,
    log_CIR_B = log(HR_HH_B),
    log_PR_B  = log(PR_emp_B),
    log_RR_B  = log_CIR_B - log_PR_B,
    log_CIR_C = log(HR_HH_C),
    log_PR_C  = log(PR_emp_C),
    log_RR_C  = log_CIR_C - log_PR_C
  )

message("✔️ Finished HH integration (empirically centered)")  
flush.console()


# 10c) (Optional) glimpse the first few
sim_qd %>%
  select(
    sex,
    HR_HH_A, RR_A, HH_risk_A,
    HR_HH_B, RR_B, HH_risk_B,
    HR_HH_C, RR_C, HH_risk_C
  ) %>%
  slice(1:10) %>%
  print(n = 10)

# Summaries for each model
sim_qd %>%
  summarize(
    mean_logCIR_A = mean(log_CIR_A, na.rm=TRUE),
    mean_logRR_A  = mean(log_RR_A,  na.rm=TRUE),
    mean_logCIR_B = mean(log_CIR_B, na.rm=TRUE),
    mean_logRR_B  = mean(log_RR_B,  na.rm=TRUE),
    mean_logCIR_C = mean(log_CIR_C, na.rm=TRUE),
    mean_logRR_C  = mean(log_RR_C,  na.rm=TRUE)
  ) %>%
  print()
 
# Mean 10-year risks by Model & Sex
sim_qd %>%
  summarize(
    QD_A_m    = mean(risk_A_m,    na.rm=TRUE),
    QD_A_f    = mean(risk_A_f,    na.rm=TRUE),
    QD_B_m    = mean(risk_B_m,    na.rm=TRUE),
    QD_B_f    = mean(risk_B_f,    na.rm=TRUE),
    QD_C_m    = mean(risk_C_m,    na.rm=TRUE),
    QD_C_f    = mean(risk_C_f,    na.rm=TRUE),
    HH_A_m    = mean(HH_risk_A_m, na.rm=TRUE),
    HH_A_f    = mean(HH_risk_A_f, na.rm=TRUE),
    HH_B_m    = mean(HH_risk_B_m, na.rm=TRUE),
    HH_B_f    = mean(HH_risk_B_f, na.rm=TRUE),
    HH_C_m    = mean(HH_risk_C_m, na.rm=TRUE),
    HH_C_f    = mean(HH_risk_C_f, na.rm=TRUE)
  ) %>%
  pivot_longer(
    everything(),
    names_to = c("Method", "Model", "Sex"),
    names_sep = "_",
    values_to = "MeanRisk"
  ) %>%
  arrange(Model, Sex, Method)

# 11) Merge onto your existing riskA, riskB, riksC files & print summary
 library(dplyr)
 library(readr)
 
# Read the original synthetic QDiabetes outputs
origA <- read_csv(file.path(dirname(file_path),"synthetic_qdiabetes_with_riskA.csv.gz"))
origB <- read_csv(file.path(dirname(file_path),"synthetic_qdiabetes_with_riskB.csv.gz"))
origC <- read_csv(file.path(dirname(file_path),"synthetic_qdiabetes_with_riskC.csv.gz"))

# Add patient_id
origA <- origA %>% mutate(patient_id = row_number())
origB <- origB %>% mutate(patient_id = row_number())
origC <- origC %>% mutate(patient_id = row_number())
sim_qd <- sim_qd %>% mutate(patient_id = row_number())

# Extract the new HH columns
hhA <- sim_qd %>% select(patient_id, HH_risk_A_m, HH_risk_A_f)
hhB <- sim_qd %>% select(patient_id, HH_risk_B_m, HH_risk_B_f)
hhC <- sim_qd %>% select(patient_id, HH_risk_C_m, HH_risk_C_f)

# Join and write out
enhA <- origA %>% left_join(hhA, by="patient_id")
enhB <- origB %>% left_join(hhB, by="patient_id")
enhC <- origC %>% left_join(hhC, by="patient_id")

write_csv(enhA, file.path(dirname(file_path),"synthetic_qdiabetes_with_riskA_and_HH.csv.gz"))
write_csv(enhB, file.path(dirname(file_path),"synthetic_qdiabetes_with_riskB_and_HH.csv.gz"))
write_csv(enhC, file.path(dirname(file_path),"synthetic_qdiabetes_with_riskC_and_HH.csv.gz"))

# Print mean HH risks
enhA %>% summarize(mean_HH_risk_A_m = mean(HH_risk_A_m, na.rm=TRUE),
                   mean_HH_risk_A_f = mean(HH_risk_A_f, na.rm=TRUE)) %>% print()
enhB %>% summarize(mean_HH_risk_B_m = mean(HH_risk_B_m, na.rm=TRUE),
                   mean_HH_risk_B_f = mean(HH_risk_B_f, na.rm=TRUE)) %>% print()
enhC %>% summarize(mean_HH_risk_C_m = mean(HH_risk_C_m, na.rm=TRUE),
                   mean_HH_risk_C_f = mean(HH_risk_C_f, na.rm=TRUE)) %>% print()

# And scatter plots for each model
library(ggplot2)

# Model A
ggplot(sim_qd %>% filter(sex=="M"), aes(risk_A_m, HH_risk_A_m)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model A: QD vs HH (Male)", x="risk_A_m", y="HH_risk_A_m")
ggplot(sim_qd %>% filter(sex=="F"), aes(risk_A_f, HH_risk_A_f)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model A: QD vs HH (Female)", x="risk_A_f", y="HH_risk_A_f")

# Model B
ggplot(sim_qd %>% filter(sex=="M"), aes(risk_B_m, HH_risk_B_m)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model B: QD vs HH (Male)", x="risk_B_m", y="HH_risk_B_m")
ggplot(sim_qd %>% filter(sex=="F"), aes(risk_B_f, HH_risk_B_f)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model B: QD vs HH (Female)", x="risk_B_f", y="HH_risk_B_f")

# Model C
ggplot(sim_qd %>% filter(sex=="M"), aes(risk_C_m, HH_risk_C_m)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model C: QD vs HH (Male)", x="risk_C_m", y="HH_risk_C_m")
ggplot(sim_qd %>% filter(sex=="F"), aes(risk_C_f, HH_risk_C_f)) +
  geom_point(alpha=0.2) + geom_abline(slope=1, intercept=0, linetype="dashed") +
  labs(title="Model C: QD vs HH (Female)", x="risk_C_f", y="HH_risk_C_f")
