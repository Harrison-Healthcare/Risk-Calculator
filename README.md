# Harrison Healthcare Risk Calculator
# Coronary Heart Disease Risk Simulation Dataset

This repository contains R code and data files for simulating and validating cardiovascular risk datasets using both Framingham and Harrison Healthcare risk models. The project includes two main approaches:

1. **Framingham Input Analysis**
   - Uses original Framingham study data and methodology
   - Uses Wilson et al. (1998) Framingham risk equations for Framingham TC and LDL model
   - Uses updated Harrison Healthcare methodology, risk equations for the HH-CHD TC and LDL model
   - Calculates risk using original Framingham coefficients and prevalence rates
   

2. **Contemporary Input Analysis**
   - Uses original Framingham study data and methodology
   - Uses Wilson et al. (1998) Framingham risk equations for Framingham TC and LDL model with original Framingham coefficients and prevalence rates
   - Uses modern risk factors and prevalence rates and updated Harrison Healthcare methodology, risk equations for the HH-CHD model


## File Descriptions

### Documentation

1. `Harrison Healthcare's Risk Calculator Methodology Reproduces the Framingham 10-Year Risk Score in a Simulated Dataset.md`
   - Documentation explaining the methodology and validation results
   - Contains detailed analysis of how Harrison Healthcare risk calculator reproduces Framingham scores
   
### Input Data Files Relative Risk and Prevalence

1. **Framingham Inputs**
   - `TC_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx`
     - Relative risk and prevalence values from original Framingham TC model
     - Based on Wilson et al. (1998) methodology
   
   - `LDL_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx`
     - Relative risk and prevalence values from original Framingham LDL model
     - Based on Wilson et al. (1998) methodology

2. **Contemporary Inputs**
   - `HH_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx`
     - Relative risk and prevalence values for Harrison Healthcare model
     - Based on contemporary meta-analysis and research
     - Includes updated risk factor coefficients

### Input Data Files WPR

1. **Framingham Inputs**
   - `TC_WPR_by_Factor_Framingham.xlsx`
     - Total Cholesterol weighted prevalence rates by factor
     - Based on original Framingham study data
     - Used for Framingham Inputs risk calculations
   
   - `LDL_WPR_by_Factor_Framingham.xlsx`
     - LDL Cholesterol weighted prevalence rates by factor
     - Based on original Framingham study data
     - Used for Framingham Inputs risk calculations

2. **Contemporary Inputs**
   - `HH_WPR_by_Factor_Framingham.xlsx`
     - Harrison Healthcare weighted prevalence rates by factor
     - Based on contemporary meta-analysis and research
     - Used for Harrison Healthcare risk calculations

### Main Simulation Scripts

1. **Contemporary Analysis**
   - `Dataset_CHD_Framingham_HH_CHD.R`
     - Main simulation script using contemporary inputs
     - Generates dataset with both risk models (Framingham TC & LDL and HH-CHD)
     - Contains data visualization components

2. **Framingham Inputs Analysis**
   - `Dataset_CHD_Framingham_HH_TC_LDL.R`
     - Main simulation script using original Framingham inputs
     - Includes TC and LDL models
     - Generates comprehensive dataset with both risk models (Framingham TC & LDL and HH-CHD-TC & LDL)

### Validation Analysis Scripts

1. **Contemporary Validation**
   - `validation_analysis_Framingham_vs_HH.R`
     - Compares Framingham and Harrison Healthcare models using contemporary inputs
     - Uses updated risk factors and prevalence rates
     - Contains statistical analysis and validation metrics

2. **Framingham Inputs Validation**
   - `validation_analysis_Framingham vs HH_TC_LDL.R`
     - Compares Framingham and Harrison Healthcare models using original Framingham inputs
     - Uses original Framingham coefficients
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
3. Choose which analysis approach you want to perform:
   - For contemporary analysis (using updated risk factors):
     - Run `Dataset_CHD_Framingham_HH_CHD.R`
     - Output: `simulation_dataset_final_Framingham.xlsx`
   
   - For Framingham Inputs analysis (using original Framingham methodology):
     - Run `Dataset_CHD_Framingham_HH_TC_LDL.R`
     - Output: `simulation_dataset_final_HH_Framingham_TC_LDL.xlsx`

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
