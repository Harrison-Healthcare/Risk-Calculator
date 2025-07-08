<div align="center">
  <img src="harrison logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

---

# Risk Calculator Methodology

**Prepared by:** 	

Boaz Y. Saffer, PhD  
Chief Scientific Officer, Harrison Healthcare

Julia Blumkaitis-Bosankic, MS  
Research Assistant, Harrison Healthcare

**Date:** 
July 4th, 2025


## Table of Contents

1. [Overview](#overview)
2. [Methodological Foundation](#methodological-foundation)  
3. [Generalized HCRI Calculation](#generalized-hcri-calculation)
4. [The Importance of Accounting for Mediation](#the-importance-of-accounting-for-mediation)
5. [Absolute Risk Calculation](#absolute-risk-calculation)
6. [References](#references)


## Overview

This document outlines the methodology used in Harrison Healthcare's risk calculation dials. The approach builds upon the Harvard Cancer Risk Index (HCRI) while incorporating additional analytical techniques to handle mediation effects between lifestyle factors and biomarkers, ensuring accurate risk assessments without risk overestimation.



## Methodological Foundation

The Harvard Cancer Risk Index, developed by Colditz et al. (2000) and expanded by Kim, Rockhill, & Colditz (2004), provides the foundational framework for personalized risk assessment. The original HCRI was designed to predict individual cancer risk for cancers accounting for 80% of the cancer burden in the United States, but has since proven adaptable to various health conditions.


### HCRI Development Process

The original Harvard Cancer Risk Index (HCRI) was developed through a structured evidence synthesis process. Researchers conducted a systematic review to classify risk factors as definite, probable, or possible causes of cancer based on expert consensus. Relative risks were extracted from high-quality, peer-reviewed epidemiological studies that quantified associations between risk factors and cancer incidence. These estimates were used to assign risk points proportionally to effect size. The model was calibrated using U.S. population-level average risk and 10-year cumulative incidence data from the SEER database. Validity was evaluated using prospective cohort data, showing strong concordance with observed colon cancer incidence. This approach formalized a method for translating epidemiologic evidence into individualized, population-referenced risk estimates.



### Shrier et al.'s Generalization of the HCRI Methodology

Shrier et al. (2018) identified an important limitation in the original HCRI formulation: it only accommodated dichotomous (binary) risk factors and lacked a clear mathematical derivation. In their article "Synthesizing Risk from Summary Evidence Across Multiple Risk Factors," they addressed the growing need for risk assessment tools that could handle the complexity of real-world risk factors, which often have three or more levels.

Specifically, the generalized HCRI equation calculates a person's relative risk (RR) compared to the average population:

```math
\text{RR}_{\text{RFL/pop}} = \frac{\text{RR}_{\text{RFL/r}}}{\sum_{k=1}^{n} P_k \cdot \text{RR}_{k/r}}
```

Where:
- $\text{RR}_{\text{RFL/pop}}$: Relative risk comparing patient to average population
- $\text{RR}_{RFL/r}$: Relative risk for the patient's risk factor level
- $P_k$: Prevalence of the k-th level of the risk factor
- $\text{RR}_{k/r}$: Risk ratio for the k-th level of the risk factor
- $n$: Total number of levels for the risk factor

For multiple independent risk factors, the combined relative risk is calculated as:

```math
\text{RR}_{\text{combined}} = \prod_{i=1}^{m} \frac{\text{RR}_{i}}{\sum_{k=1}^{n_i} P_{k,i} \cdot \text{RR}_{k,i}}
```

Where $m$ is the number of risk factors and $n_i$ is the number of levels for risk factor $i$.

Shrier et al.'s key contributions therefore include providing the first formal mathematical derivation of the HCRI equation, establishing its theoretical foundation and extending the formula to handle risk factors with three or more levels, significantly expanding its applicability.


### Calculated Example: Generalized HCRI Method

**Scenario:** An individual has been diagnosed with diabetes and consumes a high saturated fat diet.

**Step 1: Define Risk Factor Levels and Prevalences**

- **Risk Factor 1: Diabetes Status**

<div align="center">

| Diabetes Status | Relative Risk (RR) | Prevalence (%) |
|-----------------|--------------------|----------------|
| Not Diagnosed   | 1.00               | 94.2%          |
| Diagnosed       | 2.00               | 5.8%           |

</div>

- **Risk Factor 2: Saturated Fat Intake**

<div align="center">

| Saturated Fat Intake | Relative Risk (RR) | Prevalence (%) |
|----------------------|--------------------|----------------|
| Low                  | 1.00               | 25%            |
| Medium               | 1.50               | 40%            |
| High                 | 2.00               | 35%            |

</div>


**Step 2: Calculate Population-Adjusted RR for Each Risk Factor**

- **Diabetes:**
```math
\frac{2.00}{(0.942 \cdot 1.00 + 0.058 \cdot 2.00)} = \frac{2.00}{1.058}
```

- **Saturated Fat Intake:**
```math
\frac{2.00}{(0.25 \cdot 1.00 + 0.40 \cdot 1.50 + 0.35 \cdot 2.00)} = \frac{2.00}{1.55} 
```

**Step 3: Calculate Combined Relative Risk**
```math
\text{Combined RR} = \frac{2.00 }{1.058} \times \frac{2.00}{1.55} \approx 2.244
```

This indicates thart an individual with diabetes and high saturated fat intake has a 124.4% higher risk for developing CHD compared to the population.


## The Importance of Accounting for Mediation

The generalized HCRI framework assumes that all risk factors contribute independently to disease risk. However, when one risk factor exerts its influence through another intermediate variable, this assumption fails. Mediation occurs when part or all of the effect of an upstream variable (e.g., a behavioural, clinical, or demographic exposure) is transmitted through a downstream mediator. Treating both variables as independent predictors in such cases introduces structural redundancy: the mediated effect is effectively counted twice—once via the upstream factor’s total effect and again through the mediator’s direct effect. This leads to systematic inflation of estimated relative risk. To maintain the integrity of the model, it is essential to partition effects into direct and indirect components. For example, in lifestyle–biomarker relationships, where dietary intake influences disease risk partly through metabolic markers, failing to account for mediation overstates total risk and undermines the accuracy of individual prediction.

### Enhanced Methodology 

To resolve the bias introduced by mediation, we extend the generalized HCRI equation to demopose the risk factors' effect into (i) the residual direct effect that remains after the mediated component is removed and (ii) the total effect of the mediator:

```math
\text{RR}_{\text{RFL/pop}} = \left( \frac{1 + (1 - \alpha) \times (\text{RR}_{\text{RFL}} - 1)}{\sum_{k=1}^{n} P_k \cdot \left[ 1 + (1 - \alpha) \times (\text{RR}_{k/r} - 1) \right]} \right) \times \left( \frac{\text{RR}_{\text{mediator}}}{\sum_{k=1}^{n} P_k \cdot \text{RR}_{k/r \text{ (for mediator)}}} \right)
```
Here, the mediation coefficient $\alpha$ quantifies the proportion of the total effect transmitted through the mediator:
- $\alpha = 0$: fully direct effect (no mediation)
- $\alpha = 1$: fully indirect effect (complete mediation)
- $0 < \alpha < 1$: partial mediation (both direct and indirect effects contribute)

### Equation Components

#### Residual Direct-Effect Component
```math
\frac{1 + (1 - \alpha) \times (\text{RR}_{\text{RFL}} - 1)}{\sum_{k=1}^{n} P_k \cdot \left[ 1 + (1 - \alpha) \times (\text{RR}_{k/r} - 1) \right]}
```

The numerator scales the individual’s excess risk $(\text{RR}_{\text{RFL}} - 1)$ by $(1 - \alpha)$, retaining only the residual direct (unmediated) portion and converting it back to the relative risk scale by adding 1. The denominator applies the same adjustment to each risk level in the population, computing a weighted average of residual direct effects. The resulting ratio quantifies the effect of the risk factor on the outcome after adjusting for mediation, yielding a population-weighted estimate.


#### Mediator Component
```math
\frac{\text{RR}_{\text{mediator}}}{\sum_{k=1}^{n} P_k \cdot \text{RR}_{k/r \text{ (for mediator)}}}
```

This term is calculated identically to the indpeendent risk factors in the generalized HCRI formulation. Here, it quantifies the direct effect of the mediator on the outcome. The numerator represents the individual’s relative risk based on their level of the mediator. The denominator is the prevalence-weighted average relative risk across the population. No adjustment by $\alpha$ is applied here because the mediator’s contribution is not itself mediated by another variable and is modeled as exerting a direct, independent effect on the outcome.


### Calculated Example: Enhanced HCRI with Mediation Effects

**Scenario**: An individual has high saturated fat intake and elevated LDL cholesterol. The effect of saturated fat on cardiovascular disease is partially mediated through LDL levels, with a mediation coefficient of $\alpha = 0.6$ (i.e., 60% mediation).

**Risk Factor Tables**

| Saturated Fat Intake Level | Relative Risk (RR) | Prevalence (%) |
|----------------------------|--------------------|----------------|
| Low                        | 1.00               | 25%            |
| Medium                     | 1.50               | 40%            |
| High                       | 2.00               | 35%            |

| LDL Cholesterol Level      | Relative Risk (RR) | Prevalence (%) |
|----------------------------|--------------------|----------------|
| Low                        | 1.00               | 30%            |
| Medium                     | 2.00               | 40%            |
| High                       | 4.00               | 30%            |



### Generalized HCRI Calculation 

This approach assumes saturated fat intake and LDL cholesterol are independent predictors:

- Saturated Fat Intake: 
```math
\text{RR}_{\text{SFI}} = \frac{2.00}{(0.25 \cdot 1.00 + 0.40 \cdot 1.50 + 0.35 \cdot 2.00)} = \frac{2.00}{1.55}
```

- LDL Cholesterol: 
```math
\text{RR}_{\text{LDL-c}} = \frac{4.00}{(0.30 \cdot 1.00 + 0.40 \cdot 2.00 + 0.30 \cdot 4.00)} = \frac{4.00}{2.30}
```

 - Combined Relative Risk:
```math
\text{RR}_{\text{traditional}} = \frac{2.00}{1.55} \times \frac{4.00}{2.30} = \frac{8.00}{3.565} \approx 2.244
```

### Enhanced HCRI Calculation

This approach accounts for the partial mediation ($\alpha = 0.6$) between saturated fat intake and LDL cholesterol.

**Step 1: Compute the Residual Direct Effect (Saturated Fat Intake)**

- Individual-level risk (adjusted for mediation):

```math
\text{RR}_{\text{SFI, direct}} = 1 + (1 - 0.60) \cdot (2.00 - 1) = 1.40
```

- Population-level risk (also adjusted for mediation):

```math
= 0.25 \cdot 1.00 + 0.40 \cdot [1 + 0.40 \cdot (1.50 - 1)] + 0.35 \cdot [1 + 0.40 \cdot (2.00 - 1)]
```
```math
= 0.25 + 0.40 \cdot 1.20 + 0.35 \cdot 1.40
```
```math
= 0.25 + 0.48 + 0.49 = 1.22
```

**Step 2: Compute the Mediator Effect (LDL Cholesterol)**

This component is not adjusted for mediation, as LDL is treated as a direct independent predictor of Coronary Heart Disease:

```math
\text{RR}_{\text{LDL-c}} = \frac{4.00}{(0.30 \cdot 1.00 + 0.40 \cdot 2.00 + 0.30 \cdot 4.00)} = \frac{4.00}{2.30} = 1.739
```

**Step 3: Compute the Risk Estimate**

```math
\text{RR}_{\text{enhanced}} = \frac{1.40}{1.22} \times \frac{4.00}{2.30} \approx 1.148 \times 1.739 \approx 1.996
```
**Interpretation**: The enhanced method yields a relative risk of approximately 2.00, compared to 2.24 from the generalized HCRI. The lower estimate reflects the removal of the mediated component of the saturated fat effect—that is, the portion of its influence on coronary heart disease risk that operates through LDL cholesterol. By explicitly adjusting for mediation, we believe this approach provides a more accurate and causally coherent estimate. This correction is especially important in models with many risk factors, where overlapping pathways can otherwise lead to inflated risk estimates.


## Absolute Risk Calculation

After computing the individual’s cumulative relative risk (CRR) using the enhanced HCRI methodology that accounts for mediated relationships, we can use this value to calculate their absolute risk estimate for developing a condition using either an incidence-based method or the survival-power method.

### Incidence-based Method

Shrier et al. (2018) originally proposed converting cumulative relative risk into absolute risk by multiplying it with the average population-level incidence:

```math
\text{Absolute Risk} = \text{Population Incidence} \times \text{Cumulative Relative Risk}
```

While straightforward, this method can yield absolute risk estimates exceeding 100% when relative risks are high or when multiple risk factors are compounded. Although useful as a conceptual bridge from relative to absolute risk, this formulation lacks probabilistic constraints and is sensitive to overestimation, especially in high-risk populations.


### Survival-Power Method

To address these limitations, we recommend using a survival-power method, which ensures interpretability and bounded output. This approach is based on survival analysis principles and provides probabilistically sound estimates that cannot exceed 100%. The equation is:

```math
\text{Absolute Risk} = 1 - S_{0}^{\text{CRR}}
```

Where:  
- **$S_{0}$**: Baseline survival probability over the chosen time horizon (e.g., 10-year CHD-free survival rate from a reference cohort)  
- **CRR**: Cumulative relative risk from the enhanced HCRI calculation  

### Calculated Example: Converting to Absolute Risk

Using the CRR calculated in the previous section, we can demonstrate the survival-power method:

**Step 1: Obtain Cumulative Relative Risk**  
From the enhanced HCRI calculation above:
```math
\text{CRR} = 1.996
```

**Step 2: Determine Baseline Survival Probability**  
For 10-year coronary heart disease risk, we use population-level survival data. Assuming 89% of the reference population remains CHD-free over 10 years:
```math
S_{0} = 0.89
```

**Step 3: Apply the Survival-Power Formula**  
Exponentiate the baseline survival by the CRR:
```math
S_{0}^{\text{CRR}} = 0.89^{1.996} \approx 0.79
```

**Step 4: Calculate 10-Year Absolute Risk**  
Subtract from unity to obtain the absolute risk:
```math
\text{10-Year Absolute Risk} = 1 - 0.79 = 0.21 = 21\%
```

**Interpretation**: An individual with this risk profile has a 21% absolute risk of developing coronary heart disease over the next 10 years. This survival-power approach ensures the estimate remains bounded between 0% and 100%, providing a clinically interpretable and mathematically sound risk assessment.

## References

Colditz, G. A., Atwood, K. A., Emmons, K., Monson, R. R., Willett, W. C., Trichopoulos, D., & Hunter, D. J. (2000). Harvard report on cancer prevention volume 4: Harvard Cancer Risk Index. Risk Index Working Group, Harvard Center for Cancer Prevention. *Cancer causes & control : CCC*, *11*(6), 477–488. [https://doi.org/10.1023/a:1008984432272](https://doi.org/10.1023/a:1008984432272)

Kim, D. J., Rockhill, B., & Colditz, G. A. (2004). Validation of the Harvard Cancer Risk Index: a prediction tool for individual cancer risk. *Journal of clinical epidemiology*, *57*(4), 332–340. [https://doi.org/10.1016/j.jclinepi.2003.08.013](https://doi.org/10.1016/j.jclinepi.2003.08.013)

Shrier, I., Colditz, G. A., & Steele, R. J. (2018). Synthesizing Risk from Summary Evidence Across Multiple Risk Factors. *Epidemiology*, *29*(4), 533–535. [https://doi.org/10.1097/EDE.0000000000000820](https://doi.org/10.1097/EDE.0000000000000820)

