<p align="center">
  <img src="figures/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150"/>
</p>

---

# Agreement Between Harrison Healthcare’s and DemPoRT Five‑Year Dementia Risk Calculators in a Simulated Dataset

**Prepared by:**
Sidney Nedelmann, BA
Research Assistant, Harrison Healthcare

Julia Blumkaitis-Bosankic, MS
Research Assistant, Harrison Healthcare

Boaz Y. Saffer, PhD
Chief Scientific Officer, Harrison Healthcare

**Date:**
September 9, 2025

---

## Table of Contents

* [Introduction](#introduction)
* [Study Objective](#study-objective)
* [Methods](#methods)

  * [Synthetic Cohort](#synthetic-cohort)
  * [Risk Calculations](#risk-calculations)
  * [Statistical Comparisons](#statistical-comparisons)
* [Results](#results)

  * [Overall Agreement](#overall-agreement)
  * [Convergence Across the Risk Spectrum](#convergence-across-the-risk-spectrum)
  * [Age and Sex Effects](#age-and-sex-effects)
  * [Overall Agreement — HH Inputs](#overall-agreement--hh-inputs)
  * [Convergence Across the Risk Spectrum — HH Inputs](#convergence-across-the-risk-spectrum--hh-inputs)
  * [Age and Sex Effects — HH Inputs](#age-and-sex-effects--hh-inputs)
* [Limitations](#limitations)
* [Conclusion](#conclusion)
* [References](#references)
* [Appendix — Supplementary Methods, Full Tables, Additional Graphs](#appendix--supplementary-methods-full-tables-additional-graphs)

  * [Part 1: DemPoRT Inputs](#part-1-demport-inputs)

    * [A1. Overall Agreement](#a1-overall-agreement)
    * [A2. Age and Sex Differences](#a2-age-and-sex-differences)
  * [Part 2: HH Inputs](#part-2-hh-inputs)

    * [A3. Overall Agreement — HH Inputs](#a3-overall-agreement--hh-inputs)
    * [A4. Age and Sex Differences — HH Inputs](#a4-age-and-sex-differences--hh-inputs)

---

## Introduction

Dementia is a leading cause of disability and dependency worldwide. Prevalence is projected to triple by 2050, and up to half of cases may be preventable or delayable through risk‑factor modification, underscoring the importance of early risk identification (Hampel et al., 2022; Livingston et al., 2024; WHO, 2019).

The Dementia Population Risk Tool (DemPoRT) is a sex‑specific algorithm estimating 5‑year incident dementia risk among community‑dwelling adults aged ≥55 years (Fisher et al., 2021). Built from the Canadian Community Health Survey linked to administrative data, DemPoRT uses Fine–Gray subdistribution hazards to handle the competing risk of death and assigns regression‑based weights to socio‑demographic, health behaviour, and clinical factors. Continuous predictors are modelled with restricted cubic splines (RCS) and centred at population means.

Harrison Healthcare’s (HH) risk platform is a modular, literature‑driven framework. Predictor‑specific relative risks (RRs) are standardised to population averages and combined multiplicatively to form a composite risk score. This score is log‑transformed and mapped to absolute risk using a calibrated baseline survival (S₀), enabling alignment to a 5‑year horizon for comparison with DemPoRT. The modular design allows rapid updates to RRs and prevalences without changing the overall structure.

## Study Objective

To test whether HH–Dementia can reproduce DemPoRT 5‑year risk estimates when supplied with the same inputs and published coefficients (concordance under shared assumptions), and to examine agreement when HH–Dementia is run with updated (modern) evidence on RRs and prevalences.

## Methods

### Synthetic Cohort

We generated a synthetic cohort of 50,000 adults aged ≥55 years (43% male) matched to distributions reported for DemPoRT. Continuous variables (age, pack‑years, alcohol intake, fruit/vegetable servings, weekly physical activity in METs, BMI) were simulated from multivariate normal distributions using published means/SDs; correlations were informed by large general‑population cohorts (e.g., CLSA, NHANES). Categorical variables (sex, ethnicity, smoking status) reflected published prevalences. DemPoRT predictors for potato intake, juice intake, and survey cycle were excluded (minimal contribution and not applicable to HH).

### Risk Calculations

**DemPoRT.** We implemented the published model with RCS for continuous predictors, centred predictors, β‑coefficients, and sex‑specific baseline survival to yield individual 5‑year risk.

**HH–Dementia.** We applied a modular RR approach using contemporary prevalence estimates. Each RR was standardised to the population mean and combined multiplicatively; the composite was transformed to 5‑year absolute risk via sex‑specific baseline incidence calibrated to DemPoRT’s 5‑year incidence. Continuous predictors were treated linearly (no splines or age interactions); variables were harmonised with DemPoRT wherever possible.

### Statistical Comparisons

Agreement metrics included Pearson r, Spearman ρ, and a two‑way absolute‑agreement intraclass correlation coefficient (ICC). Bland–Altman analyses estimated mean bias and 95% limits of agreement (LoA), with penalised splines to visualise non‑linear trends. Results were stratified by sex and age (55–69, 70–79, 80+). We modelled bias via ANCOVA (age, sex, age×sex), estimated adjusted means (marginal means), and used appropriate post‑hoc tests. Analyses were run in R 4.3.x (dplyr, ggplot2, irr, rstatix, car, emmeans, broom, mgcv, scales).

## Results

### Overall Agreement

Across 50,000 records, DemPoRT and HH–Dementia showed strong association (r = 0.804; ρ = 0.956) and moderate absolute agreement (ICC = 0.670). Concordance is tight at lower predicted risk, with larger numerical gaps at higher risk. In upper ranges, HH tends to yield higher risks, while DemPoRT flattens near mid‑range (Figure 1).

**Figure 1.** Scatterplot of DemPoRT vs HH–Dementia using DemPoRT Inputs

<div align="center">
  <img src="figures/part 1/scatter_DemPoRT_vs_HH.png" width="600"/>
</div>

### Convergence Across the Risk Spectrum

Average bias was small: DemPoRT – HH = −1.8 pp (SD = 5.1 pp); 95% LoA: −11.8 to +8.1 pp. Agreement is near‑perfect at low mean risk and widens as risk increases, with DemPoRT generally lower than HH at higher risk (Figure 2).

**Figure 2.** Bland–Altman Plot Comparing DemPoRT and HH–Dementia using DemPoRT Inputs

<div align="center">
  <img src="figures/part 1/BA_overall.png" width="600"/>
</div>

### Age and Sex Effects

Divergence varies by age and sex. Mean bias (DemPoRT – HH) is −0.3 pp (LoA ±1.8) at 55–69, −2.4 pp (±8.6) at 70–79, and −6.1 pp (±19.9) at 80+. Women show larger average gaps and spread (−3.7 pp, ±11.8) than men (+0.6 pp, ±2.5). ANCOVA indicates significant main effects and age×sex interaction (all *p* < 0.001). Simple slopes suggest the HH–DemPoRT difference becomes slightly more negative with age in women (sex gap widens) ([Figure A1](#table-a1-agreement-and-correlation-metrics-for-demport-vs-hh-dementia-risk-scores)).

### Overall Agreement — HH Inputs

With modern HH inputs (updated RRs and prevalences), correlation remained significant (r = 0.659; ρ = 0.726) with modest absolute agreement (ICC = 0.535*. Bland–Altman patterns again show increasing divergence at higher risk where HH tends to over‑predict relative to DemPoRT (Figures 3–4).

**Figure 3.** Scatterplot of DemPoRT vs HH–Dementia using HH Inputs

<div align="center">
  <img src="figures/part 2/scatter_DemPoRT_vs_HH_modern.png" width="600"/>
</div>

**Figure 4.** Bland–Altman Plot Comparing DemPoRT and HH–Dementia using HH Inputs

<div align="center">
  <img src="figures/part 2/BA_overall_modern.png" width="600"/>
</div>

### Convergence Across the Risk Spectrum — HH Inputs

Agreement is close at lower predicted risk and decreases with increasing risk. Bias patterns are consistent with HH’s linear treatment of continuous predictors versus DemPoRT’s RCS‑based attenuation, yielding higher HH estimates among higher‑risk individuals.

### Age and Sex Effects — HH Inputs

Preliminary stratified results echo Part 1. Divergence is larger in women (partly reflecting DemPoRT’s female‑specific predictors not implemented in HH) and increases with age (HH linear terms continue to escalate risk whereas DemPoRT’s splines flatten). See Appendix ([Tables B3–B5](#table-b3-age‑-and-sex‑stratified-statistics)) and ([Figures B1–B3](#figure-b1-simple-slopes-of-bias-vs-age-by-sex)).

Detailed results for all subgroup and interaction analyses are provided in the Appendix.

## Limitations

* Synthetic cohort approximates reported distributions/correlations; real‑world data may yield different agreement due to missingness, measurement error, and unmodelled dependencies.
* Focus is concordance between calculators, not predictive validity against observed outcomes (no discrimination/calibration to events assessed here).
* For comparability, HH predictors were limited to DemPoRT variables; potential added value of HH‑specific variables (e.g., additional clinical/biomarker factors) not assessed.
* DemPoRT cohort skews older (mean \~69 y); generalisability to younger groups is uncertain.
* Structural differences: DemPoRT uses RCS and age interactions; HH currently uses linear effects. This likely explains small overall mean bias and widening gaps at higher risk. Harmonising functional forms (e.g., adding splines to HH) or applying calibration could reduce discrepancies.

## Conclusion

DemPoRT and HH–Dementia show strong overall concordance with small average differences in 5‑year risk. Agreement is excellent at low risk, diverges modestly at intermediate levels, and widens at higher risk—particularly among older adults and women—primarily due to model form (RCS vs linear) and sex‑specific variables.

Using modern HH inputs preserves rank‑order agreement but increases absolute divergence at the high end, reflecting HH’s modular updates and differences from DemPoRT’s spline‑based structure. The calculators are effectively interchangeable at low risk; at higher risk, thresholds and calibration may need to be model‑specific. Future work should evaluate discrimination, calibration, and clinical utility in real‑world cohorts.

## References

* Desquilbet, L., & Mariotti, F. (2010). Dose–response analyses using restricted cubic splines in public health research. *Statistics in Medicine*, 29(9), 1037–1057. [https://doi.org/10.1002/sim.3841](https://doi.org/10.1002/sim.3841)
* Fisher, S., Manuel, D. G., Hsu, A. T., Bennett, C., Tuna, M., Bader Eddeen, A., Sequeira, Y., Jessri, M., Taljaard, M., Anderson, G. M., & Tanuseputro, P. (2021). Development and validation of a predictive algorithm for risk of dementia in the community setting. *Journal of Epidemiology and Community Health*, 75(9), 843–853. [https://doi.org/10.1136/jech-2020-214797](https://doi.org/10.1136/jech-2020-214797)
* Hampel, H., Vergallo, A., Iwatsubo, T., Cho, M., Kurokawa, K., Wang, H., Kurzman, H. R., & Chen, C. (2022). Evaluation of national dementia policies and system preparedness. *Alzheimer’s & Dementia*, 18(10), 1993–2002. [https://doi.org/10.1002/alz.12655](https://doi.org/10.1002/alz.12655)
* Livingston, G., Huntley, J., Liu, K. Y., et al. (2024). Dementia prevention, intervention, and care: 2024 report of the Lancet Commission. *The Lancet*, 404(10452), 572–628. [https://doi.org/10.1016/S0140-6736(24)01296-0](https://doi.org/10.1016/S0140-6736%2824%2901296-0)
* Luke, A., Dugas, L. R., Durazo‑Arvizu, R. A., Cao, G., & Cooper, R. S. (2011). Assessing physical activity and its relationship to cardiovascular risk factors: NHANES 2003–2006. *BMC Public Health*, 11, 387. [https://doi.org/10.1186/1471-2458-11-387](https://doi.org/10.1186/1471-2458-11-387)
* van Allen, Z., Bacon, S. L., Bernard, P., et al. (2023). Clustering of health behaviours in Canadians: CLSA. *Annals of Behavioral Medicine*, 57(8), 662–675. [https://doi.org/10.1093/abm/kaad008](https://doi.org/10.1093/abm/kaad008)
* World Health Organization. (2019). *Risk reduction of cognitive decline and dementia: WHO guidelines*. [https://www.who.int/publications/i/item/risk-reduction-of-cognitive-decline-and-dementia](https://www.who.int/publications/i/item/risk-reduction-of-cognitive-decline-and-dementia)

---

## Appendix — Supplementary Methods, Full Tables, Additional Graphs

### Part 1: DemPoRT Inputs

#### A1. Overall Agreement

**Table A1.** Agreement and Correlation Metrics for DemPoRT vs HH–Dementia Risk Scores

| Metric                         | Value            |
| ------------------------------ | ---------------- |
| Pearson *r*                    | 0.804            |
| Spearman *ρ*                   | 0.956            |
| ICC (abs‑agreement)            | 0.670            |
| Mean difference (DemPoRT − HH) | −0.018           |
| 95% LoA (±1.96 SD)             | −0.118 to +0.081 |

**Table A2.** Bland–Altman Convergence summary

| Mean Difference | SD(Diff) | 95% LoA Lower | 95% LoA Upper |
| --------------: | -------: | ------------: | ------------: |
|          −0.018 |    0.051 |        −0.118 |        +0.081 |

#### A2. Age and Sex Differences

**Table A3.** Age‑ and Sex‑stratified Bland–Altman and Correlation Statistics

| Group  | Mean Difference | LoA (±) | Pearson | Spearman |
| ------ | --------------: | ------: | ------: | -------: |
| Female |          −0.037 |   0.118 |   0.841 |    0.965 |
| Male   |          +0.006 |   0.024 |   0.961 |    0.991 |
| 55–69  |          −0.003 |   0.018 |   0.888 |    0.954 |
| 70–79  |          −0.024 |   0.086 |   0.629 |    0.683 |
| 80+    |          −0.061 |   0.199 |   0.284 |    0.299 |

**Table A4.** Type III ANCOVA of Bias (DemPoRT − HH)

| Term      | Sum Sq |    Df |  F value | Pr(>F) |     MS | Partial η² |
| --------- | -----: | ----: | -------: | -----: | -----: | ---------: |
| Intercept |  33.59 |     1 | 25585.52 | <.0001 | 33.585 |      0.339 |
| Sex       | 20.342 |     1 | 15497.17 | <.0001 | 20.342 |      0.237 |
| Age       | 40.328 |     1 | 30722.32 | <.0001 | 40.328 |      0.381 |
| Sex × Age | 22.564 |     1 | 17189.79 | <.0001 | 22.564 |      0.256 |
| Residuals | 65.627 | 49996 |        — |      — |  0.001 |      0.500 |

**Table A5.** Simple Slopes & Adjusted Means (bias = DemPoRT − HH)

| Sex    | Age Slope (SE) |         *t* (df) |   *p* | Adjusted Mean Bias \[95% CI] | Female − Male Contrast \[95% CI] |   *p* |
| ------ | -------------: | ---------------: | ----: | ---------------------------: | -------------------------------: | ----: |
| Female | −0.030 (0.000) | −159.96 (49,996) | <.001 |     −0.035 \[−0.034, −0.035] |         −0.041 \[−0.042, −0.040] | <.001 |
| Male   | +0.007 (0.000) |  +26.23 (49,996) | <.001 |     +0.006 \[+0.006, +0.007] |                                — |     — |

**Figure A1.** Simple Slopes of Bias vs Age by Sex

<div align="center">
  <img src="figures/part 1/simple_slopes_bias_age_sex.png" width="600"/>
</div>

**Figure A2.** Bland–Altman Plots by Sex

<p align="center">
  <img src="figures/part 1/BA_by_Sex.png" width="600"/>
</p>

**Figure A3.** Bland–Altman Plots by Age Group

<p align="center">
  <img src="figures/part 1/BA_by_Age_Group.png" width="600"/>
</p>


### Part 2: HH Inputs

#### A3. Overall Agreement — HH Inputs

**Table B1.** Agreement Metrics 

| Metric                         | Value               |
| ------------------------------ | ------------------- |
| Pearson *r*                    | 0.659 (*p* < 0.001) |
| Spearman *ρ*                   | 0.726 (*p* < 0.001) |
| ICC (abs‑agreement)            | 0.535 (*p* < 0.001) |
| Mean difference (DemPoRT − HH) | −0.005              |
| 95% LoA (±1.96 SD)             | −0.141 to +0.131    |

**Table B2.** Bland–Altman mean Difference Summary (Modern HH Inputs)

| Mean Difference | SD(Diff) | 95% LoA Lower | 95% LoA Upper |
| --------------: | -------: | ------------: | ------------: |
|          −0.005 |    0.069 |        −0.141 |        +0.131 |

#### A4. Age and Sex Differences — HH Inputs

**Table B3.** Age‑ and Sex‑stratified Statistics 

| Group  | Mean Difference | LoA (±) | Pearson | Spearman |
| ------ | --------------: | ------: | ------: | -------: |
| Female |          −0.020 |   0.164 |   0.689 |    0.764 |
| Male   |          +0.016 |   0.064 |   0.682 |    0.726 |
| 55–69  |          +0.002 |   0.030 |   0.181 |    0.166 |
| 70–79  |          +0.023 |   0.076 |   0.374 |    0.435 |
| 80+    |          −0.085 |   0.276 |   0.191 |    0.187 |

**Table B4.** Type III ANCOVA of Bias

| Term      |  Sum Sq |     Df |  F value | Pr(>F) |     MS | Partial η² |
| --------- | ------: | -----: | -------: | -----: | -----: | ---------: |
| Intercept |   0.035 |      1 |    9.463 | 0.0020 |  0.035 |      0.000 |
| Age       |   8.911 |      1 | 2421.786 | <.0001 |  8.911 |      0.046 |
| Sex       |  14.149 |      1 | 3845.648 | <.0001 | 14.149 |      0.071 |
| Age × Sex |  23.033 |      1 | 6260.071 | <.0001 | 23.033 |      0.111 |
| Residuals | 183.952 | 49,996 |        — |      — |  0.004 |      0.500 |

**Table B5.** Simple Slopes & Adjusted Means 

| Sex    |       Age Slope (SE) |          *t* (df) |   *p* | Adjusted Mean Bias \[95% CI] | Female − Male Contrast \[95% CI] |   *p* |
| ------ | -------------------: | ----------------: | ----: | ---------------------------: | -------------------------------: | ----: |
| Female | −0.003651 (0.000036) | −102.802 (49,996) | <.001 |     −0.018 \[−0.019, −0.017] |         −0.034 \[−0.035, −0.033] | <.001 |
| Male   | +0.000851 (0.000044) |  +19.141 (49,996) | <.001 |     +0.016 \[+0.015, +0.017] |                                — |     — |

**Figure B1.** Simple Slopes of Bias vs Age by Sex 

<div align="center">
  <img src="figures/part 2/simple_slopes_bias_age_sex_modern.png" width="600"/>
</div>

**Figure B2.** Bland–Altman Plots by Sex 

<p align="center">
  <img src="figures/part 2/BA_by_Sex_modern.png" width="600"/>
</p>

**Figure B3.** Bland–Altman Plots by Age Group 

<p align="center">
  <img src="figures/part 2/BA_by_Age_Group_modern.png" width="600"/>
</p>

---

<p align="center">www.harrisonhealthcare.ca</p>
