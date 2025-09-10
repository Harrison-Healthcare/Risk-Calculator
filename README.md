
<div align="center">
  <img src="assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Harrison Healthcare Risk Calculator

*Last Updated: September 2025*

## Authors and Contributors

1. **Boaz Y. Saffer, PhD** - Chief Scientific Officer, Harrison Healthcare  
2. **Julia Blumkaitis-Bosankic, MSc** - Research Assistant, Harrison Healthcare
3. **Sidney Nedelmann, BA** - Research Assistant, Harrison Healthcare

## Table of Contents

- [🔬 Overview](#-overview)
- [📁 Repository Contents](#-repository-contents)
- [🗺️ Repository Structure](#️-repository-structure)
- [📄 License & Usage](#-license--usage)

## 🔬 Overview

The Harrison Healthcare Risk Calculator provides evidence-based risk prediction models for 18 major chronic diseases and cancers. Unlike traditional risk calculators that are static and developed from single datasets, our methodology addresses two fundamental limitations in current risk assessment approaches.

**1. Modular and Updateable Framework**

Most existing risk calculators are built from single cohort studies (e.g., Framingham) with fixed structures that cannot be easily modified or updated. Our modular approach enables dynamic risk factor inclusion, continuous weight updates as new evidence emerges, population adaptability across diverse groups, and integration of findings from multiple peer-reviewed studies rather than relying on a single dataset.

**2. Mediation Effect Correction**

Traditional models suffer from risk overestimation when including both lifestyle factors and their downstream biomarkers. For example, including both saturated fat intake and LDL cholesterol levels leads to double-counting the same biological pathway. Our enhanced equation uses a mediation parameter (α) to separate direct and indirect causal pathways, preventing multiplicative error while enabling comprehensive risk factor inclusion.

### Scientific Foundation

This methodology builds on established research:
- **[Colditz et al. (2000)](https://doi.org/10.1023/a:1008984432272)** developed the original HCRI through systematic literature review and calibration with SEER cancer registry data.
- **[Kim et al. (2004)](https://doi.org/10.1097/00000539-200406000-00002)** prospectively evaluated the HCRI using a 10-year period using the Nurses' Health Study for ovary, colon, and pancreas cancer. 
- **[Shrier et al. (2018)](https://doi.org/10.1097/ede.0000000000000820)** provided mathematical generalization to handle multi-level risk factors beyond simple binary categories
- Our **[recent work (2024)](/docs/methodology/mediation-enhancement/Accounting%20for%20mediation%20effects/Accounting%20for%20mediation%20effects%20in%20risk%20prediction%20calculators.md)** applies mediation correction to reduce risk overestimation.

### Disease Coverage (n=18)
- **Cancers (10)**: Bladder, Breast, Cervical, Colorectal, Kidney, Lung, Ovarian, Pancreatic, Prostate, Melanoma
- **Cardiovascular (3)**: Coronary Heart Disease, Hypertension, Stroke  
- **Metabolic (1)**: Type 2 Diabetes
- **Musculoskeletal (1)**: Osteoporosis
- **Neuropsychiatric (3)**: Dementia, Depression, Generalized Anxiety Disorder

## 📁 Repository Contents

### Core Documents
- **[Methodology](./docs/methodology/methodology.md):** Complete methodology documentation with worked examples
- **[Risk Dial Citations](./docs/evidence/risk-dial-citations/):** Peer-reviewed studies and citations that provide the relative risk and prevalence data used to calculate weights in the Harrison Healthcare Risk Dial for each disease.
- **[Risk Calculator Spreadsheet](./data/risk-calculator.csv):** Comprehensive spreadsheet of risk factors, relative risks, and prevalence data for all disease models
- **[Simulation Studies](analysis/simulation-studies):** Validation studies comparing our methodology against established risk prediction tools
  - **[Coronary Heart Disease](./analysis/simulation-studies/coronary-heart-disease/CHD-simulation-study-white%20paper.md):** Validation study comparing our methodology against the Framingham Risk Score.
  - **[Dementia](./analysis/simulation-studies/dementia/Dementia-simulation-study-white%20paper.md):** Validation study comparing our methodology against the Dementia Population Risk Tool (DemPoRT).
  - **[Diabetes](./analysis/simulation-studies/diabetes/Diabetes-simulation-study-white%20paper.md):** Validation study comparing our methodology against QDiabetes for Type 2 Diabetes.


## 🗺️ Repository Structure

```
├── assets/                                   # Media files and branding
│   └── harrison-logo.jpg                     # Harrison Healthcare logo
│
├── docs/                                     # Documentation and evidence
│   ├── methodology/                          # Methodology documentation
│   │   └── methodology.md                    # Complete mathematical derivation
│   └── evidence/                             # Evidence and research summaries
│       ├── risk-dial-citations/              # Peer-reviewed studies for risk dial weights (18 disease summaries)
│       └── jbi-reports/                      # JBI Critical Appraisal reports (~200 files)
│
├── data/                                     # Core datasets and risk calculation inputs
│   └── risk-calculator.csv                   # Main risk factor database
│
└── analysis/                                 # Research studies and validation work
    ├── methodology-enhancements/             # Enhanced methodology research
    │   └── mediation-effects/                # Mediation effect correction methodology
    └── simulation-studies/                   # Validation studies
        ├── coronary-heart-disease/           # CHD validation study
        │   ├── code/                         # R analysis scripts  
        │   ├── data/                         # Study-specific datasets
        │   ├── figures/                      # Generated visualizations
        │   ├── CHD-simulation-study-white paper.md
        │   └── CHD-simulation-study-README.md          
        ├── diabetes/                        # Diabetes validation study
        │   ├── code/                        # R analysis scripts  
        │   ├── data/                        # Study-specific datasets
        │   ├── figures/                     # Generated visualizations
        │   ├── Diabetes-simulation-study-white paper.md
        │   └── Diabetes-simulation-study-README.md
        └── dementia/                         # Dementia validation study
            ├── code/                         # R analysis scripts  
            ├── data/                         # Study-specific datasets
            ├── figures/                      # Generated visualizations
            ├── Dementia-simulation-study-white paper.md
            └── Dementia-simulation-study-README.md
```

## 📄 License & Usage

MIT License

Copyright (c) 2025 Harrison Healthcare

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
