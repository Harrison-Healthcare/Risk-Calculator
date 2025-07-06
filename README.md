# Harrison Healthcare Risk Calculator

*Last Updated: July 2024*

## Table of Contents

- [🔬 Overview](#-overview)
- [📁 Repository Contents](#-repository-contents)
- [🗂️ Repository Structure](#️-repository-structure)
- [👥 Authors & Contributors](#-authors--contributors)
- [📄 License & Usage](#-license--usage)

## 🔬 Overview

The Harrison Healthcare Risk Calculator provides evidence-based risk prediction models for 18 major chronic diseases and cancers. Unlike traditional risk calculators that are static and developed from single datasets, our methodology addresses two fundamental limitations in current risk assessment approaches.

### Key Methodological Advantages

**1. Modular and Updateable Framework**

Most existing risk calculators are built from single cohort studies (e.g., Framingham) with fixed structures that cannot be easily modified or updated. Our modular approach enables dynamic risk factor inclusion, continuous weight updates as new evidence emerges, population adaptability across diverse groups, and integration of findings from multiple peer-reviewed studies rather than relying on a single dataset.

**2. Mediation Effect Correction**

Traditional models suffer from risk overestimation when including both lifestyle factors and their downstream biomarkers. For example, including both saturated fat intake and LDL cholesterol levels leads to double-counting the same biological pathway. Our enhanced equation uses a mediation parameter (α) to separate direct and indirect causal pathways, preventing multiplicative error while enabling comprehensive risk factor inclusion.

### Scientific Foundation

This methodology builds on established research:
- **Colditz et al. (2000)** developed the original HCRI through systematic literature review and calibration with SEER cancer registry data
- **Shrier et al. (2018)** provided mathematical generalization to handle multi-level risk factors beyond simple binary categories
- **Current work** integrates modular updating capabilities and mediation effect correction

### Disease Coverage (n=18)
- **Cancers (10)**: Bladder, Breast, Cervical, Colorectal, Kidney, Lung, Ovarian, Pancreatic, Prostate, Melanoma
- **Cardiovascular (3)**: Coronary Heart Disease, Hypertension, Stroke  
- **Metabolic (2)**: Type 2 Diabetes, Osteoporosis
- **Neuropsychiatric (3)**: Dementia, Depression, Generalized Anxiety Disorder

### Clinical Application

The modular design enables practical advantages for clinical and research applications. Risk factors, relative risks, and prevalence estimates are continuously derived from the latest peer-reviewed meta-analyses and national health surveys, ensuring models remain current with evolving scientific evidence. This approach contrasts with static calculators that become outdated as new research emerges, allowing healthcare providers to access risk assessments that reflect the most recent understanding of disease causation and population health trends.

## 📁 Repository Contents

### Core Documents
- **[Methodology](./Methodology/Accounting%20for%20mediation%20effects/Accounting%20for%20mediation%20effects%20in%20risk%20prediction%20calculators.md)** - Complete mathematical derivation of the enhanced HCRI equation with worked examples
- **[Risk Spreadsheet](./Risk%20spreadsheet.csv)** - Comprehensive database of risk factors, relative risks, and prevalence data for all disease models
- **[CHD Validation Study](./Simulation%20studies/Coronary%20Heart%20Disease/)** - Validation comparing our methodology against established Framingham Risk Score (correlation r > 0.95)


## 🗂️ Repository Structure

```
├── Methodology enhancements/                 # Enhanced methodology documentation
│   └── Accounting for mediation effects/    # Core mediation methodology
│       ├── Accounting for mediation effects in risk prediction calculators.md
│       └── Enhanced equation calculations.xlsx
│
├── Methodology.md                            # Main methodology document
│
├── Risk spreadsheet.csv                      # Complete risk factor database
│                                             # (risk factors, relative risks, prevalence data)
│
└── Simulation studies/                       # Validation and simulation work
    └── Coronary Heart Disease/               # CHD validation study
        ├── Analyses/                         # R analysis scripts
        ├── Model inputs/                     # Risk factor data and prevalence
        ├── White paper in markdown/          # Research documentation
        └── README files                      # Study-specific documentation
```

## 👥 Authors & Contributors

1. **Boaz Y. Saffer, PhD** - Chief Scientific Officer, Harrison Healthcare  
2. **Julia Blumkaitis-Bosankic, MSc** - Research Assistant, Harrison Healthcare
3. **Sidney Nedelmann, BA** - Research Assistant, Harrison Healthcare

## 📄 License & Usage

This work is licensed under the [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nc-nd/4.0/).

### What this means:
- ✅ **Share** — copy and redistribute the material in any medium or format
- ✅ **Attribution** — you must give appropriate credit to Harrison Healthcare
- ❌ **NonCommercial** — you may not use the material for commercial purposes
- ❌ **NoDerivatives** — you may not distribute modified versions

### For Commercial Use:
Commercial licensing and partnerships are available. Please contact Harrison Healthcare for commercial use permissions.

*© 2024 Harrison Healthcare. All rights reserved.*