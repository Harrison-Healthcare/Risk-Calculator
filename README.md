# Harrison Healthcare Risk Calculator

*Last Updated: June 2024*

This repository documents the methods, mathematical weights, and validation studies for Harrison Healthcare's (HH) risk calculators. These calculators are designed to estimate individuals' risk for chronic diseases by combining relative risks and prevalence estimates from peer-reviewed studies, and chaining these together to form a risk score. Unlike single-cohort models (e.g., Framingham), the HH risk calculators use a generalized form of the Harvard Cancer Risk Index (HCRI) equation that accommodates categorical risk factors with three or more levels. Furthermore, to prevent inflated risk estimates when both lifestyle exposures and downstream biomarkers are included, the HH risk calculators apply a mediation-adjusted risk formula. This enhanced method separates direct and indirect effects using a user-defined mediation parameter (α), enabling more accurate estimation of total risk.

All inputs—including relative risks, prevalence estimates, and mediation assumptions—are derived from peer-reviewed meta-analyses or national health surveys and are fully documented for transparency and reproducibility.

## Table of Contents

- [Key Features](#key-features)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Methodology Overview](#methodology-overview)
- [Validation Studies](#validation-studies)
- [Key Publications & References](#key-publications--references)
- [Authors & Contributors](#authors--contributors)
- [License & Usage](#license--usage)
- [Contact](#contact)

## Key Features

### 🔧 **Modular Framework Architecture**
- **Multi-source Integration**: Combines relative risk and prevalence estimates from multiple peer-reviewed studies
- **Regular Updates**: Framework enables continuous updates as new evidence emerges
- **Generalizable Design**: Unlike single-cohort datasets (e.g., Framingham), methodology can be applied across diverse populations

### 🧬 **Advanced Risk Calculation Methodology**
- **Mediation Effects Integration**: Novel approach to handle interactions between lifestyle factors and biomarkers
- **Direct vs. Indirect Effects**: Prevents double-counting when combining lifestyle factors (e.g., saturated fat intake) with biomarkers (e.g., LDL cholesterol)
- **Multi-level Risk Factors**: Extended Harvard Cancer Risk Index (HCRI) equation supporting factors with 3+ levels

### 📊 **Comprehensive Chronic Disease Coverage**
- **Multiple Health Conditions**: Risk assessment for common chronic diseases beyond cardiovascular conditions
- **Evidence-Based Risk Factors**: All factors derived from peer-reviewed meta-analyses and cohort studies
- **Population-Representative**: Uses contemporary demographic and health survey data

### 🔬 **Transparent & Open Methodology**
- **Public Domain**: Complete methodology, weights, and sources freely available
- **Peer-Reviewed Sources**: All risk factors traceable to published research
- **Validation Studies**: Includes preliminary simulations showing close replication of established risk scores

## Repository Structure

```
├── Methodology/                              # Core methodology documentation
│   ├── Accounting for Mediation Effects in Risk Prediction Calculators.md
│   ├── Enhanced equation calculations.xlsx
│   └── Accounting for Mediation Effects in Risk Prediction Calculators.pdf
│
├── Simulation studies/                       # Validation and simulation work
│   └── Coronary Heart Disease/
│       ├── Analyses/                         # R analysis scripts
│       │   ├── Dataset_CHD_Framingham_HH_CHD.R
│       │   ├── Dataset_CHD_Framingham_HH_TC_LDL.R
│       │   ├── validation_analysis_Framingham vs HH_TC_LDL.R
│       │   └── validation_analysis_Framingham_vs_HH.R
│       │
│       ├── Model inputs/                     # Risk factor data and prevalence
│       │   ├── TC_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx
│       │   ├── LDL_Framingham CHD Risk Dial Risk Calculator Simulation Study.xlsx
│       │   ├── HH_Framingham CHD Risk Dial Risk Calculator Simualtion Study.xlsx
│       │   ├── TC_WPR_by_Factor_Framingham.xlsx
│       │   ├── LDL_WPR_by_Factor_Framingham.xlsx
│       │   └── HH_WPR_by_Factor_Framingham.xlsx
│       │
│       ├── White paper in markdown/          # Research documentation
│       │   ├── Harrison Healthcare's Risk Calculator Methodology Reproduces the Framingham 10-Year Risk Score in a Simulated Dataset.md
│       │   ├── Harrison Healthcare's Risk Calculator Methodology Reproduces the Framingham 10-Year Risk Score in a Simulated Dataset.pdf
│       │   └── figures/                      # Supporting visualizations
│       │
│       ├── CHD_simulation_study_README.md    # CHD-specific documentation
│       └── README.md                         # Additional CHD documentation
│
└── Spreadsheet/                              # Comprehensive risk factor database
    └── Risk calculator spreadsheet.csv       # Complete risk factor definitions, prevalence, and relative risks
```

## Authors & Contributors

1. **Boaz Y. Saffer, PhD** - Chief Scientific Officer, Harrison Healthcare  
2. **Julia Blumkaitis-Bosankic, MSc** - Research Assistant, Harrison Healthcare
3. **Sidney Nedelmann, BA** - Research Assistant, Harrison Healthcare

## License & Usage

This work is licensed under the [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nc-nd/4.0/).

### What this means:
- ✅ **Share** — copy and redistribute the material in any medium or format
- ✅ **Attribution** — you must give appropriate credit to Harrison Healthcare
- ❌ **NonCommercial** — you may not use the material for commercial purposes
- ❌ **NoDerivatives** — you may not distribute modified versions

### For Commercial Use:
Commercial licensing and partnerships are available. Please contact Harrison Healthcare for commercial use permissions.

*© 2024 Harrison Healthcare. All rights reserved.*