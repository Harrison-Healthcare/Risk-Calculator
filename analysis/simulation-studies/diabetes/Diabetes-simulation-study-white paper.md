<div align="center">
  <img src="../../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---
# Table of Contents
## Table of Contents

  - [Synthetic Cohort](#synthetic-cohort)
  - [Risk Calculations](#risk-calculations)
  - [Statistical Comparisons](#statistical-comparisons)
  - [Overall Agreement](#overall-agreement)
  - [Convergence Across the Risk Spectrum](#convergence-across-the-risk-spectrum)
  - [Age and Sex Effects](#age-and-sex-effects)
  - [Overall Agreement – HH Inputs](#overall-agreement-hh-inputs)
  - [Average difference and limits of agreement (Bland–Altman) – HH Inputs](#average-difference-and-limits-of-agreement-blandaltman-hh-inputs)
  - [Age and Sex Patterns – HH Inputs](#age-and-sex-patterns-hh-inputs)
  - [**A1. Overall Agreement**](#a1-overall-agreement)
  - [**A2. Age and Sex Differences**](#a2-age-and-sex-differences)
  - [**A3. Overall Agreement - HH Inputs**](#a3-overall-agreement-hh-inputs)
  - [**A4. Age and Sex Differences – HH Inputs**](#a4-age-and-sex-differences-hh-inputs)

[Introduction [3](#introduction-1)](#introduction-1)

[Study Objective [3](#study-objective)](#study-objective)

[Methods [4](#methods)](#methods)

[Synthetic Cohort [4](#synthetic-cohort)](#synthetic-cohort)

[Risk Calculations [4](#risk-calculations)](#risk-calculations)

[Statistical Comparisons [5](#statistical-comparisons)](#statistical-comparisons)

[Results [5](#results)](#results)

[Overall Agreement [5](#overall-agreement)](#overall-agreement)

[Convergence Across the Risk Spectrum [7](#convergence-across-the-risk-spectrum)](#convergence-across-the-risk-spectrum)

[Age and Sex Effects [9](#age-and-sex-effects)](#age-and-sex-effects)

[Overall Agreement – HH Inputs [10](#overall-agreement-hh-inputs)](#overall-agreement-hh-inputs)

[Average difference and limits of agreement (Bland–Altman) – HH Inputs [11](#average-difference-and-limits-of-agreement-blandaltman-hh-inputs)](#average-difference-and-limits-of-agreement-blandaltman-hh-inputs)

[Age and Sex Patterns – HH Inputs [13](#age-and-sex-patterns-hh-inputs)](#age-and-sex-patterns-hh-inputs)

[Limitations [13](#limitations)](#limitations)

[Conclusion [14](#conclusion)](#conclusion)

[References [15](#references)](#references)

[Appendix — Supplementary Methods, Full Result Tables, Additional Graphs [16](#appendix-supplementary-methods-full-result-tables-additional-graphs)](#appendix-supplementary-methods-full-result-tables-additional-graphs)

[Part 1 QDiabetes Inputs [16](#part-1-qdiabetes-inputs)](#part-1-qdiabetes-inputs)

[A1. Overall Agreement [16](#a1.-overall-agreement)](#a1.-overall-agreement)

[A2. Age and Sex Differences [17](#a2.-age-and-sex-differences)](#a2.-age-and-sex-differences)

[Part 2: HH Inputs [22](#part-2-hh-inputs)](#part-2-hh-inputs)

[A3. Overall Agreement - HH Inputs [22](#a3.-overall-agreement---hh-inputs)](#a3.-overall-agreement---hh-inputs)

[A4. Age and Sex Differences – HH Inputs [22](#a4.-age-and-sex-differences-hh-inputs)](#a4.-age-and-sex-differences-hh-inputs)

# Introduction

Type 2 diabetes (T2D) affects more than 500 million adults worldwide and is a leading cause of blindness, kidney failure, heart attack, stroke, and lower‑limb amputation (World Health Organization, 2023). Early identification of individuals at high risk is therefore critical for timely intervention.

The QDiabetes algorithm, developed by the UK’s NHS and first published in the British Medical Journal by Hippisley-Cox et al. (2017), estimates an individual’s 10-year risk of developing type 2 diabetes (T2D). It comprises three models: Model A, which uses only non-biochemical variables; Model B, which builds on Model A by adding fasting blood glucose; and Model C, which further incorporates HbA1c.

Each model uses fractional‑polynomial terms to calculate non-linear relationships between continuous predictors and log‑risk for TSD. It was selected for the present study because its equations are fully published, extensively validated in external cohorts, and rely on variables already captured in the Harrison Healthcare (HH) risk calculator, making it an ideal benchmark.

This white paper comprises two parts: Part 1 compares the Harrison Healthcare (HH) Diabetes risk calculator with the QDiabetes risk calculator using the original QDiabetes algorithm inputs in a synthetic dataset. The aim is to confirm that the methodology and calculations used by HH replicate the established QDiabetes estimates when provided with identical inputs and published coefficients. Part 2 applies contemporary research inputs—updated relative risks and prevalence—to the HH Diabetes risk calculator and, using the same synthetic dataset, compares 10-year risk with QDiabetes Models A–C across sex and age groups. The aim is to evaluate HH under current evidence and note any differences related to blood-based predictors.

# Study Objective

The objective of this study is to determine whether the HH Diabetes risk calculator methodology can reproduce 10-year risk estimates generated by the QDiabetes algorithm (Models A–C), when supplied with identical inputs and published coefficients. Establishing convergence serves as a crucial methodological validation step, demonstrating that underlying methodology for the HH risk calculator produces outputs comparable to the gold-standard QDiabetes model under shared assumptions. This comparison helps rule out potential structural convergences in the HH algorithm and ensures that any future divergence in risk estimates reflects differences in epidemiological inputs rather than differences in the underlying model design.

To evaluate convergence between the two risk calculators, we applied the original QDiabetes inputs to the HH model using a synthetic dataset constructed to closely match the published QDiabetes parameters. The degree of convergence between the calculators was systematically assessed.

# Methods

### Synthetic Cohort

A synthetic sample of 500,000 adults aged 25–84 years (49% male) was generated to mirror the demographic and clinical distributions reported in the QDiabetes derivation cohort (Hippisley‑Cox et al., 2017). Continuous variables such as age, body mass index (BMI), systolic blood pressure, fasting glucose, and HbA1c were drawn from multivariate normal distributions with means, standard deviations, and correlations derived from the original publication. Categorical variables including sex, ethnicity, smoking status, family history of diabetes, learning disability, severe mental illness, comorbidities use, and antihypertensive therapy were simulated using published prevalences. Typical antipsychotic medication, cardiovascular disease history, polycystic ovary syndrome, and gestational diabetes were set to published baseline rates where applicable. The Townsend deprivation score (postcode related, area-level index from unemployment, non-car ownership, non-home ownership, overcrowding) was not used in HH risk calculation and was fixed to the national median in QDiabetes for all records.

### Risk Calculations

For each individual, 10‑year T2D risk estimates were calculated using two approaches. The first approach used the published QDiabetes equations (Models A, B, and C, <https://qdiabetes.org/src.php>), which included fractional‑polynomial (FP) terms and sex‑specific baseline survival values (S0). The second approach (HH inputs) employed HH independently developed calculator using identical coefficients and FP transformations.

For part 2 in HH, we used updated evidence from recent systematic reviews and large cohort studies to inform parameter choices. Where available, we updated relative risks (RRs) and baseline incidence/prevalence. Because published evidence does not separate effects by the three QDiabetes Models (i.e., A–C), we could not set model‑specific RRs or baseline rates; instead, the same updated parameter set was applied across comparisons with Models A, B, and C. For covariates without meta-analytic or large‑cohort support as QDiabetes‑specific risk factors (e.g., atypical antipsychotic use, systemic corticosteroid use, and learning disability) we retained the original QDiabetes values to maintain consistency between tools.

### Statistical Comparisons

Agreement between the two calculators was evaluated using Pearson correlation (r) for linear association, Spearman rank correlation (ρ) for rank preservation, and the Intraclass Correlation Coefficient (ICC) using a two-way absolute-agreement model to quantify overall concordance. Bland–Altman analysis was conducted to assess systematic differences in absolute risk predictions, including mean bias and 95% limits of agreement (LoA), for each model (A–C).

To further investigate whether the level of agreement varied depending on age and sex, we applied an analysis of covariance (ANCOVA), modeling bias as a function of age, sex, their interaction, and mean risk. This allowed us to estimate the average difference between calculators at age 50, the slope of bias across age, and whether this slope differed between males and females. Predicted values were visualized as simple slopes across the age range for each sex. Where relevant, adjusted mean bias by sex was calculated, and interaction terms were formally tested. We also summarized bias within three age bands (18–44, 45–64, and 65+) to aid clinical interpretation.

Analyses were executed in R 4.3 using packages dplyr 1.1, irr 0.84, and ggplot2 3.5.

# Results

### Overall Agreement

Across the 500 000 simulated records the two calculators were strongly correlated ([Table 1](#part-1-qdiabetes-inputs)). Model A showed near-perfect linear and rank agreement (Pearson r = 0.986; Spearman ρ = 0.997; Figure 1A). Agreement remained very high in Model B (r = 0.823; ρ = 0.961; Figure 1B) and Model C (r = 0.831; ρ = 0.961; Figure 1C). Intraclass correlation coefficients (which are more sensitive to systematic offsets) were moderate: 0.60 for Model A, 0.52 for Models B, and 0.58 for Model C, reflecting small but non-zero mean differences.

**Figure 1.** Scatterplots of QDaibetes vs. HH-Diabetes Using QDiabetes Inputs

1.  **Model A**

![A graph with a line going up AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image1.png)

2.  **Model B**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image2.png)

3.  **Model C**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image3.png)

### Convergence Across the Risk Spectrum

[Table 2](#part-1-qdiabetes-inputs) confirms a small positive divergence in every model, indicating that QDiabetes estimates are slightly higher in predicting ten-year T2D risk than HH. The mean difference was about 2.8 percentage points in Model A and just over 4 points in the biomarker models. Bland–Altman plots (Figure 2A-C) reveal how that difference changes with risk level: in Model A the smooth trend rises slightly and reaches a plateau near the mid-risk range (40-60% mean risk) before curving lower at the higher risk. Model B shows a more pronounced arch, with the largest overestimation around 40 per cent mean risk. Model C displays the steepest curvature: bias increases sharply in the low-to-middle range, plateaus, and then narrows again beyond about 70 per cent. These patterns indicate that the two tools agree almost perfectly below roughly 10 per cent risk, diverge most in the middle of the spectrum (especially when fasting glucose or HbA1c are part of the equation) and converge again (but not completely) at the higher end (Figure 2A-C).

**Figure 2.** Bland-Altman Plot Comparing QDiabetes and HH-Diabetes

1.  **Model A**

![A graph with a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image4.png)

2.  **Model B**

![A graph with lines and lines on it AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image5.png)

3.  **Model C**

![A graph with lines and a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image6.png)

### Age and Sex Effects

In addition to examining convergence along the risk spectrum, we also examined whether scores would diverge according to age and sex. For all three models, the difference between the HH-QDiabetes scores increased slightly with each year of age, from 0.01 to 0.04 percentage points per year ([Table 3 and Figure 3A-C](#_Age_and_Sex)). In Model A the slopes for men and women were almost identical, and the sex × age interaction was not statistically significant (p = 0.14). Model B told a different story: divergence in scores rose about three times faster in women than in men, and the interaction was highly significant (p \< 0.001). In Model C both sexes shared the same upward slope and again the interaction was non-significant. The contrasting behaviour of Model B is likely driven by its fasting-glucose term, which is more sensitive to short-term metabolic variation and shows stronger sex-specific ageing patterns, whereas the HbA1c term in Model C reflects longer-term glycaemic status and behaves more uniformly between men and women.

A detailed breakdown by age band is provided in [Table 4](#_Age_and_Sex), which shows the convergence widening from about two percentage points in adults under 45 years to six–seven points in those aged 65 years or older.

*  
*

This section evaluates convergence between the HH Diabetes and QDiabetes risk calculators when HH is run with relative risks and prevalence derived from contemporary peer-reviewed literature. The synthetic cohort is identical to Part 1; QDiabetes remains as originally published. Therefore, any differences reflect HH’s inputs, not implementation.

### Overall Agreement – HH Inputs

HH and QDaibetes risk scores demonstrated very similar ranking ([Table 5](#part-2-hh-inputs)). Spearman correlations for HH and QDiabetes were 0.869 (Model A), 0.757 (Model B), and 0.868 (Model C), and the scatterplots clustered around the 45° line (Figure 3A–C). Linear correlations were moderate (r = 0.635, 0.566, 0.511). Intraclass correlations were modest (ICC 0.50, 0.32, 0.33), which points to a small numerical difference between tools in precise risk estimates rather than disagreement about high vs. low risk.

Figure 3. Scatterplot of QDiabetes vs HH-Diabetes Using HH Inputs

1.  **Model A**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image7.png)

2.  **Model B**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image8.png)

3.  **Model C**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image9.png)

### Average difference and limits of agreement (Bland–Altman) – HH Inputs 

On average, HH estimates were slightly higher for 10‑year risk than QDiabetes ([Table 6](#part-2-hh-inputs)). Mean bias was +2.83% in Model A and approximately +4% in Models B and C; typical absolute differences ranged from \~3% to 4.4%. The 95% limits of agreement were −6.9 to +12.5% in Model A and −11 to +19% in the biomarker models, indicating wider spread when fasting glucose or HbA1c are included. The Bland–Altman plots (Figure 4A–C) show differences centred on the mean across the risk range, with somewhat greater dispersion for Models B and C.

**Figure 4.** Bland-Altman Plot Comparing QDiabetes and HH-Diabetes using HH Inputs

1.  **Model A**

![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image10.png)

2.  **Model B**

![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image11.png)

3.  **Model C**

![A graph with lines and a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image12.png)

### Age and Sex Patterns – HH Inputs 

Convergence varied by age and only slightly by sex ([Tables 7-8](#a4.-age-and-sex-differences-hh-inputs); Figure 6A–C). It was smallest in adults \<45 years (about 1.5–2.4%), highest in midlife 45–64 years (about 5–7%), and smaller again at 65+ (about 0–3.5%). At age 50, HH exceeded QDiabetes by \~2.8% in Model A and \~4% in Models B and C (Table 3). The linear change with age was small—about +0.01 to +0.04% per year (≈ +0.1 to +0.4% per decade). Slopes were similar in women and men for Models A and C (Sex × Age p = 0.14 for both). In Model B, convergence increased faster with age in women (+0.036%/yr) than in men (+0.013%/yr), and the interaction was significant (p \< 0.001).

Detailed results for all subgroup and interaction analyses are provided in Appendix.

# Limitations 

**Part 1:** We used a large synthetic cohort calibrated to the published QDiabetes distributions rather than real patient records. As a result, some real‑world correlations and measurement error are not fully represented. The original QDiabetes equations were applied as reported, without recalibration to the syntehic dataset. Because agreement metrics such as the intraclass correlation coefficient (ICC) are sensitive to small-scale offsets, moderate ICC values accompanied by very high Pearson and Spearman correlations should be interpreted as reflecting numerical shifts rather than substantive disagreement in ranking. The majority of the remaining absolute differences—particularly in Models B and C—arise from model specification. Specifically, QDiabetes incorporates curvilinear (fractional polynomial) terms for fasting glucose and HbA1c, whereas the HH model combines predictors linearly. This structural divergence produces the curvilinear pattern observed, whereby divergence peaks around mid-risk and the wider limits of agreement in the laboratory-based models (Table 2; Figure 2A–C), as well as the midlife age-related bias pattern (Table 4; Figure 3A–C). A practical limitation of the current HH approach is this linear specification; future iterations could incorporate more flexible functional forms or include a calibration step to better capture curvilinear relationships.

**Part 2:** The same data considerations outlined for Part 1 apply here as well. Furthermore, we used updated studies to inform HH parameters. Because the literature does not provide model-specific relative risks or baseline rates for Models A, B, and C, a single updated set of values was applied across all three model comparisons. For atypical antipsychotics, systemic corticosteroids, and learning disability, we retained the original QDiabetes parameters, as no meta-analyses or large cohort evidence currently support recalibration. The model specification mismatch described previously also applies in this context. Moreover, the inclusion of laboratory measures introduces biological and assay variability, which further contributes to the divergence and widens the limits of agreement in Models B and C.

# Conclusion

This analysis demonstrates that the QDiabetes and HH calculators exhibit strong overall convergence. The average difference between the risk scores produced by each risk calculator is small and directionally consistent, with QDiabetes producing slightly higher ten-year risk estimates than HH. Agreement is nearly complete at the lower end of the risk spectrum, diverges modestly at intermediate levels, and converges again at the highest levels of risk.

Divergence increased with age in all three models. In Model B, the age-related increase differs by sex, rising more steeply in women, particularly at older ages. By contrast, Models A and C display parallel age trends in men and women. These findings suggest that Model B is more sensitive to the combined influence of age and sex, likely because it incorporates fasting glucose, a biomarker that exhibits greater variation across demographic groups.

Validation using HH inputs further confirms high rank-order agreement across all models. HH generally produces slightly higher ten-year risk estimates than QDiabetes, with the largest differences observed in midlife and in models that include laboratory measures. Although these differences are modest in absolute terms, they may carry practical significance when determining thresholds for clinical action.

Taken together, these results clarify where and why divergence arises between the calculators, and they highlight sub-populations in which differences are more pronounced despite the overall high degree of concordance.

# References

Hippisley-Cox, J., Coupland, C., & Brindle, P. (2017). Development and validation of QDiabetes-2018 risk prediction algorithm to estimate future risk of type 2 diabetes: Cohort study. *BMJ*, *359*, j5019. https://doi.org/10.1136/bmj.j5019

World Health Organization. (2023). Diabetes fact sheet. https://www.who.int/news-room/fact-sheets/detail/diabetes

# Appendix — Supplementary Methods, Full Result Tables, Additional Graphs

# Part 1 QDiabetes Inputs

### **A1. Overall Agreement**

**Table 1.** Agreement and Correlation Metrics for QDiabetes vs HH-Diabetes Risk Score

| **Model** | **Pearson** | **Spearman** | **ICC** |
|-----------|-------------|--------------|---------|
| **A**     | 0.986       | 0.997        | 0.603   |
| **B**     | 0.823       | 0.961        | 0.52    |
| **C**     | 0.831       | 0.961        | 0.58    |

*Abbreviations*. ICC: Intraclass correlation coefficient.

**Table 2**. Bland-Altman Mean Difference Summary

| **Model** | **Mean Difference (QD – HH)** | **LoA Lower** | **LoA Upper** |
|-----------|-------------------------------|---------------|---------------|
| **A**     | 2.761                         | –4.685        | 10.207        |
| **B**     | 4.013                         | –8.21         | 16.236        |
| **C**     | 4.112                         | –6.908        | 15.131        |

*Abbreviations.* HH: Harrison Healthcare Diabetes risk calculator; QD: QDiabetes risk calculator; LoA: Limits of agreement.

**  
**

### **A2. Age and Sex Differences**

**Table 3.** Summary of Divergence, Slope, Interaction, and Agreement Limits

| **Model** | **Mean Absolute Difference @ 50 y (%)** |          | **Δ Mean Absolute Difference per year (%/yr)** |          | **Sex × Age p-value** | **95 % LoA (%)** |
|-----------|-----------------------------------------|----------|------------------------------------------------|----------|-----------------------|------------------|
|           | **Female**                              | **Male** | **Female**                                     | **Male** |                       |                  |
| **A**     | 2.79                                    | 2.79     | +0.01                                          | +0.01    | 0.14                  | –4.7 to +10.2    |
| **B**     | 4.14                                    | 3.88     | +0.036                                         | +0.013   | \< 0.001              | –8.2 to +16.2    |
| **C**     | 3.99                                    | 4.24     | +0.031                                         | +0.031   | 0.14                  | –6.9 to +15.1    |

Table 4 shows how the average difference between QDiabetes and HH widens as people get older. In the 18–44-year group, the calculators differ by roughly one to two percentage points, with Model A the lowest (1.15 %) and Model B the highest (2.16 %). Among adults aged 45–64 years, the gap grows to between four and six percentage points, and in those aged 65 years or more it reaches six to seven points. Across all age bands, Model B consistently displays the largest convergence, Model A the smallest, and Model C sits in between. This confirms that the two tools agree very closely for younger adults, diverge modestly in middle age, and differ most in older age, particularly when fasting glucose (Model B) or HbA1c (Model C) is part of the risk equation.

**Table 4.** Mean Absolute Difference by Age Group

| **Age group** | **Model A** | **Model B** | **Model C** |
|---------------|-------------|-------------|-------------|
| 18–44         | 1.15%       | 2.16%       | 2.39%       |
| 45–64         | 4.15%       | 5.76%       | 5.86%       |
| 65+           | 6.11%       | 7.17%       | 6.48%       |

**  
**

**Figure 5.** Bland-Altman Plots Comparing QDiabetes and HH-Diabetes Risk Calculators, Stratified by Sex

1.  **Model A**

![A graph with a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image13.png)![A graph with lines drawn on it AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image14.png)

2.  **Model B**

![A graph with lines on a black background AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image15.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image16.png)

3.  **Model C**

![A graph with lines and a line on it AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image17.png)![A graph with lines and a blue line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image18.png)

**Figure 6.** Bland-Altman Plots Comparing QDiabetes and HH-Diabetes Risk Calculators, Stratified by Age

1.  **Model A**

![A graph with a green line and red line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image19.png)![A graph with lines and a line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image20.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image21.png)

2.  **Model B**

![A graph with lines and numbers AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image22.png)![A graph with lines and a curved line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image23.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image24.png)

3.  **Model C**

![A graph with lines and a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image25.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image26.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image27.png)

**  
**

**Figure 7.** Simple Slopes Bias vs Age by Sex

1.  **Model A**

![A graph with lines and a line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image28.png)

2.  **Model B**

![A graph with lines and lines AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image29.png)

**  
**

3.  **Model C**

![A graph with lines and a line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image30.png)

# Part 2: HH Inputs

### **A3. Overall Agreement - HH Inputs**

**Table 5.** Agreement Metrics (Correlation and Intraclass Correlation)

| **Model** | **Pearson r** | **Spearman ρ** | **ICC (absolute)** |
|-----------|---------------|----------------|--------------------|
| **A**     | 0.635         | 0.869          | 0.503              |
| **B**     | 0.566         | 0.757          | 0.315              |
| **C**     | 0.511         | 0.868          | 0.330              |

*Abbreviations*. ICC: Intraclass correlation coefficient.

**Table 6.** Bland-Altman Mean Difference Summary

| **Model** | **Mean Difference (QD – HH)** | **Mean Abs Diff** | **LoA Lower** | **LoA Upper** |
|-----------|-------------------------------|-------------------|---------------|---------------|
| **A**     | 2.83                          | 3.11              | −6.85         | +12.52        |
| **B**     | 3.98                          | 4.16              | −11.12        | +19.07        |
| **C**     | 4.07                          | 4.38              | −10.80        | +18.93        |

*Abbreviations.* HH: Harrison Healthcare Diabetes risk calculator; QD: QDiabetes risk calculator; LoA: Limits of agreement.

### **A4. Age and Sex Differences – HH Inputs**

**Table 7.** Summary of Divergence, Slope, Interaction, and Agreement Limits

| **Model** | **Mean Absolute Difference @ 50 y — Female (%)** | **Bias @ 50 y — Male (%)** | **Δ Bias per year — Female (%/yr)** | **Δ Bias per year — Male (%/yr)** | **Sex × Age p (Type III)** | **95% LoA (%)** |
|-----------|--------------------------------------------------|----------------------------|-------------------------------------|-----------------------------------|----------------------------|-----------------|
| A         | 2.79                                             | 2.79                       | +0.01                               | +0.01                             | 0.14                       | −4.7 to +10.2   |
| B         | 4.14                                             | 3.88                       | +0.036                              | +0.013                            | \<0.001                    | −8.2 to +16.2   |
| C         | 3.99                                             | 4.24                       | +0.031                              | +0.031                            | 0.14                       | −6.9 to +15.1   |

Table 8 shows that the size of the HH–QDiabetes difference depends on age. In adults 18–44 years the average gap is small (Model A +1.50%, Model B +2.13%, Model C +2.39%). The gap is largest in midlife (45–64 years): +5.19% in Model A, +6.51% in Model B, and +6.79% in Model C. At 65+ years the difference narrows again, dropping to +0.12% in Model A, +3.51% in Model B, and +1.81% in Model C. Overall, midlife shows the greatest divergence, especially for the lab‑based models (B and C).

**Table 8.** Absolute Mean Difference by Age Group

| **Age Group** | **Model A** | **Model B** | **Model C** |
|---------------|-------------|-------------|-------------|
| **18–44**     | 1.50%       | 2.13%       | 2.39%       |
| **45–64**     | 5.19%       | 6.51%       | 6.79%       |
| **65+**       | 0.12%       | 3.51%       | 1.81%       |

Figure 8. Bland-Altman Plots Comparing QDiabetes and HH-Diabetes Risk Calculators, Stratified by Sex

1.  Model A

![A graph with lines and a line on it AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image31.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image32.png)

2.  **Model B**

![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image33.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image34.png)

3.  **Model C**

![A graph with lines and a line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image35.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image36.png)

**Figure 9.** Bland-Altman Plots Comparing QDiabetes and HH-Diabetes Risk Calculators, Stratified by Age

1.  **Model A**

![A graph with a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image37.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image38.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image39.png)

2.  **Model B**

![A graph with a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image40.png)![A graph with green line and red line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image41.png)![A graph with lines and a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image42.png)

3.  **Model C**

![A graph with a green line AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image43.png)![A graph with lines and dots AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image44.png)![A graph with lines and a line in the middle AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image45.png)

**Figure 10.** Simple Slopes Bias vs Age by Sex (Modern Inputs)

1.  **Model A**

![A graph with lines and lines AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image46.png)

**B. Model B**

![A graph with lines and lines on it AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image47.png)

**C. Model C**

![A graph with lines and lines AI-generated content may be incorrect.](/mnt/data/qdiabetes_media/media/image48.png)