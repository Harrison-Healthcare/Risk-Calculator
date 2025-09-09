<div align="center">
  <img src="../../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Agreement Between Harrison Healthcare’s and QDiabetes 10-Year Type 2 Diabetes Risk Calculator in a Simulated Dataset

This directory contains R code, data files, figures, and documentation for simulating and validating type 2 diabetes risk datasets using both **QDiabetes-2018 (Models A–C)** and **Harrison Healthcare’s modular diabetes risk model (HH-DM)**.  

The project is divided into two parts:

1. **Part 1 — QDiabetes Inputs**
   - HH-DM supplied with published QDiabetes-2018 inputs
   - Tests analytic convergence between HH-DM and QDiabetes under identical assumptions

2. **Part 2 — HH Inputs**
   - HH-DM supplied with contemporary relative risks and prevalences from meta-analyses
   - QDiabetes remains unchanged
   - Assesses divergence due to updated inputs

---

## Folder Structure

diabetes/
├─ code/
│ ├─ Part 1/ # scripts for QDiabetes inputs
│ └─ Part 2/ # scripts for HH contemporary inputs
├─ data/
│ ├─ Part 1/ # raw/processed tables for Part 1
│ └─ Part 2/ # raw/processed tables for Part 2
├─ figures/
│ ├─ Part 1/ # plots for Part 1 (scatter, BA, subgroup)
│ └─ Part 2/ # plots for Part 2 (scatter, BA, subgroup)
├─ Diabetes-simulation-study-README.md
└─ Diabetes-simulation-study-white paper.md


> Note: Folders use spaces (`Part 1`, `Part 2`) to match your repo. GitHub handles these; image links work as shown below.

---

## Documentation

- **`Diabetes-simulation-study-white paper.md`**  
  Full methods, results, and appendix (tables & figures). Follows the CHD style with a logo, title, author list, date, TOC, and consistent section headings.

- **`Diabetes-simulation-study-README.md` (this file)**  
  Project overview, structure, how to run, and conventions.

---

## Data & Inputs (located in `data/` directory)

- **Part 1 (QDiabetes Inputs):**  
  Relative risks, baseline survival, and factor definitions reflect QDiabetes-2018 (Models A–C):
  - **Model A:** clinical/demographic (age, sex, ethnicity, BMI, smoking, family history, deprivation, CVD, treated HTN, corticosteroids, mental-health indicators, female-specific factors incl. GDM/PCOS).
  - **Model B:** Model A + fasting plasma glucose.
  - **Model C:** Model A + HbA1c.

- **Part 2 (HH Inputs):**  
  Contemporary RRs/prevalences for HH-DM derived from recent evidence syntheses (age/sex-specific where available).

- **Synthetic cohort (N≈10,000):**  
  Simulated to mirror QDiabetes predictor distributions and correlations; written to `data/Part 1/` and `data/Part 2/` as processed tables.

---

## Figures (`figures/`)

Plots are written to:

- `figures/Part 1/` — QDiabetes inputs comparisons (HH-DM vs QDiabetes under identical inputs)  
- `figures/Part 2/` — HH inputs comparisons (contemporary HH-DM vs original QDiabetes)

### Analysis Scripts (located in `code/` directory)


## How to Use

1. Ensure all required packages are installed:
   ```R
   install.packages(c(
     "dplyr", "MASS", "tidyr", "ggplot2", "writexl", "purrr",
     "readxl", "readr", "truncnorm"
   ))
   ```
2. Set working directory to the repo root (or use project .Rproj).

3. Choose a track

   Part 1: run code/Part 1/dataset-diabetes-qdiabetes-vs-hh.R, then validation-analysis-diabetes-qdiabetes-inputs.R

   Part 2: run code/Part 2/dataset-diabetes-hh-inputs.R, then validation-analysis-diabetes-hh-inputs.R

4. Outputs

  Tables → data/Part 1/ or data/Part 2/
  Figures → figures/Part 1/ or figures/Part 2/

## Risk Models Implemented


## Output Variables

Each run produces:
- QDiabetes 10-year risk (Models A–C)
- HH-DM 10-year risk (under QDiabetes inputs and under HH inputs)
- Agreement metrics: Pearson, Spearman, ICC (absolute agreement), Bland–Altman bias & LoA
- Subgroup summaries (age bands; sex)
- Figures: scatterplots, BA (overall; by sex; by age), simple slopes, adjusted means

## Notes
  
