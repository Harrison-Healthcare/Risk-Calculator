<div align="center">
  <img src="../../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# CHD Risk Calculator Simulation Study

**Harrison Healthcare Coronary Heart Disease Risk Calculator Validation**

This repository contains R code and data files for simulating and validating cardiovascular risk datasets using both Framingham and Harrison Healthcare risk models (HH-CHD). The project includes two main approaches:

1. **Framingham Input Analysis (Part 1)**
   - Uses original Framingham study data and methodology
   - Uses Wilson et al. (1998) Framingham risk equations for Framingham total cholosterol (TC) and low-densitity lipoportein (LDL) model
   - Uses updated Harrison Healthcare methodology, risk equations for the HH-CHD TC and LDL model
   - Calculates risk using original Framingham coefficients and prevalence rates
   

2. **Contemporary Input Analysis (Part 2)**
   - Uses original Framingham study data and methodology
   - Uses Wilson et al. (1998) Framingham risk equations for Framingham TC and LDL model with original Framingham coefficients and prevalence rates
   - Uses modern risk factors and prevalence rates and updated Harrison Healthcare methodology, risk equations for the HH-CHD model

## Folder Structure
```text
coronary-heart-disease/                     # CHD validation study
|-- code/                                   # R analysis scripts
|   |-- part 1/                             # Framingham inputs
|   `-- part 2/                             # HH-CHD inputs
|-- data/                                   # Study-specific datasets
|   |-- part 1/                             # Framingham inputs datasets
|   `-- part 2/                             # HH-CHD inputs datasets
|-- figures/                                # Generated visualizations
|   |-- part 1/                             # Framingham inputs plots
|   `-- part 2/                             # HH-CHD inputs plots
|-- CHD-simulation-study-white paper.md
`-- CHD-simulation-study-README.md
```

## File Descriptions

### Documentation

1. `CHD-simulation-study-white paper.md`
   - Comprehensive white paper explaining the methodology and validation results
   - Contains detailed analysis of how Harrison Healthcare risk calculator reproduces Framingham scores
   - Includes mathematical equations, statistical analysis, and full result tables
   - All figure references use consistent kebab-case naming
   
### Input Data Files (located in `data/` directory)

#### Relative Risk and Prevalence Files

1. **Framingham Inputs (Part 1)**
   - `TC-Framingham-CHD-risk-dial-risk-calculator-simulation-study.xlsx`
     - Relative risk and prevalence values from original Framingham TC model
     - Based on Wilson et al. (1998) methodology
   
   - `LDL-Framingham-CHD-risk-dial-risk-calculator-simulation-study.xlsx`
     - Relative risk and prevalence values from original Framingham LDL model
     - Based on Wilson et al. (1998) methodology

2. **Contemporary Inputs (Part 2)**
   - `HH-Framingham-CHD-risk-dial-risk-calculator-simulation-study.xlsx`
     - Relative risk and prevalence values for Harrison Healthcare model
     - Based on contemporary meta-analysis and research
     - Includes updated risk factor coefficients

#### Weighted Prevalence Rate (WPR) Files

1. **Framingham Inputs (Part 1)**
   - `TC-WPR-by-factor-Framingham.xlsx`
     - Total Cholesterol weighted prevalence rates by factor
     - Based on original Framingham study data
     - Used for Framingham Inputs risk calculations
   
   - `LDL-WPR-by-factor-Framingham.xlsx`
     - LDL Cholesterol weighted prevalence rates by factor
     - Based on original Framingham study data
     - Used for Framingham Inputs risk calculations

2. **Contemporary Inputs (Part 2)**
   - `HH-WPR-by-factor-Framingham.xlsx`
     - Harrison Healthcare weighted prevalence rates by factor
     - Based on contemporary meta-analysis and research
     - Used for Harrison Healthcare risk calculations

### Figures Directory (`figures/`)

- `figures/Part 1/` — Framingham inpurts comparisons
- `figures/Part 2/` — HH-CHD inputs comparisons
- Contains all visualization outputs from the simulation studies
- Updated Naming Convention: All figure files use kebab-case (hyphens instead of underscores)
  - Example: `BA-TC-overall.png`, `modern-scatter-LDL-vs-HH.png`
- Includes Bland-Altman plots, scatter plots, and statistical comparison figures
- Referenced by the white paper with consistent hyphenated filenames

### Analysis Scripts (located in `code/` directory)

#### Main Simulation Scripts

1. **Framingham Inputs Analysis (Part 1)**
   - `code/Part 1/dataset-CHD-Framingham-HH-TC-LDL.R`
     - Main simulation script using original Framingham inputs
     - Includes TC and LDL models
     - Generates comprehensive dataset with both risk models (Framingham TC & LDL and HH-CHD-TC & LDL)
       
2. **Contemporary Analysis (Part 2)**
   - `code/Part 2/dataset-CHD-Framingham-HH-CHD.R`
     - Main simulation script using contemporary inputs
     - Generates dataset with both risk models (Framingham TC & LDL and HH-CHD)
     - Contains data visualization components

#### Validation Analysis Scripts

1. **Framingham Inputs Validation (Part 1)**
   - `code/Part 1/validation-analysis-Framingham-vs-HH-TC-LDL.R`
     - Compares Framingham and Harrison Healthcare models using original Framingham inputs
     - Uses original Framingham coefficients
     - Contains statistical analysis and validation metrics

2. **Contemporary Validation (Part 2)**
   - ``code/Part 2/validation-analysis-Framingham-vs-HH.R`
     - Compares Framingham and Harrison Healthcare models using contemporary inputs
     - Uses updated risk factors and prevalence rates
     - Contains statistical analysis and validation metrics

## How to Use

1. Ensure all required packages are installed:
   ```R
   install.packages(c(
     "dplyr", "MASS", "tidyr", "ggplot2", "writexl", "purrr",
     "readxl", "readr", "truncnorm"
   ))
   ```

2. Set the working directory to the script location
3. Navigate to the `code/` directory and choose which analysis approach you want to perform:
   - For contemporary analysis (using updated risk factors):
     - Run `dataset-CHD-Framingham-HH-CHD.R`
     - Output: Generates simulation dataset with contemporary HH-CHD vs Framingham comparison
   
   - For Framingham Inputs analysis (using original Framingham methodology):
     - Run `dataset-CHD-Framingham-HH-TC-LDL.R`
     - Output: Generates simulation dataset with original Framingham inputs comparison

4. Run the corresponding validation analysis script to perform statistical comparison and generate validation metrics

## Risk Models Implemented

1. **Framingham Risk Model**
   - 10-year risk calculation using both TC and LDL models
   - Based on Wilson et al. (1998) Framingham equations
   - Risk factors: age, cholesterol (TC, LDL, HDL), blood pressure, smoking status, and diabetes

2. **Harrison Healthcare Risk Model**
   - Absolute incidence and 10-year risk calculations
   - Based on contemporary research and meta-analysis
   - Risk factors: age, cholesterol (TC, LDL, HDL), blood pressure, smoking status, and diabetes
   - Uses updated risk factor coefficients

## Output Variables

The final dataset includes:
- Framingham 10-year risk (TC and LDL models)
- Harrison Healthcare absolute incidence and 10-year risk (survival)
- All input risk factors (age, cholesterol, BP, etc.)
- Patient demographic information (sex, age)

## Notes

- The simulation uses Framingham study data for correlations and prevalence rates
- Contemporary model uses updated risk factor coefficients and prevalence rates
- Original Framingham inputs use Wilson et al. (1998) methodology
- All risk calculations are age- and sex-specific where appropriate
- Validation studies compare model performance and accuracy
