
<div align="center">
  <img src="figures/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Agreement Between Harrison Healthcare’s and DemPoRT Five-Year Dementia Risk Calculator in a Simulated Dataset

This directory contains R code, data files, figures, and documentation for simulating and validating 5‑year dementia risk using both DemPoRT and Harrison Healthcare’s modular dementia risk model (HH–Dementia).

The project is divided into two parts:

1. **Part 1 — DemPoRT Inputs**
   - HH–Dementia supplied with the published DemPoRT specification (predictor coding, coefficients, baseline survival)
   - Tests analytic convergence between HH–Dementia and DemPoRT under identical assumptions

2. **Part 2 — HH Inputs**
   - HH–Dementia supplied with contemporary relative risks and prevalences from recent evidence syntheses
   - DemPoRT remains unchanged
   - Assesses divergence due to updated inputs and structural differences (e.g., DemPoRT’s restricted cubic splines vs HH linear terms)


## Folder Structure
```text
dementia/                                   # DemPoRT validation study
|-- code/                                   # R analysis scripts
|   |-- part 1/                             # DemPoRT inputs
|   `-- part 2/                             # HH inputs (modern)
|-- data/                                   # Study-specific datasets
|   |-- part 1/                             # DemPoRT inputs datasets
|   `-- part 2/                             # HH inputs datasets
|-- figures/                                # Generated visualizations
|   |-- part 1/                             # DemPoRT inputs plots
|   `-- part 2/                             # HH inputs plots
|-- Dementia-simulation-study-white paper.md
`-- Dementia-simulation-study-README.md
```

## Documentation

- **`Dementia-simulation-study-white paper.md`**  
  Full methods, results, and appendix (tables & figures). Matches the Diabetes white paper style with logo, title, author list, date, ToC, and consistent section headings.

- **`Dementia-simulation-study-README.md` (this file)**  
  Project overview, structure, how to run, and conventions.


## Data & Inputs (located in `data/`)

- **Part 1 (DemPoRT Inputs):**
- Builds the synthetic cohort mirroring DemPoRT predictors; computes DemPoRT 5‑year risk and HH–Dementia with identical inputs for analytic convergence.
  - `data/part 1/DemPoRT_Dementia_Risk_Dials.xlsx`
  - `data/part 1/simulation_dataset_final_HH_DemPoRT.xlsx`

- **Part 2 (HH Inputs):**
  - `data/part 2/HH_DemPoRT_Dementia_Risk_Dial_Risk_Calculator_Simulation_Study.xlsx`
  - `data/part 2/simulation_dataset_final_HHmodern_DemPoRT.xlsx`
  
- **Synthetic cohort sizes:** N ≈ 50,000 (≥55 y), harmonised to DemPoRT distributions and correlations.


## Figures (`figures/`)

Plots are written to:

- `figures/part 1/ — DemPoRT inputs comparisons (HH–Dementia vs DemPoRT under identical inputs)

- `figures/part 2/ — HH inputs comparisons (contemporary HH–Dementia vs original DemPoRT)

## Analysis Scripts (`code/`)

### Part 1 — DemPoRT Inputs (original)
- `code/part 1/Dataset_DemPoRT_HH_Dementia.R`  
  Builds the synthetic cohort; computes DemPoRT 5‑year risk and HH–Dementia with identical inputs.  
  **Outputs:** tables → `data/part 1/`, figures → `figures/part 1/`.

- `code/part 1/validation_analysis_DemPoRT.R`  
  Agreement metrics (Pearson, Spearman, ICC) and Bland–Altman (overall/by sex/by age), plus subgroup summaries.  
  **Outputs:** tables → `data/part 1/`, figures → `figures/part 1/`.

*(Optional project file: `code/part 1/Simulation Dataset DemPoRT vs HH_Dementia.Rproj`)*

### Part 2 — HH Inputs (modern)
- `code/part 2/Dataset_DemPoRT_HH_Dementia_Modern.R`  
  Runs HH–Dementia with contemporary RRs & prevalences; compares against DemPoRT.  
  **Outputs:** tables → `data/part 2/`, figures → `figures/part 2/`.

- `code/part 2/validation_analysis_DemPoRT vs HH_modern.R`  
  Agreement metrics and Bland–Altman; subgroup summaries (age bands; sex).  
  **Outputs:** tables → `data/part 2/`, figures → `figures/part 2/`.


## How to Use

1. Install packages:
   ```R
   install.packages(c(
     "dplyr","MASS","tidyr","ggplot2","writexl","purrr",
     "readxl","readr","truncnorm","irr","car","emmeans"
   ))
   ```
2. Set your working directory to the repo root (or open the `.Rproj`).
3. Run the scripts in the order listed above for **Part 1** or **Part 2**.
4. Outputs: Tables → are written to the matching `data/part 1/` or `data/part 2/`; Figures → `figures/part 1/` or `figures/part 2/`.


## Output Variables

Each run produces:
- DemPoRT 5‑year risk
- HH–Dementia 5‑year risk (under DemPoRT inputs and under HH inputs)
- Agreement metrics: Pearson, Spearman, ICC (absolute agreement), Bland–Altman bias & LoA
- Subgroup summaries (age bands; sex)
- Figures: scatterplots, BA (overall/by sex/by age), simple slopes, adjusted means
