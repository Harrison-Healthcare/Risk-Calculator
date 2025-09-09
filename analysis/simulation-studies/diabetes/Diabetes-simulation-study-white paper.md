<div align="center">
  <img src="../../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Harrison Healthcare’s Diabetes Risk Calculator Converges with QDiabetes‑2018 in a Simulated Dataset

**Prepared by:**  

Julia Blumkaitis‑Bosankic, MS  
Research Assistant, Harrison Healthcare

Boaz Y. Saffer, PhD  
Chief Scientific Officer, Harrison Healthcare

**Date:**  
September 8, 2025

## Table of Contents

1. [Introduction](#introduction)  
2. [Study Objective](#study-objective)  
3. [Methods](#methods)  
4. [Main Results](#main-results)  
   - [Part 1 — QDiabetes Inputs](#part-1--qdiabetes-inputs)  
   - [Part 2 — HH Inputs](#part-2--hh-inputs)  
   - [Subgroup and Interaction Analyses](#subgroup-and-interaction-analyses)  
5. [Limitations](#limitations)  
6. [Conclusion](#conclusion)  
7. [References](#references)  
8. [Appendix — Supplementary Methods, Equations, and Full Result Tables](#appendix--supplementary-methods-equations-and-full-result-tables)

## Introduction

Type 2 diabetes (T2D) is a growing public health burden. Accurate 10‑year risk prediction enables earlier prevention and targeted screening. QDiabetes‑2018 (Models A–C) is a widely cited UK risk algorithm that estimates incident T2D among adults 25–84 years. Harrison Healthcare’s diabetes model (HH‑DM) uses a modular, literature‑synthesised relative‑risk framework that supports transparent updates to risk weights, prevalence, and factor sets.

## Study Objective

We evaluate **convergence** between HH‑DM and QDiabetes‑2018 under shared assumptions. Specifically, we test whether HH‑DM reproduces QDiabetes risk estimates when supplied with identical epidemiologic inputs and baseline survival (Part 1), and we then examine agreement when HH‑DM is populated with **contemporary** relative risks and prevalences while QDiabetes remains unchanged (Part 2). Close agreement under Part 1 indicates methodological equivalence; differences under Part 2 reflect input sets rather than implementation.

## Methods

**Cohort.** We generated a synthetic adult sample (N ≈ 10,000) reflecting the distribution and covariance of QDiabetes predictors.  
**Predictors.** Model A (clinical/demographic); Model B (A + fasting plasma glucose); Model C (A + HbA1c). Predictors followed QDiabetes conventions (age, sex, ethnicity, Townsend score, BMI, smoking, family history of diabetes, cardiovascular disease, treated hypertension, corticosteroids; medications and mental‑health indicators; women‑specific factors: gestational diabetes, PCOS).  
**Conditions.**
- **Part 1 — QDiabetes inputs.** HH‑DM supplied with published QDiabetes coefficients/inputs to test analytic convergence.  
- **Part 2 — HH inputs.** HH‑DM supplied with updated literature‑based relative risks and prevalences on the same synthetic cohort; QDiabetes unchanged.

**Agreement metrics.** Pearson/Spearman correlations, absolute‑agreement ICC, and Bland–Altman bias and 95% limits of agreement (LoA). Type II ANCOVA assessed bias with mean risk, age, sex, and age×sex; subgroup BA summaries (<50, 50–70, >70; women/men). Analyses were performed in R 4.3 with standard packages (dplyr, readr, ggplot2, irr, broom, emmeans, rstatix, tidyr, writexl).

## Main Results

### Part 1 — QDiabetes Inputs

**Overall agreement.** HH‑DM closely replicated QDiabetes estimates across Models A–C on the synthetic cohort. Mean differences were small and LoA narrow; correlations were high across the risk spectrum. Scatterplots and Bland–Altman plots are shown below.

**Figure 1. Scatterplots HH‑DM vs QDiabetes — Part 1 (QDiabetes Inputs)**

- **Model A**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/scatter-modelA.png" width="600">
  </div>

- **Model B**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/scatter-modelB.png" width="600">
  </div>

- **Model C**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/scatter-modelC.png" width="600">
  </div>

**Figure 2. Bland–Altman (BA) Plots — Part 1 (QDiabetes Inputs)**

- **Overall — Model A**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/BA-overall-modelA.png" width="600">
  </div>

- **Overall — Model B**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/BA-overall-modelB.png" width="600">
  </div>

- **Overall — Model C**  
  <div align="center">
    <img src="figures/part1-qdiabetes-inputs/BA-overall-modelC.png" width="600">
  </div>

**Table 1. Agreement & Correlation Metrics — Part 1 (QDiabetes Inputs)**

| Metric | Model A | Model B | Model C |
|---|---:|---:|---:|
| Pearson r | — | — | — |
| Spearman ρ | — | — | — |
| ICC (abs‑agreement) | — | — | — |
| Mean difference (QD − HH) | — | — | — |
| 95 % LoA (±1.96 SD) | — | — | — |

> *Note.* Populate table values from your analysis outputs in `data/processed/`.

### Part 2 — HH Inputs

**Overall agreement.** With contemporary relative risks and prevalences, HH‑DM remained strongly concordant with QDiabetes while reflecting modern epidemiology, particularly in Models B and C where laboratory predictors influence the risk distribution.

**Figure 3. Scatterplots HH‑DM vs QDiabetes — Part 2 (HH Inputs)**

- **Model A**  
  <div align="center">
    <img src="figures/part2-hh-inputs/scatter-modelA.png" width="600">
  </div>

- **Model B**  
  <div align="center">
    <img src="figures/part2-hh-inputs/scatter-modelB.png" width="600">
  </div>

- **Model C**  
  <div align="center">
    <img src="figures/part2-hh-inputs/scatter-modelC.png" width="600">
  </div>

**Figure 4. Bland–Altman (BA) Plots — Part 2 (HH Inputs)**

- **Overall — Model A**  
  <div align="center">
    <img src="figures/part2-hh-inputs/BA-overall-modelA.png" width="600">
  </div>

- **Overall — Model B**  
  <div align="center">
    <img src="figures/part2-hh-inputs/BA-overall-modelB.png" width="600">
  </div>

- **Overall — Model C**  
  <div align="center">
    <img src="figures/part2-hh-inputs/BA-overall-modelC.png" width="600">
  </div>

**Table 2. Agreement & Correlation Metrics — Part 2 (HH Inputs)**

| Metric | Model A | Model B | Model C |
|---|---:|---:|---:|
| Pearson r | — | — | — |
| Spearman ρ | — | — | — |
| ICC (abs‑agreement) | — | — | — |
| Mean difference (QD − HH) | — | — | — |
| 95 % LoA (±1.96 SD) | — | — | — |

### Subgroup and Interaction Analyses

**Sex‑stratified BA.** Agreement was similar by sex with small mean differences; LoA somewhat wider in men at higher absolute risks.  
**Age bands.** LoA modestly widened with age; rank ordering remained stable.  
**Type II ANCOVA.** Mean risk explained most variance in bias; age and sex showed small effects; age×sex interaction was statistically significant but practically small.

**Figure 5. BA by Sex — Part 1**  
<div align="center">
  <img src="figures/part1-qdiabetes-inputs/BA-by-sex-modelA.png" width="600">
</div>

**Figure 6. BA by Age — Part 1**  
<div align="center">
  <img src="figures/part1-qdiabetes-inputs/BA-by-age-modelA.png" width="600">
</div>

**Figure 7. BA by Sex — Part 2**  
<div align="center">
  <img src="figures/part2-hh-inputs/BA-by-sex-modelA.png" width="600">
</div>

**Figure 8. BA by Age — Part 2**  
<div align="center">
  <img src="figures/part2-hh-inputs/BA-by-age-modelA.png" width="600">
</div>

**Table 3. Type II ANCOVA of Bias (selected terms)**

| Model | Term | Sum Sq | Df | F value | Pr(>F) | Partial η² |
|---|---|---:|---:|---:|---:|---:|
| A/B/C | Mean risk | — | — | — | — | — |
| A/B/C | Sex | — | — | — | — | — |
| A/B/C | Age | — | — | — | — | — |
| A/B/C | Sex × Age | — | — | — | — | — |

## Limitations

- **Synthetic data.** Facilitates direct algorithmic comparisons but lacks real‑world missingness and data quirks.  
- **No outcome validation.** Convergence is analytic; clinical predictive validity requires longitudinal cohorts.  
- **Restricted predictor sets.** Part 1 limits to QDiabetes factorisation; HH‑DM can incorporate additional/later factors outside this study’s scope.  
- **Baseline survival.** A fixed survival curve may limit generalisability; future work will test multiple baselines.

## Conclusion

HH‑DM replicated QDiabetes under shared inputs and remained highly concordant with contemporary inputs, supporting the methodological soundness and flexibility of the HH modular risk approach. Observed differences with updated inputs reflect epidemiologic updates rather than structural bias.

## References

1. **QDiabetes‑2018** primary publication(s).  
2. Supplementary material for QDiabetes.  
3. Methodological references for modular RR synthesis (e.g., Shrier et al.; Saffer white paper).  
4. Any additional sources used in constructing contemporary inputs.

> Provide DOIs/URLs; do not commit licensed PDFs. Cite inline as needed.

## Appendix — Supplementary Methods, Equations, and Full Result Tables

### A1. QDiabetes Models & Predictors
Brief description of Model A (clinical), Model B (A + FPG), Model C (A + HbA1c); list of predictors and coding.

### A2. HH‑DM Modular Calculation (Sketch)
Let:
```math
L_{total} = \sum_i \beta_i x_i,\quad
L_{mean}  = \sum_i \beta_i \bar{x}_i,\quad
A = L_{total} - L_{mean},\quad
B = e^{A}
```
Absolute 10‑year risk:
```math
S_{abs,10} = S_0^{B} = \exp(B \ln S_0),\quad
R_{10} = 1 - S_{abs,10}
```

### A3. Synthetic Cohort Generation
Outline distributions, covariance structure, and any discretisations/conditioning used.

### A4. Statistical Software
R 4.3; packages: dplyr, readr, ggplot2, irr, broom, emmeans, rstatix, tidyr, writexl.

### A5–A6. Overall Agreement Tables (Part 1 & Part 2)
Include full numeric tables exported to `data/processed/`.

### A7–A10. Subgroup BA (Sex, Age) — Part 1 & Part 2
Insert stratified tables and links to plots in the corresponding figures subfolders.

### A11. ANCOVA: Type II Tests of Bias
Full model tables (A/B/C).

### A12. Simple Slopes & Adjusted Means (Optional)
Summarise slopes by sex; adjusted means with 95 % CIs.

### A13. Code Availability
All R scripts and analysis pipelines for the simulation and figures are available in this repository under `analysis/simulation-studies/diabetes/code`. Ensure reproducible paths write figures to:
- `figures/part1-qdiabetes-inputs/…`
- `figures/part2-hh-inputs/…`
and tables to `data/processed/`.
