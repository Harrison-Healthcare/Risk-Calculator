<div align="center">
  <img src="../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

# Evidence Summary

## Introduction

This document provides a complete reference for each data point used in the Harrison Healthcare Risk Calculator, as outlined in the [risk-calculator.csv](../../data/risk-calculator.csv) file. 

The content is organized by disease risk dial and then by individual risk factor. For each factor, we transparently present the data sources and the Joanna Briggs Institute (JBI) quality ratings, normalized to a 0–100 scale.

Taken together, these sources form the empirical foundation of the Harrison Healthcare risk calculator and underpin the scientific credibility of its risk estimates.

## Table of Contents

- [Bladder cancer](#bladder-cancer)
  - [Age](#age)
  - [BMI](#bmi)
  - [Diabetes - Type 2](#diabetes---type-2)
  - [Family history](#family-history)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption)
  - [Race](#race)
  - [Smoking - cigarettes](#smoking---cigarettes)
- [Breast cancer](#breast-cancer)
  - [Age](#age-1)
  - [Age - Menarche](#age---menarche)
  - [Age - Menopause](#age---menopause)
  - [Alcohol](#alcohol)
  - [Breastfeeding](#breastfeeding)
  - [Diabetes - Type 2](#diabetes---type-2-1)
  - [Family history](#family-history-1)
  - [Height](#height)
  - [Hormone replacement therapy](#hormone-replacement-therapy)
  - [Parity](#parity)
  - [Physical activity](#physical-activity)
  - [Race](#race-1)
  - [Smoking - cigarettes](#smoking---cigarettes-1)
- [Cervical cancer](#cervical-cancer)
  - [Age](#age-2)
  - [Family history](#family-history-2)
  - [HIV](#hiv)
  - [Number of sexual partners](#number-of-sexual-partners)
  - [Oral contraceptive use](#oral-contraceptive-use)
  - [Race](#race-2)
  - [Smoking - cigarettes](#smoking---cigarettes-2)
- [Colorectal cancer](#colorectal-cancer)
  - [Age](#age-3)
  - [Alcohol](#alcohol-1)
  - [Aspirin](#aspirin)
  - [BMI](#bmi-1)
  - [Crohn's disease](#crohns-disease)
  - [Diabetes - Type 2](#diabetes---type-2-2)
  - [Family history](#family-history-3)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption-1)
  - [Oral contraceptives](#oral-contraceptives)
  - [Physical activity](#physical-activity-1)
  - [Race](#race-3)
  - [Smoking - cigarettes](#smoking---cigarettes-3)
  - [Ulcerative colitis](#ulcerative-colitis)
- [Coronary heart disease](#coronary-heart-disease)
  - [Age](#age-4)
  - [Anxiety](#anxiety)
  - [Apolipoprotein B-100](#apolipoprotein-b-100)
  - [Apolipoproteins (B-100 and A-I)](#apolipoproteins-b-100-and-a-i)
  - [Blood pressure](#blood-pressure)
  - [BMI](#bmi-2)
  - [C-reactive protein](#c-reactive-protein)
  - [Cholesterol - HDL](#cholesterol---hdl)
  - [Cholesterol - LDL](#cholesterol---ldl)
  - [Cholesterol - Total](#cholesterol---total)
  - [Depression](#depression)
  - [Diabetes - Type 2](#diabetes---type-2-3)
  - [Family history](#family-history-4)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption-1)
  - [Gum disease](#gum-disease)
  - [Hemoglobin A1c](#hemoglobin-a1c)
  - [Homocysteine level](#homocysteine-level)
  - [Hypertension](#hypertension)
  - [Job strain](#job-strain)
  - [Lipoprotein (a)](#lipoprotein-a)
  - [Periodontal disease](#periodontal-disease)
  - [Physical activity](#physical-activity-2)
  - [Race](#race-4)
  - [Red meat consumption](#red-meat-consumption)
  - [Second-hand smoke](#second-hand-smoke)
  - [Smoking - cigarettes](#smoking---cigarettes-4)
  - [Social deprivation](#social-deprivation)
  - [Sugar-sweetened beverages](#sugar-sweetened-beverages)
  - [Systolic blood pressure](#systolic-blood-pressure)
- [Dementia](#dementia)
  - [Age](#age-5)
  - [Atrial fibrillation](#atrial-fibrillation)
  - [BMI](#bmi-3)
  - [Coronary artery disease](#coronary-artery-disease)
  - [Depression](#depression-1)
  - [Diabetes - Type 2](#diabetes---type-2-4)
  - [Education](#education)
  - [Family history](#family-history-5)
  - [Hearing loss](#hearing-loss)
  - [Hypertension](#hypertension-1)
  - [Race](#race)
  - [Sedentary behaviour](#sedentary-behaviour)
  - [Sleep](#sleep)
  - [Smoking - cigarettes](#smoking---cigarettes-5)
  - [Social relationships](#social-relationships)
  - [Stroke](#stroke)
- [Depression](#depression-2)
  - [Adverse childhood experiences](#adverse-childhood-experiences)
  - [Chronic pain](#chronic-pain)
  - [Demographic variables (age, marital status, race)](#demographic-variables-age-marital-status-race)
  - [Diabetes - Type 2](#diabetes---type-2-5)
  - [Family history](#family-history-6)
  - [Job strain](#job-strain-1)
  - [Sedentary behaviour](#sedentary-behaviour-1)
  - [Sleep](#sleep-1)
  - [Smoking - cigarettes](#smoking---cigarettes-6)
- [Diabetes - Type 2](#diabetes---type-2-6)
  - [Adiponectin](#adiponectin)
  - [Age](#age-1)
  - [BMI](#bmi-4)
  - [C-reactive protein (CRP)](#c-reactive-protein-crp)
  - [Smoking - cigarettes](#smoking---cigarettes-7)
  - [Family history](#family-history-7)
  - [Gestational diabetes](#gestational-diabetes)
  - [Cholesterol - HDL](#cholesterol---hdl)
  - [Hemoglobin A1c](#hemoglobin-a1c-1)
  - [Hepatitis C](#hepatitis-c)
  - [Hypertension](#hypertension-2)
  - [Interleukin 6 (IL-6)](#interleukin-6-il-6)
  - [Physical activity](#physical-activity-3)
  - [Race](#race-1)
  - [Sedentary behaviour](#sedentary-behaviour)
  - [Sleep](#sleep-2)
  - [Sleep apnea](#sleep-apnea)
  - [Sugar sweetened beverages](#sugar-sweetened-beverages-1)
  - [Waist circumference](#waist-circumference)
  - [Whole grain consumption](#whole-grain-consumption)
- [Generalized anxiety disorder](#generalized-anxiety-disorder)
  - [ACEs-Childhood maltreatment](#aces-childhood-maltreatment)
  - [Absolute risk](#absolute-risk)
  - [Smoking - cigarettes](#smoking---cigarettes-8)
  - [Family history](#family-history-8)
  - [Physical activity](#physical-activity-4)
  - [Previous mental disorders](#previous-mental-disorders)
  - [Sedentary behaviour](#sedentary-behaviour-2)
  - [Substance abuse](#substance-abuse)
  - [Work stress-Job strain](#work-stress-job-strain)
- [Hypertension](#hypertension-3)
  - [Age](#age-2)
  - [Alcohol](#alcohol-2)
  - [BMI](#bmi-5)
  - [Family history](#family-history-9)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption)
  - [Oral contraceptive use](#oral-contraceptive-use-1)
  - [Physical activity](#physical-activity-5)
  - [Premature birth](#premature-birth)
  - [Race](#race-2)
  - [Sleep](#sleep-3)
  - [Smoking - cigarettes](#smoking---cigarettes-9)
  - [Sodium intake](#sodium-intake)
- [Kidney cancer](#kidney-cancer)
  - [BMI](#bmi-6)
  - [Smoking - cigarettes](#smoking---cigarettes-10)
  - [Diabetes - Type 2](#diabetes---type-2-7)
  - [Family history](#family-history-10)
  - [Hepatitis C](#hepatitis-c-1)
  - [Hypertension](#hypertension-4)
  - [Kidney stones](#kidney-stones)
- [Lung cancer](#lung-cancer)
  - [Asbestos exposure](#asbestos-exposure)
  - [BMI](#bmi-7)
  - [Diabetes - Type 2](#diabetes---type-2-8)
  - [Family history](#family-history-11)
  - [Inflammation and lung disease](#inflammation-and-lung-disease)
  - [Race](#race-3)
  - [Radiation therapy](#radiation-therapy)
  - [Second-hand smoke](#second-hand-smoke-1)
  - [Smoking - cigarettes](#smoking---cigarettes-11)
- [Osteoporosis](#osteoporosis)
  - [Age](#age-3)
  - [Alcohol](#alcohol-3)
  - [BMI](#bmi-8)
  - [Breast cancer](#breast-cancer-1)
  - [Celiac disease](#celiac-disease)
  - [Diabetes - Type 2](#diabetes---type-2-9)
  - [Epilepsy](#epilepsy)
  - [Family history of fractures](#family-history-of-fractures)
  - [Glucocorticoid replacement therapy](#glucocorticoid-replacement-therapy)
  - [Irritable bowel syndrome](#irritable-bowel-syndrome)
  - [Previous fracture](#previous-fracture)
  - [Race](#race-4)
  - [Rheumatoid arthritis](#rheumatoid-arthritis)
  - [Smoking - cigarettes](#smoking---cigarettes-12)
  - [Subclinical hyperthyroidism](#subclinical-hyperthyroidism)
- [Ovarian cancer](#ovarian-cancer)
  - [Asbestos exposure](#asbestos-exposure-1)
  - [Breastfeeding](#breastfeeding-1)
  - [Family history](#family-history-12)
  - [High parity and Oral contraception](#high-parity-and-oral-contraception)
  - [Hysterectomy and tubal ligation](#hysterectomy-and-tubal-ligation)
- [Pancreatic cancer](#pancreatic-cancer)
  - [Alcohol](#alcohol-4)
  - [BMI](#bmi-9)
  - [Diabetes - Type 2](#diabetes---type-2-10)
  - [Family history](#family-history-13)
  - [Smoking - cigarettes](#smoking---cigarettes-13)
- [Prostate cancer](#prostate-cancer)
  - [5-a reductase inhibitors](#5-a-reductase-inhibitors)
  - [Ejaculation frequency](#ejaculation-frequency)
  - [Family history](#family-history-14)
  - [Sexual activity and STIs](#sexual-activity-and-stis)
  - [Tomato sauce](#tomato-sauce)
- [Skin cancer (Melanoma)](#skin-cancer-melanoma)
  - [Alcohol](#alcohol-5)
  - [Eye colour, family history, hair colour](#eye-colour-family-history-hair-colour)
  - [Tanning beds](#tanning-beds)
- [Stroke](#stroke-1)
  - [Absolute risk](#absolute-risk-1)
  - [Age](#age-4)
  - [Alcohol intake](#alcohol-intake)
  - [BMI](#bmi-10)
  - [Coronary heart disease](#coronary-heart-disease-1)
  - [Diabetes - Type 2](#diabetes---type-2-11)
  - [Family history](#family-history-15)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption-1)
  - [Hypertension](#hypertension-5)
  - [Oral contraceptives](#oral-contraceptives-1)
  - [Physical activity](#physical-activity-6)
  - [Race](#race-5)
  - [Smoking - cigarettes](#smoking---cigarettes-14)
  - [Sodium intake](#sodium-intake-1)

---


## Bladder cancer


### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### BMI
 - **Relative risk:**
    - Sun, J., Zhao, L., Yang, Y., Ma, X., Wang, Y., & Xiang, Y. (2015) Obesity and Risk of Bladder Cancer: A Dose-Response Meta-Analysis of 15 Cohort Studies. *PLOS ONE*, 10(3), e0119313. [DOI: 10.1371/journal.pone.0119313](https://doi.org/10.1371/journal.pone.0119313)
      - JBI Score: 100. [See report](jbi-reports/Sun%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Flegal, K. M., Carroll, M. D., Kit, B. K., & Ogden, C. L. (2012). Prevalence of Obesity and Trends in the Distribution of Body Mass Index Among US Adults, 1999-2010. *JAMA*, 307(5), 491. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)
      - JBI Score: 94.4. [See report](jbi-reports/Flegal%20et%20al.%20(2012).md)

### Diabetes - Type 2
 - **Relative risk:**
    - Larsson, S. C., Orsini, N., Brismar, K., & Wolk, A. (2006) Diabetes mellitus and risk of bladder cancer: a meta-analysis. *Diabetologia*, 49(12), 2819-2823. [DOI: 10.1007/s00125-006-0468-0](https://doi.org/10.1007/s00125-006-0468-0)
      - JBI Score: 95.5. [See report](jbi-reports/Larsson%20et%20al.%20(2006).md)

 - **Prevalence:**
    - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. Health Promotion and Chronic Disease Prevention in Canada, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
      - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk:**
    - Murta-Nascimento, C., Silverman, D. T., Kogevinas, M., García-Closas, M., Rothman, N., Tardón, A., ... Malats, N. (2007) Risk of Bladder Cancer Associated with Family History of Cancer: Do Low-Penetrance Polymorphisms Account for the Increase in Risk?. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 16(8), 1595-1600. [DOI: 10.1158/1055-9965.epi-06-0743](https://doi.org/10.1158/1055-9965.epi-06-0743)
      - JBI Score: 90. [See report](jbi-reports/Murta-Nascimento%20et%20al.%20(2007).md)

 - **Prevalence:**
    - Pinsky, P. F. (2003). Reported Family History of Cancer in the Prostate, Lung, Colorectal, and Ovarian Cancer Screening Trial. *American Journal of Epidemiology*, 157(9), 792–799. [DOI: 10.1093/aje/kwg043](https://doi.org/10.1093/aje/kwg043)
      - JBI Score: 81.8. [See report](jbi-reports/Pinsky%20et%20al.%20(2003).md)

### Fruit and vegetable consumption
 - **Relative risk:**
    - Yao, B., Yan, Y., Ye, X., Fang, H., Xu, H., Liu, Y., Li, S., & Zhao, Y. (2014). Intake of fruit and vegetables and risk of bladder cancer: a dose–response meta-analysis of observational studies. *Cancer Causes & Control*, 25(12), 1645–1658. [DOI: 10.1007/s10552-014-0469-0](https://doi.org/10.1007/s10552-014-0469-0)
      - JBI Score: Missing

 - **Prevalence:**
    - Miller, V., Mente, A., Dehghan, M., Rangarajan, S., Zhang, X., Swaminathan, S., Dagenais, G., Gupta, R., Mohan, V., Lear, S., Bangdiwala, S. I., Schutte, A. E., Wentzel-Viljoen, E., Avezum, A., Altuntas, Y., Yusoff, K., Ismail, N., Peer, N., Chifamba, J., … Mapanga, R. (2017). Fruit, vegetable, and legume intake, and cardiovascular disease and deaths in 18 countries (PURE): a prospective cohort study. *The Lancet*, 390(10107), 2037–2049. [DOI: 10.1016/s0140-6736(17)32253-5](https://doi.org/10.1016/s0140-6736(17)32253-5)
      - JBI Score: 95.5 [see report](jbi-reports/Miller%20et%20al.%20(2017).md)

### Race
  - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

  - **Prevalence:**
    - USA Facts. (2023). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01> 

### Smoking - cigarettes
 - **Relative risk and prevalence:**
    - Freedman, N. D. (2011). Association Between Smoking and Risk of Bladder Cancer Among Men and Women. *JAMA*, 306(7), 737. [DOI: 10.1001/jama.2011.1142](https://doi.org/10.1001/jama.2011.1142)
      - JBI Score: 95.5 [see report](jbi-reports/Freedman%20et%20al.%20(2011).md)


## Breast cancer


### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries. 

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Age - Menarche
 - **Relative risk and prevalence:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2012). Menarche, menopause, and breast cancer risk: individual participant meta-analysis, including 118 964 women with breast cancer from 117 epidemiological studies. *The Lancet Oncology*, 13(11), 1141–1151. [DOI: 10.1016/s1470-2045(12)70425-4](https://doi.org/10.1016/s1470-2045(12)70425-4)
      - JBI Score: 100. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2012).md)

### Age - Menopause
 - **Relative risk and prevalence:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2012). Menarche, menopause, and breast cancer risk: individual participant meta-analysis, including 118 964 women with breast cancer from 117 epidemiological studies. *The Lancet Oncology*, 13(11), 1141–1151. [DOI: 10.1016/s1470-2045(12)70425-4](https://doi.org/10.1016/s1470-2045(12)70425-4)
      - JBI Score: 100. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2012).md)

### Alcohol
 - **Relative risk:**
     - Bagnardi, V., Rota, M., Botteri, E., Tramacere, I., Islami, F., Fedirko, V., ... La Vecchia, C. (2015) Alcohol consumption and site-specific cancer risk: a comprehensive dose–response meta-analysis. *British Journal of Cancer*, 112(3), 580-593. [DOI: 10.1038/bjc.2014.579](https://doi.org/10.1038/bjc.2014.579)
        - JBI Score: 100. [See report](jbi-reports/Bagnardi%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Feigelson, H. S., Calle, E. E., Robertson, A. S., Wingo, P. A., & Thun, M. J. (2001) Alcohol consumption increases the risk of fatal breast cancer (United States). *Cancer Causes &amp; Control*, 12(10), 895-902. [DOI: 10.1023/a:1013737616987](https://doi.org/10.1023/a:1013737616987)
      - JBI Score: 86.4. [See report](jbi-reports/Feigelson%20et%20al.%20(2001).md)

### Breastfeeding
 - **Relative risk:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2002). Breast cancer and breastfeeding: collaborative reanalysis of individual data from 47 epidemiological studies in 30 countries, including 50 302 women with breast cancer and 96 973 women without the disease. *The Lancet*, 360(9328), 187–195. [DOI: 10.1016/s0140-6736(02)09454-0](https://doi.org/10.1016/s0140-6736(02)09454-0)
      - JBI Score: 100. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2002).md)

 - **Prevalence:**
    - Merritt, M. A., Riboli, E., Murphy, N., Kadi, M., Tjønneland, A., Olsen, A., ... Gunter, M. J. (2015) Reproductive factors and risk of mortality in the European Prospective Investigation into Cancer and Nutrition; a cohort study. *BMC Medicine*, 13(1). [DOI: 10.1186/s12916-015-0484-3](https://doi.org/10.1186/s12916-015-0484-3)
      - JBI Score: 95.5. [See report](jbi-reports/Merritt%20et%20al.%20(2015).md)

### Diabetes - Type 2
 - **Relative risk:**
   - Boyle, P., Boniol, M., Koechlin, A., Robertson, C., Valentini, F., Coppens, K., Fairley, L.-L., Boniol, M., Zheng, T., Zhang, Y., Pasterk, M., Smans, M., Curado, M. P., Mullie, P., Gandini, S., Bota, M., Bolli, G. B., Rosenstock, J., & Autier, P. (2012). Diabetes and breast cancer risk: a meta-analysis. *British Journal of Cancer*, 107(9), 1608–1617. [DOI: 10.1038/bjc.2012.414](https://doi.org/10.1038/bjc.2012.414)
      - JBI Score: 100. [See report](jbi-reports/Boyle%20et%20al.%20(2012).md)

 - **Prevalence:**
     - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. *Health Promotion and Chronic Disease Prevention in Canada*, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
        - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2001). Familial breast cancer: collaborative reanalysis of individual data from 52 epidemiological studies including 58 209 women with breast cancer and 101 986 women without the disease. *The Lancet*, 358(9291), 1389–1399. [DOI: 10.1016/s0140-6736(01)06524-2](https://doi.org/10.1016/s0140-6736(01)06524-2)
        - JBI Score: 100. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2001).md)

 - **Prevalence:**
    - Ramsey, S. D., Yoon, P., Moonesinghe, R., & Khoury, M. J. (2006) Population-based study of the prevalence of family history of cancer: Implications for cancer screening and prevention. *Genetics in Medicine*, 8(9), 571-575. [DOI: 10.1097/01.gim.0000237867.34011.12](https://doi.org/10.1097/01.gim.0000237867.34011.12)
        - JBI Score: 88.9. [See report](jbi-reports/Ramsey%20et%20al.%20(2006).md)

### Height
 - **Relative risk and prevalence:**
    - Green, J., Cairns, B. J., Casabonne, D., Wright, F. L., Reeves, G., & Beral, V. (2011). Height and cancer incidence in the Million Women Study: prospective cohort, and meta-analysis of prospective studies of height and total cancer risk. *The Lancet Oncology*, 12(8), 785–794. [DOI: 10.1016/s1470-2045(11)70154-1](https://doi.org/10.1016/s1470-2045(11)70154-1)
      - JBI Score: 95.5. [See report](jbi-reports/Green%20et%20al.%20(2011).md)

### Hormone replacement therapy
 - **Relative risk and prevalence:**
    - Beral, V., & Million Women Study Collaborators (2003). Breast cancer and hormone-replacement therapy in the Million Women Study. *Lancet*, 362(9382), 419–427. [DOI: 10.1016/s0140-6736(03)14065-2](https://doi.org/10.1016/s0140-6736(03)14065-2)
      - JBI Score: 95.5. [See report](jbi-reports/Beral%20et%20al.%20(2003).md)

### Parity
 - **Relative risk:**
    - Lambe, M., Hsieh, C., Chan, H., Ekbom, A., Trichopoulos, D., & Adami, H.-O. (1996). Parity, age at first and last birth, and risk of breast cancer: A population-based study in Sweden. *Breast Cancer Research and Treatment*, 38(3), 305–311. [DOI: 10.1007/bf01806150](https://doi.org/10.1007/bf01806150)
      - JBI Score: 100. [See report](jbi-reports/Lambe%20et%20al.%20(1996).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2022).Fertility of Women in the United States, Table 1: Women's Number of Children Ever Born by Age and Marital Status: June 2022 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/fertility/time-series/his-cps/h2.xlsx). <https://www.census.gov/data/tables/2022/demo/fertility/women-fertility.html>

### Physical activity
 - **Relative risk and prevalence:**
    - McTiernan, A., Kooperberg, C., White, E., Wilcox, S., Coates, R., Adams-Campbell, L. L., ... Ockene, J. (2003) Recreational Physical Activity and the Risk of Breast Cancer in Postmenopausal Women. *JAMA*, 290(10), 1331. [DOI: 10.1001/jama.290.10.1331](https://doi.org/10.1001/jama.290.10.1331)
      - JBI Score: 95.5. [See report](jbi-reports/McTiernan%20et%20al.%20(2003).md)

### Race
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - USA Facts. (2023). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01> 

### Smoking - cigarettes
 - **Relative risk:**
    - Gram, I. T., Park, S., Kolonel, L. N., Maskarinec, G., Wilkens, L. R., Henderson, B. E., ... Le Marchand, L. (2015) Smoking and Risk of Breast Cancer in a Racially/Ethnically Diverse Population of Mainly Women Who Do Not Drink Alcohol. *American Journal of Epidemiology*, 182(11), 917-925. [DOI: 10.1093/aje/kwv092](https://doi.org/10.1093/aje/kwv092)
        - JBI Score: 95.5. [See report](jbi-reports/Gram%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Centers for Disease Control and Prevention. (2018). National Health Interview Survey (NHIS) Data Release. U.S. Department of Health and Human Services. <https://archive.cdc.gov/#/details?url=https://www.cdc.gov/nchs/nhis/nhis_2018_data_release.htm>


## Cervical cancer


### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Family history
 - **Relative risk:**
    - Magnusson, P. K. E., Sparén, P., & Gyllensten, U. B. (1999) Genetic link to cervical tumours. *Nature*, 400(6739), 29-30. [DOI: 10.1038/21801](https://doi.org/10.1038/21801)
      - JBI Score: 90.9. [See report](jbi-reports/Magnusson%20et%20al.%20(1999).md)

 - **Prevalence:**
    - Pinsky, P. F. (2003). Reported Family History of Cancer in the Prostate, Lung, Colorectal, and Ovarian Cancer Screening Trial. *American Journal of Epidemiology*, 157(9), 792–799. [DOI: 10.1093/aje/kwg043](https://doi.org/10.1093/aje/kwg043)
      - JBI Score: 81.8. [See report](jbi-reports/Pinsky%20et%20al.%20(2003).md)

### HIV
 - **Relative risk:**
    - Liu, G., Sharma, M., Tan, N., & Barnabas, R. V. (2018) HIV-positive women have higher risk of human papilloma virus infection, precancerous lesions, and cervical cancer. *AIDS*, 32(6), 795-808. [DOI: 10.10972FQAD.0000000000001765](https://doi.org/10.10972FQAD.0000000000001765)
      - JBI Score: 100. [See report](jbi-reports/Liu%20et%20al.%20(2018).md)

 - **Prevalence:**
    - Centers for Disease Control and Prevention. (2021) Estimated HIV incidence and prevalence in the United States, 2015–2019. HIV Surveillance Supplemental Report 2021;26(No. 1). https://stacks.cdc.gov/view/cdc/112160. 

### Number of sexual partners
 - **Relative risk:**
    - The International Collaboration of Epidemiological Studies of Cervical Cancer. (2006). Comparison of risk factors for invasive squamous cell carcinoma and adenocarcinoma of the cervix: Collaborative reanalysis of individual data on 8,097 women with squamous cell carcinoma and 1,374 women with adenocarcinoma from 12 epidemiological studies. International Journal of Cancer, 120(4), 885–891. [DOI: 10.1002/ijc.22357](https://doi.org/10.1002/ijc.22357)
      - JBI Score: 100. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2006).md)

 - **Prevalence:**
    - Mosher, W. D., Chandra, A., & Jones, J. (2005). Sexual behavior and selected health measures: men and women 15-44 years of age, United States, 2002. Advance data, (362), 1–55. [PMID: 16250464](https://pubmed.ncbi.nlm.nih.gov/16250464/)
 

### Oral contraceptive use
 - **Relative risk and prevalence:**
    - International Collaboration of Epidemiological Studies of Cervical Cancer. (2007). Cervical cancer and hormonal contraceptives: collaborative reanalysis of individual data for 16 573 women with cervical cancer and 35 509 women without cervical cancer from 24 epidemiological studies. *The Lancet*, 370(9599), 1609–1621. [DOI: 10.1016/s0140-6736(07)61684-5](https://doi.org/10.1016/s0140-6736(07)61684-5)
      - JBI Score: 100. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2007).md)

### Race
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

  - **Prevalence:**
    - USA Facts. (2023). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01> 

### Smoking - cigarettes
 - **Relative risk and prevalence:**
    - (2006) Carcinoma of the cervix and tobacco smoking: Collaborative reanalysis of individual data on 13,541 women with carcinoma of the cervix and 23,017 women without carcinoma of the cervix from 23 epidemiological studies. *International Journal of Cancer*, 118(6), 1481-1495. [DOI: 10.1002/ijc.21493](https://doi.org/10.1002/ijc.21493)
      - JBI Score: 100. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2006).md)


## Colorectal cancer


### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Alcohol
 - **Relative risk:**
    - Fedirko, V., Tramacere, I., Bagnardi, V., Rota, M., Scotti, L., Islami, F., ... Jenab, M. (2011) Alcohol drinking and colorectal cancer risk: an overall and dose–response meta-analysis of published studies. *Annals of Oncology*, 22(9), 1958-1972. [DOI: 10.1093/annonc/mdq653](https://doi.org/10.1093/annonc/mdq653)
      - JBI Score: 100. [See report](jbi-reports/Fedirko%20et%20al.%20(2011).md)

 - **Prevalence:**
    - Guenther, P. M., Ding, E. L., & Rimm, E. B. (2013). Alcoholic Beverage Consumption by Adults Compared to Dietary Guidelines: Results of the National Health and Nutrition Examination Survey, 2009-2010. *Journal of the Academy of Nutrition and Dietetics*, 113(4), 546–550. [DOI: 10.1016/j.jand.2012.12.015]( https://doi.org/10.1016/j.jand.2012.12.015)
      - JBI Score: 100. [See report](jbi-reports/Guenther%20et%20al.%20(2013).md)

### Aspirin
 - **Relative risk:**
   - Cole, B. F., Logan, R. F., Halabi, S., Benamouzig, R., Sandler, R. S., Grainge, M. J., ... Baron, J. A. (2009) Aspirin for the Chemoprevention of Colorectal Adenomas: Meta-analysis of the Randomized Trials. *JNCI: Journal of the National Cancer Institute*, 101(4), 256-266. [DOI: 10.1093/jnci/djn485](https://doi.org/10.1093/jnci/djn485)
      - JBI Score: 100. [See report](jbi-reports/Cole%20et%20al.%20(2009).md)

 - **Prevalence:**
   - Ajani, U. A., Ford, E. S., Greenland, K. J., Giles, W. H., & Mokdad, A. H. (2006). Aspirin Use Among U.S. Adults. *American Journal of Preventive Medicine*, 30(1), 74–77. [DOI: 10.1016/j.amepre.2005.08.042](https://doi.org/10.1016/j.amepre.2005.08.042)
      - JBI Score: 100. [See report](jbi-reports/Ajani%20et%20al.%20(2006).md)

### BMI
 - **Relative risk:**
    - Moghaddam, A. A., Woodward, M., & Huxley, R. (2007) Obesity and Risk of Colorectal Cancer: A Meta-analysis of 31 Studies with 70,000 Events. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 16(12), 2533-2547. [DOI: 10.1158/1055-9965.epi-07-0708](https://doi.org/10.1158/1055-9965.epi-07-0708)
        - JBI Score: 100. [See report](jbi-reports/Moghaddam%20et%20al.%20(2007).md)

 - **Prevalence:**
   - Flegal, K. M., Carroll, M. D., Kit, B. K., & Ogden, C. L. (2012). Prevalence of Obesity and Trends in the Distribution of Body Mass Index Among US Adults, 1999-2010. *JAMA*, 307(5), 491. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)
      - JBI Score: 94.4. [See report](jbi-reports/Flegal%20et%20al.%20(2012).md)

### Crohn's disease
 - **Relative risk:**
    - Canavan, C., Abrams, K. R., & Mayberry, J. (2006). Meta-analysis: colorectal and small bowel cancer risk in patients with Crohn’s disease. *Alimentary Pharmacology & Therapeutics*, 23(8), 1097–1104. [DOI: 10.1111/j.1365-2036.2006.02854.x](https://doi.org/10.1111/j.1365-2036.2006.02854.x)
      - JBI Score: Missing

 - **Prevalence:**
    - Kappelman, M. D., Rifas–Shiman, S. L., Kleinman, K., Ollendorf, D., Bousvaros, A., Grand, R. J., & Finkelstein, J. A. (2007). The Prevalence and Geographic Distribution of Crohn’s Disease and Ulcerative Colitis in the United States. *Clinical Gastroenterology and Hepatology*, 5(12), 1424–1429. [DOI: 10.1016/j.cgh.2007.07.012](https://doi.org/10.1016/j.cgh.2007.07.012)
      - JBI Score: 100. [See report](jbi-reports/Kappelman%20et%20al.%20(2007).md)

### Diabetes - Type 2
 - **Relative risk:**
    - Yuhara, H., Steinmaus, C., Cohen, S. E., Corley, D. A., Tei, Y., & Buffler, P. A. (2011) Is Diabetes Mellitus an Independent Risk Factor for Colon Cancer and Rectal Cancer?. *American Journal of Gastroenterology*, 106(11), 1911-1921. [DOI: 10.1038/ajg.2011.301](https://doi.org/10.1038/ajg.2011.301)

 - **Prevalence:**
    - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. *Health Promotion and Chronic Disease Prevention in Canada*, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
        - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk and prevalence:**
    - Taylor, D. P., Burt, R. W., Williams, M. S., Haug, P. J., & Cannon–Albright, L. A. (2010) Population-Based Family History–Specific Risks for Colorectal Cancer: A Constellation Approach. *Gastroenterology*, 138(3), 877-885. [DOI: 10.1053/j.gastro.2009.11.044](https://doi.org/10.1053/j.gastro.2009.11.044)
      - JBI Score: 95.5. [See report](jbi-reports/Taylor%20et%20al.%20(2010).md)

### Fruit and vegetable consumption
 - **Relative risk:**
    - Aune, D., Lau, R., Chan, D. S., Vieira, R., Greenwood, D. C., Kampman, E., ... Norat, T. (2011) Nonlinear Reduction in Risk for Colorectal Cancer by Fruit and Vegetable Intake Based on Meta-analysis of Prospective Studies. *Gastroenterology*, 141(1), 106-118. [DOI: 10.1053/j.gastro.2011.04.013](https://doi.org/10.1053/j.gastro.2011.04.013)
        - JBI Score: 100. [See report](jbi-reports/Aune%20et%20al.%20(2011).md)

 - **Prevalence:**
    - Miller, V., Mente, A., Dehghan, M., Rangarajan, S., Zhang, X., Swaminathan, S., Dagenais, G., Gupta, R., Mohan, V., Lear, S., Bangdiwala, S. I., Schutte, A. E., Wentzel-Viljoen, E., Avezum, A., Altuntas, Y., Yusoff, K., Ismail, N., Peer, N., Chifamba, J., … Mapanga, R. (2017). Fruit, vegetable, and legume intake, and cardiovascular disease and deaths in 18 countries (PURE): a prospective cohort study. *The Lancet*, 390(10107), 2037–2049. [DOI: 10.1016/s0140-6736(17)32253-5](https://doi.org/10.1016/s0140-6736(17)32253-5)
      - JBI Score: 95.5 [see report](jbi-reports/Miller%20et%20al.%20(2017).md)

### Oral contraceptives
 - **Relative risk:**
    - Abusal, F., Aladwan, M., Alomari, Y., Obeidat, S., Abuwardeh, S., AlDahdouh, H., ... Odat, Q. (2022) Oral contraceptives and colorectal cancer risk - A meta-analysis and systematic review. *Annals of Medicine &amp; Surgery*, 83. [DOI: 10.1016/j.amsu.2022.104254](https://doi.org/10.1016/j.amsu.2022.104254)
      - JBI Score: 100. [See report](jbi-reports/Abusal%20et%20al.%20(2022).md)

 - **Prevalence:**
    - Daniels, K., & Abma, J. C. (2020). Current Contraceptive Status Among Women Aged 15-49: United States, 2017-2019. NCHS data brief, (388), 1–8. Hyattsville, MD: National Center for Health Statistics. 2020. [https://www.cdc.gov/nchs/products/databriefs/db388.htm](https://www.cdc.gov/nchs/products/databriefs/db388.htm)
    
### Physical activity
 - **Relative risk:**
    - Wolin, K. Y., Yan, Y., Colditz, G. A., & Lee, I. (2009) Physical activity and colon cancer prevention: a meta-analysis. *British Journal of Cancer*, 100(4), 611-616. [DOI: 10.1038/sj.bjc.6604917](https://doi.org/10.1038/sj.bjc.6604917)
      - JBI Score: 100. [See report](jbi-reports/Wolin%20et%20al.%20(2009).md)

 - **Prevalence:**
    - Whitfield, G. P., Hyde, E. T., & Carlson, S. A. (2021). Participation in Leisure-Time Aerobic Physical Activity Among Adults, National Health Interview Survey, 1998–2018. *Journal of Physical Activity and Health*, 18(S1), S25–S36. [DOI: 10.1123/jpah.2021-0014](https://doi.org/10.1123/jpah.2021-0014)
      - JBI Score: 100. [See report](jbi-reports/Whitfield%20et%20al.%20(2021).md)

### Race
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Smoking - cigarettes
 - **Relative risk:**
    - Tsoi, K. K., Pau, C. Y., Wu, W. K., Chan, F. K., Griffiths, S., & Sung, J. J. (2009) Cigarette Smoking and the Risk of Colorectal Cancer: A Meta-analysis of Prospective Cohort Studies. *Clinical Gastroenterology and Hepatology*, 7(6), 682-688.e5. [DOI: 10.1016/j.cgh.2009.02.016](https://doi.org/10.1016/j.cgh.2009.02.016)
        - JBI Score: 100. [See report](jbi-reports/Tsoi%20et%20al.%20(2009).md)

 - **Prevalence:**
    - Statistics Canada. (2020). Canadian Tobacco and Nicotine Survey (CTNS). Table 1: Smoking status, by age group and gender, 2020. [https://www.canada.ca/en/health-canada/services/canadian-tobacco-nicotine-survey/2020-summary/2020-detailed-tables.html](https://www.canada.ca/en/health-canada/services/canadian-tobacco-nicotine-survey/2020-summary/2020-detailed-tables.html)

### Ulcerative colitis
 - **Relative risk:**
    - Jess, T., Rungoe, C., & Peyrin–Biroulet, L. (2012) Risk of Colorectal Cancer in Patients With Ulcerative Colitis: A Meta-analysis of Population-Based Cohort Studies. *Clinical Gastroenterology and Hepatology*, 10(6), 639-645. [DOI: 10.1016/j.cgh.2012.01.010](https://doi.org/10.1016/j.cgh.2012.01.010)
        - JBI Score: 100. [See report](jbi-reports/Jess%20et%20al.%20(2012).md)

 - **Prevalence:**
    - Kappelman, M. D., Rifas–Shiman, S. L., Kleinman, K., Ollendorf, D., Bousvaros, A., Grand, R. J., & Finkelstein, J. A. (2007). The Prevalence and Geographic Distribution of Crohn’s Disease and Ulcerative Colitis in the United States. *Clinical Gastroenterology and Hepatology*, 5(12), 1424–1429. [DOI: 10.1016/j.cgh.2007.07.012](https://doi.org/10.1016/j.cgh.2007.07.012)
      - JBI Score: 100. [See report](jbi-reports/Kappelman%20et%20al.%20(2007).md)


## Coronary heart disease

### Age
 - **Relative risk:**
    - National Center for Health Statistics, United States. (2020-2021). Respondent-reported prevalence of heart disease in adults aged 18 and over, by selected characteristics: United States, selected years 1997-2019 [Dataset](https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/Health_US/hus20-21tables/hdprv.xlsx). Hyattsville, MD. Available from: <https://www.cdc.gov/nchs/hus/data-finder.htm?year=2020-2021&table=Table%20HDPrv>.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Antihypertensive medication
 - **Relative risk and prevalence:**
    - Liu, K., Colangelo, L. A., Daviglus, M. L., Goff, D. C., Pletcher, M., Schreiner, P. J., Sibley, C. T., Burke, G. L., Post, W. S., Michos, E. D., & Lloyd‐Jones, D. M. (2015). Can Antihypertensive Treatment Restore the Risk of Cardiovascular Disease to Ideal Levels? *Journal of the American Heart Association*, 4(9). [DOI: 10.1161/jaha.115.002275](https://doi.org/10.1161/jaha.115.002275)
      - JBI Score: 90.9. [See report](jbi-reports/Liu%20et%20al.%20(2015).md)

### Anxiety
 - **Relative risk:**
    - Emdin, C. A., Odutayo, A., Wong, C. X., Tran, J., Hsiao, A. J., & Hunn, B. H. M. (2016). Meta-Analysis of Anxiety as a Risk Factor for Cardiovascular Disease. *The American Journal of Cardiology*, 118(4), 511–519. [DOI: 10.1016/j.amjcard.2016.05.041](https://doi.org/10.1016/j.amjcard.2016.05.041)
      - JBI Score: 95.5. [See report](jbi-reports/Emdin%20et%20al.%20(2016).md)

 - **Prevalence:**
    - Kessler, R. C., Angermeyer, M., Anthony, J. C., DE Graaf, R., Demyttenaere, K., Gasquet, I., DE Girolamo, G., Gluzman, S., Gureje, O., Haro, J. M., Kawakami, N., Karam, A., Levinson, D., Medina Mora, M. E., Oakley Browne, M. A., Posada-Villa, J., Stein, D. J., Adley Tsang, C. H., Aguilar-Gaxiola, S., Alonso, J., … Ustün, T. B. (2007). Lifetime prevalence and age-of-onset distributions of mental disorders in the World Health Organization's World Mental Health Survey Initiative. *World psychiatry : official journal of the World Psychiatric Association (WPA)*, 6(3), 168–176. [https://pmc.ncbi.nlm.nih.gov/articles/PMC2174588/](https://pmc.ncbi.nlm.nih.gov/articles/PMC2174588/)
      - JBI Score: 100. [See report](jbi-reports/Kessler%20et%20al.%20(2007).md)

### Apolipoprotein B-100
 - **Relative risk:**
    - Benn, M., Nordestgaard, B. G., Jensen, G. B., & Tybjærg-Hansen, A. (2007) Improving Prediction of Ischemic Cardiovascular Disease in the General Population Using Apolipoprotein B. *Arteriosclerosis, Thrombosis, and Vascular Biology*, 27(3), 661-670. [DOI: 10.1161/01.ATV.0000255580.73689.8e](https://doi.org/10.1161/01.ATV.0000255580.73689.8e)
      - JBI Score: 91 [See report](jbi-reports/Benn%20et%20al.%20%282007%29.md)

 - **Prevalence:**
    - Carroll, M. D., Kruszon-Moran, D., & Tolliver, E. (2019). Trends in Apolipoprotein B, Non-high-density Lipoprotein Cholesterol, and Low-density Lipoprotein Cholesterol for Adults Aged 20 and Over, 2005-2016. National health statistics reports, (127), 1–16. [https://www.cdc.gov/nchs/data/nhsr/nhsr127.pdf](https://www.cdc.gov/nchs/data/nhsr/nhsr127.pdf)

### Apolipoproteins (B-100 and A-I)
 - **Relative risk and prevalence:**
    - Walldius, G., de Faire, U., Alfredsson, L., Leander, K., Westerholm, P., Malmström, H., Ivert, T., & Hammar, N. (2021). Long-term risk of a major cardiovascular event by apoB, apoA-1, and the apoB/apoA-1 ratio—Experience from the Swedish AMORIS cohort: A cohort study. *PLOS Medicine*, 18(12), e1003853. [DOI: 10.1371/journal.pmed.1003853](https://doi.org/10.1371/journal.pmed.1003853)
      - JBI Score: 95.5. [See report](jbi-reports/Walldius%20et%20al.%20(2021).md)

### Blood pressure
 - **Relative risk:**
    - Razo, C., Welgan, C. A., Johnson, C. O., McLaughlin, S. A., Iannucci, V., Rodgers, A., Wang, N., LeGrand, K. E., Sorensen, R. J. D., He, J., Zheng, P., Aravkin, A. Y., Hay, S. I., Murray, C. J. L., & Roth, G. A. (2022). Effects of elevated systolic blood pressure on ischemic heart disease: a Burden of Proof study. *Nature Medicine*, 28(10), 2056–2065. https://doi.org/10.1038/s41591-022-01974-1
      - JBI Score: 100. [See report](jbi-reports/Razo%20et%20al.%20(2022).md)

 - **Prevalence:**
    - Muntner, P., Hardy, S. T., Fine, L. J., Jaeger, B. C., Wozniak, G., Levitan, E. B., & Colantonio, L. D. (2020). Trends in Blood Pressure Control Among US Adults With Hypertension, 1999-2000 to 2017-2018. *JAMA*, 324(12), 1190. https://doi.org/10.1001/jama.2020.14545
      - JBI Score: 100. [See report](jbi-reports/Muntner%20et%20al.%20(2020).md)

### BMI
 - **Relative risk and prevalence:**
    - Flint, A. J., Rexrode, K. M., Hu, F. B., Glynn, R. J., Caspard, H., Manson, J. E., ... Rimm, E. B. (2010) Body mass index, waist circumference, and risk of coronary heart disease: A prospective study among men and women. *Obesity Research &amp; Clinical Practice*, 4(3), e171-e181. [DOI: 10.10162Fj.orcp.2010.01.001](https://doi.org/10.10162Fj.orcp.2010.01.001)
      - JBI Score: 95.5. [See report](jbi-reports/Flint%20et%20al.%20(2010).md)

### C-reactive protein
 - **Relative risk:**
    - Pai, J. K., Pischon, T., Ma, J., Manson, J. E., Hankinson, S. E., Joshipura, K., ... Rimm, E. B. (2004) Inflammatory Markers and the Risk of Coronary Heart Disease in Men and Women. *New England Journal of Medicine*, 351(25), 2599-2610. [DOI: 10.1056/NEJMoa040967](https://doi.org/10.1056/NEJMoa040967)
      - JBI Score: 95.5. [See report](jbi-reports/Pai%20et%20al.%20(2004).md)

 - **Prevalence:**
    - Khera, A., McGuire, D. K., Murphy, S. A., Stanek, H. G., Das, S. R., Vongpatanasin, W., Wians, F. H., Jr, Grundy, S. M., & de Lemos, J. A. (2005). Race and Gender Differences in C-Reactive Protein Levels. *Journal of the American College of Cardiology*, 46(3), 464–469. [DOI: 10.1016/j.jacc.2005.04.051](https://doi.org/10.1016/j.jacc.2005.04.051) 
      - JBI Score: 100. [See report](jbi-reports/Khera20et20al.20(2005).md)

### Cholesterol - HDL
 - **Relative risk:**
    - Manninen, V., Tenkanen, L., Koskinen, P., Huttunen, J. K., Mänttäri, M., Heinonen, O. P., ... Frick, M. H. (1992) Joint effects of serum triglyceride and LDL cholesterol and HDL cholesterol concentrations on coronary heart disease risk in the Helsinki Heart Study. Implications for treatment.. *Circulation*, 85(1), 37-45. [DOI: 10.1161/01.CIR.85.1.37](https://doi.org/10.1161/01.CIR.85.1.37)
      - JBI Score: 96.1. [See report](jbi-reports/Manninen%20et%20al.%20(1992).md)

 - **Prevalence:**
    - Tsao, C. W., Aday, A. W., Almarzooq, Z. I., Anderson, C. A. M., Arora, P., Avery, C. L., Baker-Smith, C. M., Beaton, A. Z., Boehme, A. K., Buxton, A. E., Commodore-Mensah, Y., Elkind, M. S. V., Evenson, K. R., Eze-Nliam, C., Fugar, S., Generoso, G., Heard, D. G., Hiremath, S., … Ho, J. E. (2023). Heart Disease and Stroke Statistics—2023 Update: A Report From the American Heart Association. *Circulation*, 147(8). [DOI: 10.1161/cir.0000000000001123](https://doi.org/10.1161/cir.0000000000001123)

### Cholesterol - LDL
 - **Relative risk and prevalence:**
    - Mortensen, M. B., & Nordestgaard, B. G. (2020). Elevated LDL cholesterol and increased risk of myocardial infarction and atherosclerotic cardiovascular disease in individuals aged 70–100 years: a contemporary primary prevention cohort. *The Lancet*, 396(10263), 1644–1652. [DOI: 10.1016/s0140-6736(20)32233-9](https://doi.org/10.1016/s0140-6736(20)32233-9)
      - JBI Score: 90.9. [See report](jbi-reports/Mortensen%20%26%20Nordestgaard%20(2020).md)

### Cholesterol - Total
 - **Relative risk:**
    - Peters, S. A., Singhateh, Y., Mackay, D., Huxley, R. R., & Woodward, M. (2016) Total cholesterol as a risk factor for coronary heart disease and stroke in women compared with men: A systematic review and meta-analysis. *Atherosclerosis*, 248, 123-131. [DOI: 10.1016/j.atherosclerosis.2016.03.016](https://doi.org/10.1016/j.atherosclerosis.2016.03.016)
      - JBI Score: 95.5. [See report](jbi-reports/Peters%20et%20al.%20(2016).md)

 - **Prevalence:**
    - Tsao, C. W., Aday, A. W., Almarzooq, Z. I., Anderson, C. A. M., Arora, P., Avery, C. L., Baker-Smith, C. M., Beaton, A. Z., Boehme, A. K., Buxton, A. E., Commodore-Mensah, Y., Elkind, M. S. V., Evenson, K. R., Eze-Nliam, C., Fugar, S., Generoso, G., Heard, D. G., Hiremath, S., … Ho, J. E. (2023). Heart Disease and Stroke Statistics—2023 Update: A Report From the American Heart Association. *Circulation*, 147(8). [DOI: 10.1161/cir.0000000000001123](https://doi.org/10.1161/cir.0000000000001123)

### Depression
 - **Relative risk:**
    - Gan, Y., Gong, Y., Tong, X., Sun, H., Cong, Y., Dong, X., Wang, Y., Xu, X., Yin, X., Deng, J., Li, L., Cao, S., & Lu, Z. (2014). Depression and the risk of coronary heart disease: a meta-analysis of prospective cohort studies. *BMC Psychiatry*, 14(1). [DOI: 10.1186/s12888-014-0371-z](https://doi.org/10.1186/s12888-014-0371-z)
      - JBI Score: 100. [See report](jbi-reports/Gan%20et%20al.%20(2014).md)

 - **Prevalence:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. https://doi.org/10.1001/jamapsychiatry.2017.4602
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

### Diabetes - Type 2
 - **Relative risk:**
    - Peters, S. A. E., Huxley, R. R., & Woodward, M. (2014). Diabetes as risk factor for incident coronary heart disease in women compared with men: a systematic review and meta-analysis of 64 cohorts including 858,507 individuals and 28,203 coronary events. *Diabetologia*, 57(8), 1542-1551. [DOI: 10.1007/s00125-014-3260-6](https://doi.org/10.1007/s00125-014-3260-6)
      - JBI Score: 100. [See report](jbi-reports/Peters%20et%20al.%20(2014).md)

 - **Prevalence:**
    - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. *Health Promotion and Chronic Disease Prevention in Canada*, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
      - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk and prevalence:**
    - Sivapalaratnam, S., Boekholdt, S. M., Trip, M. D., Sandhu, M. S., Luben, R., Kastelein, J. J. P., ... Khaw, K. (2010) Family history of premature coronary heart disease and risk prediction in the EPIC-Norfolk prospective population study. *Heart*, 96(24), 1985-1989. [DOI: 10.1136/hrt.2010.210740](https://doi.org/10.1136/hrt.2010.210740)
      - JBI Score: 95.5. [See report](jbi-reports/Sivapalaratnam%20et%20al.%20(2010).md)

### Fruit and vegetable consumption
 - **Relative risk:**
    - He, F. J., Nowson, C. A., Lucas, M., & MacGregor, G. A. (2007) Increased consumption of fruit and vegetables is related to a reduced risk of coronary heart disease: meta-analysis of cohort studies. *Journal of Human Hypertension*, 21(9), 717-728. [DOI: 10.1038/sj.jhh.1002212](https://doi.org/10.1038/sj.jhh.1002212)
      - JBI Score: 100. [See report](jbi-reports/He%20et%20al.%20(2007).md)

 - **Prevalence:**
    - Miller, V., Mente, A., Dehghan, M., Rangarajan, S., Zhang, X., Swaminathan, S., Dagenais, G., Gupta, R., Mohan, V., Lear, S., Bangdiwala, S. I., Schutte, A. E., Wentzel-Viljoen, E., Avezum, A., Altuntas, Y., Yusoff, K., Ismail, N., Peer, N., Chifamba, J., … Mapanga, R. (2017). Fruit, vegetable, and legume intake, and cardiovascular disease and deaths in 18 countries (PURE): a prospective cohort study. *The Lancet*, 390(10107), 2037–2049. [DOI: 10.1016/s0140-6736(17)32253-5](https://doi.org/10.1016/s0140-6736(17)32253-5)
      - JBI Score: 100. [See report](jbi-reports/Miller%20et%20al.%20(2017).md)

 ### Gum disease
  - **Relative risk:**
    - Janket, S.-J., Baird, A. E., Chuang, S.-K., & Jones, J. A. (2003). Meta-analysis of periodontal disease and risk of coronary heart disease and stroke. *Oral Surgery, Oral Medicine, Oral Pathology, Oral Radiology, and Endodontology*, 95(5), 559–569. [DOI: 10.1067/moe.2003.107](https://doi.org/10.1067/moe.2003.107)
      - JBI Score: 100. [See report](jbi-reports/Janket%20et%20al.%20(2003).md)

  - **Prevalence:**
    - Eke, P. I., Dye, B. A., Wei, L., Thornton-Evans, G. O., & Genco, R. J. (2012). Prevalence of Periodontitis in Adults in the United States: 2009 and 2010. *Journal of Dental Research*, 91(10), 914–920. [DOI: 10.1177/0022034512457373](https://doi.org/10.1177/0022034512457373)
      - JBI Score: 100. [See report](jbi-reports/Eke%20et%20al.%20(2012).md)

### Hemoglobin A1c
 - **Relative risk:**
    - Pai, J. K., Cahill, L. E., Hu, F. B., Rexrode, K. M., Manson, J. E., & Rimm, E. B. (2013). Hemoglobin A1c Is Associated With Increased Risk of Incident Coronary Heart Disease Among Apparently Healthy, Nondiabetic Men and Women. *Journal of the American Heart Association*, 2(2). [DOI: 10.1161/jaha.112.000077](https://doi.org/10.1161/jaha.112.000077)
      - JBI Score: 100. [See report](jbi-reports/Pai%20et%20al.%20(2013).md)

 - **Prevalence:**
    - Carson, A. P., Fox, C. S., McGuire, D. K., Levitan, E. B., Laclaustra, M., Mann, D. M., & Muntner, P. (2010). Low Hemoglobin A1c and Risk of All-Cause Mortality Among US Adults Without Diabetes. *Circulation: Cardiovascular Quality and Outcomes*, 3(6), 661–667. [DOI: 10.1161/circoutcomes.110.957936](https://doi.org/10.1161/circoutcomes.110.957936)
      - JBI Score: 95.5. [See report](jbi-reports/Carson%20et%20al.%20(2010).md)

### Homocysteine level
 - **Relative risk and prevalence:**
    - Folsom, A. R., Chambless, L. E., Ballantyne, C. M., Coresh, J., Heiss, G., Wu, K. K., ... Sharrett, A. R. (2006) An Assessment of Incremental Coronary Risk Prediction Using C-Reactive Protein and Other Novel Risk Markers. *Archives of Internal Medicine*, 166(13), 1368. [DOI: 10.1001/archinte.166.13.1368](https://doi.org/10.1001/archinte.166.13.1368)
      - JBI Score: 95.5. [See report](jbi-reports/Folsom20et20al.20(2006).md)

### Job strain
 - **Relative risk:**
      - Kivimäki, M., Nyberg, S. T., Fransson, E. I., Heikkilä, K., Alfredsson, L., Casini, A., ... Batty, G. D. (2013) Associations of job strain and lifestyle risk factors with risk of coronary artery disease: a meta-analysis of individual participant data. *Canadian Medical Association Journal*, 185(9), 763-769. [DOI: 10.15032Fcmaj.121735](https://doi.org/10.15032Fcmaj.121735)
        - JBI Score: 100. [See report](jbi-reports/Kivimaki%20et%20al.%20(2013).md)

 - **Prevalence:**
    - Nyberg, S. T., Fransson, E. I., Heikkilä, K., Alfredsson, L., Casini, A., Clays, E., De Bacquer, D., Dragano, N., Erbel, R., Ferrie, J. E., Hamer, M., Jöckel, K.-H., Kittel, F., Knutsson, A., Ladwig, K.-H., Lunau, T., Marmot, M. G., Nordin, M., … Rugulies, R. (2013). Job Strain and Cardiovascular Disease Risk Factors: Meta-Analysis of Individual-Participant Data from 47,000 Men and Women. *PLoS ONE*, 8(6), e67323. [DOI: 10.1371/journal.pone.0067323](https://doi.org/10.1371/journal.pone.0067323)
      - JBI Score: 100. [See report](jbi-reports/Nyberg%20et%20al.%20(2013).md)

### Lipoprotein (a)
 - **Relative risk and prevalence:**
    - Bhatia, H. S., Ambrosio, M., Razavi, A. C., Alebna, P. L., Yeang, C., Spitz, J. A., Patel, J., Tsai, M. Y., Sperling, L., Shapiro, M. D., Tsimikas, S., & Mehta, A. (2025). AHA PREVENT Equations and Lipoprotein(a) for Cardiovascular Disease Risk . *JAMA Cardiology*. [DOI: 10.1001/jamacardio.2025.1603](https://doi.org/10.1001/jamacardio.2025.1603)
      - JBI Score: 95.5. [See report](jbi-reports/Bhatia%20et%20al.%20%282025%29.md)   

### Physical activity
 - **Relative risk:**
    - Kyu, H. H., Bachman, V. F., Alexander, L. T., Mumford, J. E., Afshin, A., Estep, K., ... Forouzanfar, M. H. (2016) Physical activity and risk of breast cancer, colon cancer, diabetes, ischemic heart disease, and ischemic stroke events: systematic review and dose-response meta-analysis for the Global Burden of Disease Study 2013. *BMJ*, i3857. [DOI: 10.1136/bmj.i3857](https://doi.org/10.1136/bmj.i3857)
      - JBI Score: 95.5. [See report](jbi-reports/Kyu%20et%20al.%20(2016).md)

 - **Prevalence:**
    - Matthews, C. E., Moore, S. C., Arem, H., Cook, M. B., Trabert, B., Håkansson, N., Larsson, S. C., Wolk, A., Gapstur, S. M., Lynch, B. M., Milne, R. L., Freedman, N. D., Huang, W.-Y., Berrington de Gonzalez, A., Kitahara, C. M., Linet, M. S., Shiroma, E. J., Sandin, S., Patel, A. V., & Lee, I.-M. (2020). Amount and Intensity of Leisure-Time Physical Activity and Lower Cancer Risk. *Journal of Clinical Oncology*, 38(7), 686–697. [DOI: 10.1200/jco.19.02407](https://doi.org/10.1200/jco.19.02407)
      - JBI Score: 86.4. [See report](jbi-reports/Matthews%20et%20al.%20(2020).md)

### Race
 - **Relative risk:**
    - National Center for Health Statistics, United States. (2020-2021). Respondent-reported prevalence of heart disease in adults aged 18 and over, by selected characteristics: United States, selected years 1997-2019 [Dataset](https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Publications/Health_US/hus20-21tables/hdprv.xlsx). Hyattsville, MD. Available from: <https://www.cdc.gov/nchs/hus/data-finder.htm?year=2020-2021&table=Table%20HDPrv>.

  - **Prevalence:**
    - USA Facts. (2023). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01> 

### Red meat consumption
 - **Relative risk and prevalence:**
    - Papier, K., Fensom, G. K., Knuppel, A., Appleby, P. N., Tong, T. Y. N., Schmidt, J. A., ... Perez-Cornago, A. (2021) Meat consumption and risk of 25 common conditions: outcome-wide analyses in 475,000 men and women in the UK Biobank study. *BMC Medicine*, 19(1). [DOI: 10.1186/s12916-021-01922-9](https://doi.org/10.1186/s12916-021-01922-9)
      - JBI Score: 95.5. [See report](jbi-reports/Papier%20et%20al.%20(2021).md)

### Second-hand smoke
 - **Relative risk:**
    - Fischer, F., & Kraemer, A. (2015). Meta-analysis of the association between second-hand smoke exposure and ischaemic heart diseases, COPD and stroke. *BMC Public Health*, 15(1). [DOI: 10.1186/s12889-015-2489-4](https://doi.org/10.1186/s12889-015-2489-4)
      - JBI Score: 100. [See report](jbi-reports/Fischer%20%26%20Kraemer%20(2015).md) 

 - **Prevalence:**
    - Levesque, J., & Mischki, T. (2021). Exposure to tobacco smoke among Canadian nonsmokers based on questionnaire and biomonitoring data. *Health Reports*, 32(2), 16–26. [DOI: 10.25318/82-003-x202100200002-eng](https://doi.org/10.25318/82-003-x202100200002-eng)
      - JBI Score: 100. [See report](jbi-reports/Levesque%20%26%20Mischki%20(2021).md)

### Sleep apnea
 - **Relative risk:**
    - Hla, K. M., Young, T., Hagen, E. W., Stein, J. H., Finn, L. A., Nieto, F. J., & Peppard, P. E. (2015). Coronary Heart Disease Incidence in Sleep Disordered Breathing: The Wisconsin Sleep Cohort Study. *Sleep*, 38(5), 677–684. [DOI: 10.5665/sleep.4654](https://doi.org/10.5665/sleep.4654)
      - JBI Score: 95.5. [See report](jbi-reports/Hla%20et%20al.%20(2015).md)
- **Prevalence:**
    - Kendzerska, T., Gershon, A. S., Hawker, G., Tomlinson, G., & Leung, R. S. (2014). Obstructive Sleep Apnea and Incident Diabetes. A Historical Cohort Study. *American Journal of Respiratory and Critical Care Medicine*, 190(2), 218–225. [DOI: 10.1164/rccm.201312-2209oc](https://doi.org/10.1164/rccm.201312-2209oc)
      - JBI Score: 100. [See report](jbi-reports/Kendzerska%20et%20al.%20(2014).md)
      
### Smoking - cigarettes
 - **Relative risk:**
    - Prescott, E., Hippe, M., Schnohr, P., Hein, H. O., & Vestbo, J. (1998). Smoking and risk of myocardial infarction in women and men: longitudinal population study. *BMJ*, 316(7137), 1043–1047. [DOI: 10.1136/bmj.316.7137.1043](https://doi.org/10.1136/bmj.316.7137.1043)
      - JBI Score: 95.5. [See report](jbi-reports/Prescott%20et%20al.%20(1998).md)

 - **Prevalence:**
    - Statistics Canada. (2020). Canadian Tobacco and Nicotine Survey (CTNS). Table 1: Smoking status, by age group and gender, 2020. [https://www.canada.ca/en/health-canada/services/canadian-tobacco-nicotine-survey/2020-summary/2020-detailed-tables.html](https://www.canada.ca/en/health-canada/services/canadian-tobacco-nicotine-survey/2020-summary/2020-detailed-tables.html)

### Sugar-sweetened beverages
 - **Relative risk:**
      - Huang, Y., Chen, Z., Chen, B., Li, J., Yuan, X., Li, J., Wang, W., Dai, T., Chen, H., Wang, Y., Wang, R., Wang, P., Guo, J., Dong, Q., Liu, C., Wei, Q., Cao, D., & Liu, L. (2023). Dietary sugar consumption and health: umbrella review. *BMJ*, e071609. [DOI: 10.1136/bmj-2022-071609](https://doi.org/10.1136/bmj-2022-071609)
        - JBI Score: 90.9. [See report](jbi-reports/Huang%20et%20al.%20(2023).md)

 - **Prevalence:**
    - Rosinger, A., Herrick, K., Gahche, J., & Park, S. (2017). Sugar-sweetened Beverage Consumption Among U.S. Adults, 2011-2014. NCHS data brief, (270), 1–8. [https://www.cdc.gov/nchs/data/databrief/db270.pdf](https://www.cdc.gov/nchs/data/databrief/db270.pdf)


## Dementia


### Age
 - **Relative risk:**
    - Statistics Canada. (2017). Dementia in Canada, including Alzheimer's disease. (Publication number: 170098; ISBN: 978-0-660-08718-4) <https://www.canada.ca/en/public-health/services/publications/diseases-conditions/dementia-highlights-canadian-chronic-disease-surveillance.html>.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Apolipoprotein E
 - **Relative risk and Prevalence:**
    - Rasmussen, K. L., Tybjærg-Hansen, A., Nordestgaard, B. G., & Frikke-Schmidt, R. (2018). Absolute 10-year risk of dementia by age, sex and APOE genotype: a population-based cohort study. *Canadian Medical Association Journal*, 190(35), E1033–E1041. [DOI: 10.1503/cmaj.180066](https://doi.org/10.1503/cmaj.180066)
      - JBI Score: 100. [See report](jbi-reports/Rasmussen%20et%20al.%20(2018).md)

### Atrial fibrillation
 - **Relative risk:**
    - Santangeli, P., Di Biase, L., Bai, R., Mohanty, S., Pump, A., Cereceda Brantes, M., ... Natale, A. (2012) Atrial fibrillation and the risk of incident dementia: A meta-analysis. *Heart Rhythm*, 9(11), 1761-1768.e2. [DOI: 10.1016/j.hrthm.2012.07.026](https://doi.org/10.1016/j.hrthm.2012.07.026)
      - JBI Score: 100. [See report](jbi-reports/Santangeli%20et%20al.%20(2012).md)

 - **Prevalence:**
    - Lippi, G., Sanchis-Gomar, F., & Cervellin, G. (2020). Global epidemiology of atrial fibrillation: An increasing epidemic and public health challenge. *International Journal of Stroke*, 16(2), 217–221. [DOI: 10.1177/1747493019897870](https://doi.org/10.1177/1747493019897870)
      - JBI Score: 88.9. [See report](jbi-reports/Lippi%20et%20al.%20(2020).md)

### BMI
 - **Relative risk:**
    - Whitmer, R. A., Gunderson, E. P., Barrett-Connor, E., Quesenberry, C. P., Jr, & Yaffe, K. (2005). Obesity in middle age and future risk of dementia: a 27 year longitudinal population based study. *BMJ*, 330(7504), 1360. [DOI: 10.1136/bmj.38446.466238.e0](https://doi.org/10.1136/bmj.38446.466238.e0) 
      - JBI Score: 100. [See report](jbi-reports/Whitmer%20et%20al.%20(2005).md)

 - **Prevalence:**
    - Statistics Canada. (2017).  Measured adult body mass index (BMI) (World Health Organization classification), by age group and sex, Canada and provinces, Canadian Community Health Survey - Nutrition [Dataset]. Government of Canada . [DOI: 10.25318/1310079401-ENG](https://doi.org/10.25318/1310079401-ENG)

### Coronary artery disease
 - **Relative risk:**
    - Wolters, F. J., Segufa, R. A., Darweesh, S. K. L., Bos, D., Ikram, M. A., Sabayan, B., Hofman, A., & Sedaghat, S. (2018). Coronary heart disease, heart failure, and the risk of dementia: A systematic review and meta‐analysis. *Alzheimer’s & Dementia*, 14(11), 1493–1504. [DOI: 10.1016/j.jalz.2018.01.007](https://doi.org/10.1016/j.jalz.2018.01.007)
      - JBI Score: 100. [See report](jbi-reports/Wolters%20et%20al.%20(2018).md)

 - **Prevalence:**
    - Benjamin, E. J., Muntner, P., Alonso, A., Bittencourt, M. S., Callaway, C. W., Carson, A. P., Chamberlain, A. M., Chang, A. R., Cheng, S., Das, S. R., Delling, F. N., Djousse, L., Elkind, M. S. V., Ferguson, J. F., Fornage, M., Jordan, L. C., Khan, S. S., Kissela, B. M., … Knutson, K. L. (2019). Heart Disease and Stroke Statistics—2019 Update: A Report From the American Heart Association. *Circulation*, 139(10). [DOI: 10.1161/cir.0000000000000659](https://doi.org/10.1161/cir.0000000000000659)

### Depression
 - **Relative risk:**
    - Katon, W., Pedersen, H. S., Ribe, A. R., Fenger-Grøn, M., Davydow, D., Waldorff, F. B., & Vestergaard, M. (2015). Effect of Depression and Diabetes Mellitus on the Risk for Dementia. *JAMA Psychiatry*, 72(6), 612. [DOI: 10.1001/jamapsychiatry.2015.0082](https://doi.org/10.1001/jamapsychiatry.2015.0082)
      - JBI Score: 100. [See report](jbi-reports/Katon%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

### Diabetes - Type 2
 - **Relative risk:**
    - Xue, M., Xu, W., Ou, Y.-N., Cao, X.-P., Tan, M.-S., Tan, L., & Yu, J.-T. (2019). Diabetes mellitus and risks of cognitive impairment and dementia: A systematic review and meta-analysis of 144 prospective studies. *Ageing Research Reviews*, 55, 100944. [DOI: 10.1016/j.arr.2019.100944](https://doi.org/10.1016/j.arr.2019.100944)
      - JBI Score: 100. [See report](jbi-reports/Xue%20et%20al.%20(2019).md)

 - **Prevalence:**
    - Centers for Disease Control and Prevention (2024). National Diabetes Statistics Report website. [https://www.cdc.gov/diabetes/php/data-research/index.html](https://www.cdc.gov/diabetes/php/data-research/index.html)

### Education
 - **Relative risk:**
    - Launer, L. J., Andersen, K., Dewey, M. E., Letenneur, L., Ott, A., Amaducci, L. A., Brayne, C., Copeland, J. R. M., Dartigues, J.-F., Kragh-Sorensen, P., Lobo, A., Martinez-Lage, J. M., Stijnen, T., & Hofman, A. (1999). Rates and risk factors for dementia and Alzheimer’s disease. *Neurology*, 52(1), 78–78. [DOI: 10.1212/wnl.52.1.78](https://doi.org/10.1212/wnl.52.1.78)
      - JBI Score: 86.4. [See report](jbi-reports/Launer%20et%20al.%20(1999).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Educational Attainment in the United States, Table 1: All Races [Dataset](https://www2.census.gov/programs-surveys/demo/tables/educational-attainment/2021/cps-detailed-tables/table-1-1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/educational-attainment/cps-detailed-tables.html>

### Family history
 - **Relative risk and prevalence:**
    - Cannon-Albright, L. A., Foster, N. L., Schliep, K., Farnham, J. M., Teerlink, C. C., Kaddas, H., Tschanz, J., Corcoran, C., & Kauwe, J. S. K. (2019). Relative risk for Alzheimer disease based on complete family history. *Neurology*, 92(15). [DOI: 10.1212/wnl.0000000000007231](https://doi.org/10.1212/wnl.0000000000007231)
      - JBI Score: 95.5. [See report](jbi-reports/Cannon-Albright%20et%20al.%20(2019).md)

### Hearing loss
 - **Relative risk:**
    - Liang, Z., Li, A., Xu, Y., Qian, X., & Gao, X. (2021). Hearing Loss and Dementia: A Meta-Analysis of Prospective Cohort Studies. *Frontiers in Aging Neuroscience*, 13. [DOI: 10.3389/fnagi.2021.695117](https://doi.org/10.3389/fnagi.2021.695117)
      - JBI Score: 100. [See report](jbi-reports/Liang%20et%20al.%20(2021).md)

 - **Prevalence:**
     - Mick, P. T., Kabir, R., Pichora-Fuller, M. K., Jones, C., Moxham, L., Phillips, N., Urry, E., & Wittich, W. (2023). Associations Between Cardiovascular Risk Factors and Audiometric Hearing: Findings From the Canadian Longitudinal Study on Aging. *Ear & Hearing*, 44(6), 1332–1343. [DOI: 10.1097/aud.0000000000001370](https://doi.org/10.1097/aud.0000000000001370)
        - JBI Score: 100. [See report](jbi-reports/Mick%20et%20al.%20(2021).md)

### Hypertension
 - **Relative risk:**
    - Gottesman, R. F., Albert, M. S., Alonso, A., Coker, L. H., Coresh, J., Davis, S. M., Deal, J. A., McKhann, G. M., Mosley, T. H., Sharrett, A. R., Schneider, A. L. C., Windham, B. G., Wruck, L. M., & Knopman, D. S. (2017). Associations Between Midlife Vascular Risk Factors and 25-Year Incident Dementia in the Atherosclerosis Risk in Communities (ARIC) Cohort. *JAMA Neurology*, 74(10), 1246. [DOI: 10.1001/jamaneurol.2017.1658](https://doi.org/10.1001/jamaneurol.2017.1658)
      - JBI Score: 100. [See report](jbi-reports/Gottesman%20et%20al.%20(2017).md)
    
 - **Prevalence:**
    - Booth, J. N., III, Li, J., Zhang, L., Chen, L., Muntner, P., & Egan, B. (2017). Trends in Prehypertension and Hypertension Risk Factors in US Adults. *Hypertension*, 70(2), 275–284. [DOI: 10.1161/hypertensionaha.116.09004](https://doi.org/10.1161/hypertensionaha.116.09004)
      - JBI Score: 100. [See report](jbi-reports/Booth%20et%20al.%20(2017).md)

### Race
 - **Relative risk:**
    - Shiekh, S. I., Cadogan, S. L., Lin, L.-Y., Mathur, R., Smeeth, L., & Warren-Gash, C. (2021). Ethnic Differences in Dementia Risk: A Systematic Review and Meta-Analysis. *Journal of Alzheimer’s Disease*, 80(1), 337–355. [DOI: 10.3233/jad-201209](https://doi.org/10.3233/jad-201209)
      - JBI Score: 100. [See report](jbi-reports/Shiekh%20et%20al.%20(2021).md)

  - **Prevalence:**
    - USA Facts. (2023). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01> 

### Sedentary behaviour
 - **Relative risk and prevalence:**
    - Huang, S.-Y., Li, Y.-Z., Zhang, Y.-R., Huang, Y.-Y., Wu, B.-S., Zhang, W., Deng, Y.-T., Chen, S.-D., He, X.-Y., Chen, S.-F., Dong, Q., Zhang, C., Chen, R.-J., Suckling, J., Rolls, E. T., Feng, J.-F., Cheng, W., & Yu, J.-T. (2022). Sleep, physical activity, sedentary behavior, and risk of incident dementia: a prospective cohort study of 431,924 UK Biobank participants. *Molecular Psychiatry*, 27(10), 4343–4354. [DOI: 10.1038/s41380-022-01655-y](https://doi.org/10.1038/s41380-022-01655-y)
      - JBI Score: 100. [See report](jbi-reports/Huang%20et%20al.%20(2022).md)

### Sleep
 - **Relative risk:**
    - Fan, L., Xu, W., Cai, Y., Hu, Y., & Wu, C. (2019). Sleep Duration and the Risk of Dementia: A Systematic Review and Meta-analysis of Prospective Cohort Studies. *Journal of the American Medical Directors Association*, 20(12), 1480-1487.e5. [DOI: 10.1016/j.jamda.2019.06.009](https://doi.org/10.1016/j.jamda.2019.06.009)
      - JBI Score: 100. [See report](jbi-reports/Fan%20et%20al.%20(2019).md)

 - **Prevalence:**
    - Statistics Canada. (2022).  Sleep behaviours among Canadian adults: Findings from the 2020 Canadian Community Health Survey healthy living rapid response module. Government of Canada. <https://doi.org/10.25318/82-003-X202200300001-ENG>

### Smoking - cigarettes
 - **Relative risk:**
    - Zhong, G., Wang, Y., Zhang, Y., Guo, J. J., & Zhao, Y. (2015). Smoking Is Associated with an Increased Risk of Dementia: A Meta-Analysis of Prospective Cohort Studies with Investigation of Potential Effect Modifiers. *PLOS ONE*, 10(3), e0118333. [DOI: 10.1371/journal.pone.0118333](https://doi.org/10.1371/journal.pone.0118333)
      - JBI Score: 100. [See report](jbi-reports/Zhong%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Rusanen, M., Kivipelto, M., Quesenberry, C. P., Jr, Zhou, J., & Whitmer, R. A. (2011). Heavy Smoking in Midlife and Long-term Risk of Alzheimer Disease and Vascular Dementia. *Archives of Internal Medicine*, 171(4), 333. [DOI: 10.1001/archinternmed.2010.393](https://doi.org/10.1001/archinternmed.2010.393)  
      - JBI Score: 100. [See report](jbi-reports/Rusanen%20et%20al.%20(2011).md)

### Social relationships
 - **Relative risk:**
    - Kuiper, J. S., Zuidersma, M., Oude Voshaar, R. C., Zuidema, S. U., van den Heuvel, E. R., Stolk, R. P., & Smidt, N. (2015). Social relationships and risk of dementia: A systematic review and meta-analysis of longitudinal cohort studies. *Ageing Research Reviews*, 22, 39–57. [DOI: 10.1016/j.arr.2015.04.006](https://doi.org/10.1016/j.arr.2015.04.006)
      - JBI Score: 100. [See report](jbi-reports/Kuiper%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Röhr, S., Wittmann, F., Engel, C., Enzenbach, C., Witte, A. V., Villringer, A., Löffler, M., & Riedel-Heller, S. G. (2021). Social factors and the prevalence of social isolation in a population-based adult cohort. *Social Psychiatry and Psychiatric Epidemiology*, 57(10), 1959–1968. [DOI: 10.1007/s00127-021-02174-x](https://doi.org/10.1007/s00127-021-02174-x)
      - JBI Score: 100. [See report](jbi-reports/Rohr%20et%20al.%20(2021).md)
    - Statistics Canada. (2021). Canadian Social Survey – Well-being, Activities and Perception of Time, 2021. <https://www150.statcan.gc.ca/n1/daily-quotidien/211124/t001e-eng.htm>

### Stroke
 - **Relative risk and prevalence:**
    - Kuźma, E., Lourida, I., Moore, S. F., Levine, D. A., Ukoumunne, O. C., & Llewellyn, D. J. (2018). Stroke and dementia risk: A systematic review and meta-analysis. *Alzheimer’s & Dementia*, 14(11), 1416–1426. [DOI: 10.1016/j.jalz.2018.06.3061](https://doi.org/10.1016/j.jalz.2018.06.3061)
      - JBI Score: 100. [See report](jbi-reports/Kuzma%20et%20al.%20(2018).md)


## Depression

### Adverse childhood experiences
 - **Relative risk:**
    - Björkenstam, E., Vinnerljung, B., & Hjern, A. (2017). Impact of childhood adversities on depression in early adulthood: A longitudinal cohort study of 478,141 individuals in Sweden. *Journal of Affective Disorders*, 223, 95–100. [DOI: 10.1016/j.jad.2017.07.030](https://doi.org/10.1016/j.jad.2017.07.030)
      - JBI Score: 100. [See report](jbi-reports/Bjorkenstam%20et%20al.%20(2017).md)
    - Nelson, J., Klumparendt, A., Doebler, P., & Ehring, T. (2017). Childhood maltreatment and characteristics of adult depression: Meta-analysis. *British Journal of Psychiatry*, 210(2), 96–104. [DOI: 10.1192/bjp.bp.115.180752](https://doi.org/10.1192/bjp.bp.115.180752)
      - JBI Score: 100. [See report](jbi-reports/Nelson%20et%20al.%20(2017).md)

 - **Prevalence:**
    - Giano, Z., Wheeler, D. L., & Hubach, R. D. (2020). The frequencies and disparities of adverse childhood experiences in the U.S. *BMC Public Health*, 20(1). [DOI: 10.1186/s12889-020-09411-z](https://doi.org/10.1186/s12889-020-09411-z)
      - JBI Score: 100. [See report](jbi-reports/Giano%20et%20al.%20(2020).md)

### Age
 - **Relative risk:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Chronic pain
 - **Relative risk:**
    - Ohayon, M. M., & Schatzberg, A. F. (2003). Using Chronic Pain to Predict Depressive Morbidity in the General Population. *Archives of General Psychiatry*, 60(1), 39. [DOI: 10.1001/archpsyc.60.1.39](https://doi.org/10.1001/archpsyc.60.1.39)
      - JBI Score: 100. [See report](jbi-reports/Ohayon%20%26%20Schatzberg%20(2003).md)
 
 - **Prevalence:**
    - Zelaya, C. E., Dahlhammer, J. M., Lucas, J. W., & Connor, E. M. (2020). Chronic pain and high-impact chronic pain among U.S. adults: Prevalence and correlates. NCHS data brief, (390), 1–8. [https://www.cdc.gov/nchs/data/databriefs/db390-H.pdf](https://www.cdc.gov/nchs/data/databriefs/db390-H.pdf)

### Diabetes - Type 2
 - **Relative risk:**
    - Rotella, F., & Mannucci, E. (2013) Diabetes mellitus as a risk factor for depression. A meta-analysis of longitudinal studies. *Diabetes Research and Clinical Practice*, 99(2), 98-104. [DOI: 10.1016/j.diabres.2012.11.022](https://doi.org/10.1016/j.diabres.2012.11.022)
      - JBI Score: 100. [See report](jbi-reports/Rotella%20%26%20Mannucci%20(2013).md)

 - **Prevalence:**
    - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. *Health Promotion and Chronic Disease Prevention in Canada*, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
      - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)
  
### Education
 - **Relative risk:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Educational Attainment in the United States, Table 1: All Races [Dataset](https://www2.census.gov/programs-surveys/demo/tables/educational-attainment/2021/cps-detailed-tables/table-1-1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/educational-attainment/cps-detailed-tables.html>

### Family history
 - **Relative risk and Prevalence:**
    - van Dijk, M. T., Murphy, E., Posner, J. E., Talati, A., & Weissman, M. M. (2021). Association of Multigenerational Family History of Depression With Lifetime Depressive and Other Psychiatric Disorders in Children. *JAMA Psychiatry*, 78(7), 778. [DOI: 10.1001/jamapsychiatry.2021.0350](https://doi.org/10.1001/jamapsychiatry.2021.0350)
      - JBI Score: 100. [See report](jbi-reports/Van%20Dijk%20et%20al.%20(2021).md)

### Household income
 - **Relative risk:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2022). Income in the United States: 2022. Table A-1, [Dataset](https://www2.census.gov/programs-surveys/demo/tables/p60/279/tableA1.xlsx). Available from: <https://www.census.gov/library/publications/2023/demo/p60-279.html>

### Job strain
 - **Relative risk:**
    - Madsen, I. E. H., Nyberg, S. T., Magnusson Hanson, L. L., Ferrie, J. E., Ahola, K., Alfredsson, L., Batty, G. D., Bjorner, J. B., Borritz, M., Burr, H., Chastang, J.-F., de Graaf, R., Dragano, N., Hamer, M., Jokela, M., Knutsson, A., Koskenvuo, M., Koskinen, A., … Leineweber, C. (2017). Job strain as a risk factor for clinical depression: systematic review and meta-analysis with additional individual participant data. *Psychological Medicine*, 47(8), 1342–1356. [DOI: 10.1017/s003329171600355x](https://doi.org/10.1017/s003329171600355x)
      - JBI Score: 100. [See report](jbi-reports/Madsen%20et%20al.%20(2017).md)

 - **Prevalence:**
    - Nyberg, S. T., Fransson, E. I., Heikkilä, K., Alfredsson, L., Casini, A., Clays, E., De Bacquer, D., Dragano, N., Erbel, R., Ferrie, J. E., Hamer, M., Jöckel, K.-H., Kittel, F., Knutsson, A., Ladwig, K.-H., Lunau, T., Marmot, M. G., Nordin, M., … Rugulies, R. (2013). Job Strain and Cardiovascular Disease Risk Factors: Meta-Analysis of Individual-Participant Data from 47,000 Men and Women. *PLoS ONE*, 8(6), e67323. [DOI: 10.1371/journal.pone.0067323](https://doi.org/10.1371/journal.pone.0067323)
      - JBI Score: 100. [See report](jbi-reports/Nyberg%20et%20al.%20(2013).md)

### Marital status
 - **Relative risk:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States: 2021. Table 1, [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table2.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Race
 - **Relative risk:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**
    - USA Facts. (2021). US population by year, race, age, ethnicity, & more. <https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01>

### Sedentary behaviour
 - **Relative risk and Prevalence:**
    - Vallance, J. K., Winkler, E. A. H., Gardiner, P. A., Healy, G. N., Lynch, B. M., & Owen, N. (2011). Associations of objectively-assessed physical activity and sedentary time with depression: NHANES (2005–2006). *Preventive Medicine*, 53(4–5), 284–288. [DOI: 10.1016/j.ypmed.2011.07.013](https://doi.org/10.1016/j.ypmed.2011.07.013)
      - JBI Score: 100. [See report](jbi-reports/Vallance%20et%20al.%20(2011).md)

### Sleep
 - **Relative risk:**
    - Zhai, L., Zhang, H., & Zhang, D. (2015). SLEEP DURATION AND DEPRESSION AMONG ADULTS: A META-ANALYSIS OF PROSPECTIVE STUDIES. *Depression and Anxiety*, 32(9), 664–670 . [DOI: 10.1002/da.22386](https://doi.org/10.1002/da.22386)
      - JBI Score: 100. [See report](jbi-reports/Zhai%20et%20al.%20(2015).md) 

 - **Prevalence:**
    - Statistics Canada. (2022). Sleep behaviours among Canadian adults: Findings from the 2020 Canadian Community Health Survey healthy living rapid response module. Government of Canada. [DOI: 10.25318/82-003-X202200300001-ENG](  https://doi.org/10.25318/82-003-X202200300001-ENG)
      - JBI Score: 100. [See report](jbi-reports/Wang%20et%20al.%20(2022).md)  

### Smoking - cigarettes
 - **Relative risk and Prevalence:**
    - Mojtabai, R., & Crum, R. M. (2013). Cigarette Smoking and Onset of Mood and Anxiety Disorders. *American Journal of Public Health*, 103(9), 1656–1665. [DOI: 10.2105/ajph.2012.300911](https://doi.org/10.2105/ajph.2012.300911)
      - JBI Score: 100. [See report](jbi-reports/Mojtabai%20%26%20Crum%20(2013).md)

## Diabetes - Type 2
### Adiponectin
 - **Relative risk:**
    - Duncan, B. B., Schmidt, M. I., Pankow, J. S., Bang, H., Couper, D., Ballantyne, C. M., ... Heiss, G. (2004) Adiponectin and the Development of Type 2 Diabetes. *Diabetes*, 53(9), 2473-2478. [DOI: 10.2337/diabetes.53.9.2473](https://doi.org/10.2337/diabetes.53.9.2473)
      - JBI Score: 100. [See report](jbi-reports/Duncan%20et%20al.%20(2004).md)

 - **Prevalence:**
    - Gardener, H., Crisby, M., Sjoberg, C., Hudson, B., Goldberg, R., Mendez, A. J., Wright, C. B., Rundek, T., Elkind, M. S. V., & Sacco, R. L. (2013). Serum Adiponectin in Relation to Race–Ethnicity and Vascular Risk Factors in the Northern Manhattan Study. *Metabolic Syndrome and Related Disorders*, 11(1), 46–55. [DOI: 10.1089/met.2012.0065](https://doi.org/10.1089/met.2012.0065)
      - JBI Score: 100. [See report](jbi-reports/Gardener%20et%20al.%20(2013).md)

### Age
 - **Relative risk:**
    - Centers for Disease Control and Prevention. (2021). Prevalence of both diagnosed and undiagnosed diabetes. [https://www.cdc.gov/diabetes/php/data-research/index.html](https://www.cdc.gov/diabetes/php/data-research/index.html)
  
 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### BMI
 - **Relative risk:**
    - Abdullah, A., Peeters, A., de Courten, M., & Stoelwinder, J. (2010) The magnitude of association between overweight and obesity and the risk of diabetes: A meta-analysis of prospective cohort studies. *Diabetes Research and Clinical Practice*, 89(3), 309-319. [DOI: 10.1016/j.diabres.2010.04.012](https://doi.org/10.1016/j.diabres.2010.04.012)
      - JBI Score: 100. [See report](jbi-reports/Abdullah%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Flegal, K. M., Carroll, M. D., Kit, B. K., & Ogden, C. L. (2012). Prevalence of Obesity and Trends in the Distribution of Body Mass Index Among US Adults, 1999-2010. *JAMA*, 307(5), 491. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)
      - JBI Score: 94.4. [See report](jbi-reports/Flegal%20et%20al.%20(2012).md)

### C-reactive protein (CRP)
 - **Relative risk:**
    - Wang, X., Bao, W., Liu, J., OuYang, Y.-Y., Wang, D., Rong, S., Xiao, X., Shan, Z.-L., Zhang, Y., Yao, P., & Liu, L.-G. (2012). Inflammatory Markers and Risk of Type 2 Diabetes. *Diabetes Care*, 36(1), 166–175. [DOI: 10.2337/dc12-0702](https://doi.org/10.2337/dc12-0702) 
      - JBI Score: 100. [See report](jbi-reports/Wang%20et%20al.%20(2012).md)

 - **Prevalence:**
    - Khera, A., McGuire, D. K., Murphy, S. A., Stanek, H. G., Das, S. R., Vongpatanasin, W., Wians, F. H., Jr, Grundy, S. M., & de Lemos, J. A. (2005). Race and Gender Differences in C-Reactive Protein Levels. *Journal of the American College of Cardiology*, 46(3), 464–469. [DOI: 10.1016/j.jacc.2005.04.051](https://doi.org/10.1016/j.jacc.2005.04.051)
      - JBI Score: 100. [See report](jbi-reports/Khera%20et%20al.%20(2005).md)

### Family history
 - **Relative risk:**
    - The InterAct Consortium. (2013). The link between family history and risk of type 2 diabetes is not explained by anthropometric, lifestyle or genetic risk factors: the EPIC-InterAct study. *Diabetologia*, 56(1), 60–69. [DOI: 10.1007/s00125-012-2715-x](https://doi.org/10.1007/s00125-012-2715-x)
      - JBI Score: 100. [See report](jbi-reports/InterAct%20Consortium%20(2013).md)

 - **Prevalence:**
    - Valdez, R., Yoon, P. W., Liu, T., & Khoury, M. J. (2007) Family History and Prevalence of Diabetes in the U.S. Population. *Diabetes Care*, 30(10), 2517-2522. [DOI: 10.2337/dc07-0720](https://doi.org/10.2337/dc07-0720)
      - JBI Score: 100. [See report](jbi-reports/Valdez%20et%20al.%20(2007).md)

### Gestational diabetes
 - **Relative risk:**
    - Vounzoulaki, E., Khunti, K., Abner, S. C., Tan, B. K., Davies, M. J., & Gillies, C. L. (2020). Progression to type 2 diabetes in women with a known history of gestational diabetes: systematic review and meta-analysis. *BMJ*, m1361. [DOI: 10.1136/bmj.m1361](https://doi.org/10.1136/bmj.m1361)
      - JBI Score: 100. [See report](jbi-reports/Vounzoulaki%20et%20al.%20(2020).md)

 - **Prevalence:**
    - Zhu, Y., & Zhang, C. (2016). Prevalence of Gestational Diabetes and Risk of Progression to Type 2 Diabetes: a Global Perspective. *Current Diabetes Reports*, 16(1). [DOI: 10.1007/s11892-015-0699-x](https://doi.org/10.1007/s11892-015-0699-x)
      - JBI Score: 100. [See report](jbi-reports/Zhu%20%26%20Zhang%20(2016).md)

### Cholesterol - HDL
 - **Relative risk:**
    - Montonen, J., Drogan, D., Joost, H.-G., Boeing, H., Fritsche, A., Schleicher, E., Schulze, M. B., & Pischon, T. (2010). Estimation of the contribution of biomarkers of different metabolic pathways to risk of type 2 diabetes. *European Journal of Epidemiology*, 26(1), 29–38 . [DOI: 10.1007/s10654-010-9539-0](https://doi.org/10.1007/s10654-010-9539-0)
      - JBI Score: 100. [See report](jbi-reports/Montonen%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Bruckert, E. (2006). Epidemiology of low HDL-cholesterol: results of studies and surveys. *European Heart Journal Supplements*, 8(suppl_F), F17–F22. [DOI: 10.1093/eurheartj/sul036](https://doi.org/10.1093/eurheartj/sul036)
      - JBI Score: 100. [See report](jbi-reports/Bruckert%20(2006).md)

### Hemoglobin A1c
 - **Relative risk:**
    - Inoue, K., Matsumoto, M., & Akimoto, K. (2008) Fasting plasma glucose and HbA<sub>1c</sub> as risk factors for Type 2 diabetes. *Diabetic Medicine*, 25(10), 1157-1163. [DOI: 10.1111/j.1464-5491.2008.02572.x](https://doi.org/10.1111/j.1464-5491.2008.02572.x)
      - JBI Score: 100. [See report](jbi-reports/Inoue%20et%20al.%20(2008).md)

 - **Prevalence:**
      - Carson, A. P., Fox, C. S., McGuire, D. K., Levitan, E. B., Laclaustra, M., Mann, D. M., & Muntner, P. (2010). Low Hemoglobin A1c and Risk of All-Cause Mortality Among US Adults Without Diabetes. *Circulation: Cardiovascular Quality and Outcomes*, 3(6), 661–667. [DOI: 10.1161/circoutcomes.110.957936](https://doi.org/10.1161/circoutcomes.110.957936)
        - JBI Score: 95.5. [See report](jbi-reports/Carson%20et%20al.%20(2010).md)

### Hepatitis C
 - **Relative risk:**
    - Fabiani, S., Fallahi, P., Ferrari, S. M., Miccoli, M., & Antonelli, A. (2018) Hepatitis C virus infection and development of type 2 diabetes mellitus: Systematic review and meta-analysis of the literature. *Reviews in Endocrine and Metabolic Disorders*, 19(4), 405-420. [DOI: 10.1007/s11154-017-9440-1](https://doi.org/10.1007/s11154-017-9440-1)
      - JBI Score: 86.5. [See report](jbi-reports/Fabiani%20et%20al.%20(2018).md)

 - **Prevalence:**
    - Rosenberg, E. S., Rosenthal, E. M., Hall, E. W., Barker, L., Hofmeister, M. G., Sullivan, P. S., Dietz, P., Mermin, J., & Ryerson, A. B. (2018). Prevalence of Hepatitis C Virus Infection in US States and the District of Columbia, 2013 to 2016. *JAMA Network Open*, 1(8), e186371. [DOI: 10.1001/jamanetworkopen.2018.6371](https://doi.org/10.1001/jamanetworkopen.2018.6371)
      - JBI Score: 100. [See report](jbi-reports/Rosenberg%20et%20al.%20(2018).md)

### Hypertension
 - **Relative risk:**
    - Gress, T. W., Nieto, F. J., Shahar, E., Wofford, M. R., & Brancati, F. L. (2000). Hypertension and Antihypertensive Therapy as Risk Factors for Type 2 Diabetes Mellitus. *New England Journal of Medicine*, 342(13), 905–912. [DOI: 10.1056/nejm200003303421301](https://doi.org/10.1056/nejm200003303421301)
      - JBI Score: 90.9. [See report](jbi-reports/Gress%20et%20al.%20(2000).md)

 - **Prevalence:**
    - Booth, J. N., III, Li, J., Zhang, L., Chen, L., Muntner, P., & Egan, B. (2017). Trends in Prehypertension and Hypertension Risk Factors in US Adults. *Hypertension*, 70(2), 275–284. [DOI: 10.1161/hypertensionaha.116.09004](https://doi.org/10.1161/hypertensionaha.116.09004)
      - JBI Score: 100. [See report](jbi-reports/Booth%20et%20al.%20(2017).md)

### Interleukin 6 (IL-6)
 - **Relative risk and prevalence:**
    - Bertoni, A. G., Burke, G. L., Owusu, J. A., Carnethon, M. R., Vaidya, D., Barr, R. G., Jenny, N. S., Ouyang, P., & Rotter, J. I. (2010). Inflammation and the Incidence of Type 2 Diabetes. *Diabetes Care*, 33(4), 804–810 . [DOI: 10.2337/dc09-1679](https://doi.org/10.2337/dc09-1679)
      - JBI Score: 90.9. [See report](jbi-reports/Bertoni%20et%20al.%20(2010).md)

### Physical activity
 - **Relative risk:**
    - Smith, A. D., Crippa, A., Woodcock, J., & Brage, S. (2016). Physical activity and incident type 2 diabetes mellitus: a systematic review and dose–response meta-analysis of prospective cohort studies. *Diabetologia*, 59(12), 2527–2545. [DOI: 10.1007/s00125-016-4079-0](https://doi.org/10.1007/s00125-016-4079-0)
      - JBI Score: 86.4. [See report](jbi-reports/Smith%20et%20al.%20(2016).md)

 - **Prevalence:**
    - Matthews, C. E., Moore, S. C., Arem, H., Cook, M. B., Trabert, B., Håkansson, N., Larsson, S. C., Wolk, A., Gapstur, S. M., Lynch, B. M., Milne, R. L., Freedman, N. D., Huang, W.-Y., Berrington de Gonzalez, A., Kitahara, C. M., Linet, M. S., Shiroma, E. J., Sandin, S., Patel, A. V., & Lee, I.-M. (2020). Amount and Intensity of Leisure-Time Physical Activity and Lower Cancer Risk. *Journal of Clinical Oncology*, 38(7), 686–697. [DOI: 10.1200/jco.19.02407](https://doi.org/10.1200/jco.19.02407)
      - JBI Score: 86.4. [See report](jbi-reports/Matthews%20et%20al.%20(2020).md)

### Race
 - **Relative risk:**
    - Menke, A., Casagrande, S., Geiss, L., & Cowie, C. C. (2015) Prevalence of and Trends in Diabetes Among Adults in the United States, 1988-2012. *JAMA*, 314(10), 1021. [DOI: 10.1001/jama.2015.10029](https://doi.org/10.1001/jama.2015.10029)
      - JBI Score: 100. [See report](jbi-reports/Menke%20et%20al.%20(2015).md)

 - **Prevalence:**
    - USAFacts. (2021). US population by year, race, age, ethnicity, & more. https://USAFacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01

### Sedentary behaviour
 - **Relative risk:**
    - Grøntved, A., & Hu, F. B. (2011) Television Viewing and Risk of Type 2 Diabetes, Cardiovascular Disease, and All-Cause Mortality. *JAMA*, 305(23), 2448. [DOI: 10.10012Fjama.2011.812](https://doi.org/10.10012Fjama.2011.812)
      - JBI Score: 86.4. [See report](jbi-reports/Grontved%20%26%20Hu%20(2011).md)

 - **Prevalence:**
    - Ford, E. S., Schulze, M. B., Körö, J., Pischon, T., Bergmann, M. M., & Boeing, H. (2010). Television watching and incident diabetes: Findings from the European Prospective Investigation into Cancer and Nutrition–Potsdam Study. *Journal of Diabetes*, 2(1), 23–27. [DOI: 10.1111/j.1753-0407.2009.00047.x](https://doi.org/10.1111/j.1753-0407.2009.00047.x)
      - JBI Score: 95.5. [See report](jbi-reports/Ford%20et%20al.%20(2010).md)

### Sleep
 - **Relative risk:**
    - Cappuccio, F. P., D'Elia, L., Strazzullo, P., & Miller, M. A. (2010) Quantity and Quality of Sleep and Incidence of Type 2 Diabetes. *Diabetes Care*, 33(2), 414-420. [DOI: 10.2337/dc09-1124](https://doi.org/10.2337/dc09-1124)
      - JBI Score: 86.4. [See report](jbi-reports/Cappuccio%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Statistics Canada. (2022). Sleep behaviours among Canadian adults: Findings from the 2020 Canadian Community Health Survey healthy living rapid response module. Government of Canada. [https://doi.org/10.25318/82-003-X202200300001-ENG](https://doi.org/10.25318/82-003-X202200300001-ENG)
      - JBI Score: 100. [See report](jbi-reports/Wang%20et%20al.%20(2022).md)

### Sleep - difficulty initiating sleep
 - **Relative risk:**
    - Cappuccio, F. P., D'Elia, L., Strazzullo, P., & Miller, M. A. (2010) Quantity and Quality of Sleep and Incidence of Type 2 Diabetes. *Diabetes Care*, 33(2), 414-420. [DOI: 10.2337/dc09-1124](https://doi.org/10.2337/dc09-1124)
      - JBI Score: 86.4. [See report](jbi-reports/Cappuccio%20et%20al.%20(2010).md)

  - **Prevalence:**
    - Hayashino, Y., Fukuhara, S., Suzukamo, Y., Okamura, T., Tanaka, T., & Ueshima, H. (2007). Relation between sleep quality and quantity, quality of life, and risk of developing diabetes in healthy workers in Japan: the High-risk and Population Strategy for Occupational Health Promotion (HIPOP-OHP) Study. *BMC Public Health*, 7(1). [DOI: 10.1186/1471-2458-7-129](https://doi.org/10.1186/1471-2458-7-129)
      - JBI Score: 100. [See report](jbi-reports/Hayasihno%20et%20al.%20(2007).md)

### Sleep - difficulty maintaining sleep
 - **Relative risk:**
    - Cappuccio, F. P., D'Elia, L., Strazzullo, P., & Miller, M. A. (2010) Quantity and Quality of Sleep and Incidence of Type 2 Diabetes. *Diabetes Care*, 33(2), 414-420. [DOI: 10.2337/dc09-1124](https://doi.org/10.2337/dc09-1124)
      - JBI Score: 86.4. [See report](jbi-reports/Cappuccio%20et%20al.%20(2010).md)
  - **Prevalence:**
    - Meisinger, C., Heier, M., & Loewel, H. (2005). Sleep disturbance as a predictor of type 2 diabetes mellitus in men and women from the general population. *Diabetologia*, 48(2), 235–241. [DOI: 10.1007/s00125-004-1634-x](https://doi.org/10.1007/s00125-004-1634-x)
      - JBI Score: 100. [See report](jbi-reports/Meisinger%20et%20al.%20(2005).md)

### Sleep apnea
 - **Relative risk:**
    - Wang, X., Bi, Y., Zhang, Q., & Pan, F. (2013) Obstructive sleep apnoea and the risk of type 2 diabetes: A meta‐analysis of prospective cohort studies. *Respirology*, 18(1), 140-146. [DOI: 10.1111/j.1440-1843.2012.02267.x](https://doi.org/10.1111/j.1440-1843.2012.02267.x)
      - JBI Score: 86.4. [See report](jbi-reports/Wang%20et%20al.%20(2013).md)

 - **Prevalence:**
    - Kendzerska, T., Gershon, A. S., Hawker, G., Tomlinson, G., & Leung, R. S. (2014). Obstructive Sleep Apnea and Incident Diabetes. A Historical Cohort Study. *American Journal of Respiratory and Critical Care Medicine*, 190(2), 218–225. [DOI: 10.1164/rccm.201312-2209oc](https://doi.org/10.1164/rccm.201312-2209oc)
      - JBI Score: 100. [See report](jbi-reports/Kendzerska%20et%20al.%20(2014).md)

### Smoking - cigarettes
 - **Relative risk:**
    - Willi, C., Bodenmann, P., Ghali, W. A., Faris, P. D., & Cornuz, J. (2007). Active Smoking and the Risk of Type 2 Diabetes. *JAMA*, 298(22), 2654. [DOI: 10.1001/jama.298.22.2654](https://doi.org/10.1001/jama.298.22.2654)
      - JBI Score: 100. [See report](jbi-reports/Willi%20et%20al.%20(2007).md)

 - **Prevalence:**
    - Freedman, N. D., Silverman, D. T., Hollenbeck, A. R., Schatzkin, A., & Abnet, C. C. (2011). Association Between Smoking and Risk of Bladder Cancer Among Men and Women. *JAMA*, 306(7), 737. [DOI: 10.1001/jama.2011.1142](https://doi.org/10.1001/jama.2011.1142)
      - JBI Score: 95.5. [See report](jbi-reports/Freedman%20et%20al.%20(2011).md)

### Sugar sweetened beverages
 - **Relative risk:**
    - Imamura, F., O’Connor, L., Ye, Z., Mursu, J., Hayashino, Y., Bhupathiraju, S. N., & Forouhi, N. G. (2015). Consumption of sugar sweetened beverages, artificially sweetened beverages, and fruit juice and incidence of type 2 diabetes: systematic review, meta-analysis, and estimation of population attributable fraction. *BMJ*, h3576. [DOI: 10.1136/bmj.h3576](https://doi.org/10.1136/bmj.h3576)
      - JBI Score: 86.4. [See report](jbi-reports/Imamura%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Boersma, P., Black, L. I., & Ward, B. W. (2017). Prevalence of multiple chronic conditions among U.S. adults. NCHS Data Brief No. 270. National Center for Health Statistics. [https://www.cdc.gov/nchs/data/databriefs/db270.pdf](https://www.cdc.gov/nchs/data/databriefs/db270.pdf)

### Waist circumference
 - **Relative risk:**
    - Feller, S., Boeing, H., & Pischon, T. (2010). Body Mass Index, Waist Circumference, and the Risk of Type 2 Diabetes Mellitus. *Deutsches Ärzteblatt international*. [DOI: 10.3238/arztebl.2010.0470](https://doi.org/10.3238/arztebl.2010.0470)
      - JBI Score: 90.9. [See report](jbi-reports/Feller%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Public Health Agency of Canada. (2020). Obesity in Canada: A joint report from the Public Health Agency of Canada and the Canadian Institute for Health Information. Government of Canada. [https://www.canada.ca/en/public-health/services/publications/healthy-living/obesity-statistics-canada.html](https://www.canada.ca/en/public-health/services/publications/healthy-living/obesity-statistics-canada.html)

### Whole grain consumption
 - **Relative risk:**
    - Aune, D., Norat, T., Romundstad, P., & Vatten, L. J. (2013). Whole grain and refined grain consumption and the risk of type 2 diabetes: A systematic review and dose–response meta-analysis of cohort studies. *European Journal of Epidemiology*, 28(11), 845-858. [DOI: 10.1007/s10654-013-9852-5](https://doi.org/10.1007/s10654-013-9852-5)
      - JBI Score: 86.4. [See report](jbi-reports/Aune%20et%20al.%20(2013).md)

 - **Prevalence:**
    - O’Neil, C. E., Nicklas, T. A., Zanovec, M., & Cho, S. (2010). Whole-Grain Consumption Is Associated with Diet Quality and Nutrient Intake in Adults: The National Health and Nutrition Examination Survey, 1999-2004. *Journal of the American Dietetic Association*, 110(10), 1461–1468. [DOI: 10.1016/j.jada.2010.07.012](https://doi.org/10.1016/j.jada.2010.07.012)
      - JBI Score: 100. [See report](jbi-reports/O_Neil%20et%20al.%20(2010).md)

## Generalized anxiety disorder

### Adverse childhood experiences
 - **Relative risk:**
    - Whitaker, R. C., Dearth-Wesley, T., Herman, A. N., Block, A. E., Holderness, M. H., Waring, N. A., & Oakes, J. M. (2021). The interaction of adverse childhood experiences and gender as risk factors for depression and anxiety disorders in US adults: a cross-sectional study. *BMC Public Health*, 21(1). [DOI: 10.1186/s12889-021-12058-z](https://doi.org/10.1186/s12889-021-12058-z)
      - JBI Score: 87.5. [See report](jbi-reports/Whitaker%20et%20al.%20(2021).md)

 - **Prevalence:**
    - Giano, Z., Wheeler, D. L., & Hubach, R. D. (2020). The frequencies and disparities of adverse childhood experiences in the U.S. *BMC Public Health*, 20(1). [DOI: 10.1186/s12889-020-09411-z](https://doi.org/10.1186/s12889-020-09411-z)
      - JBI Score: 100. [See report](jbi-reports/Giano%20et%20al.%20(2020).md)

### Anxiety
 - **Relative risk:**
    - Beesdo, K., Pine, D. S., Lieb, R., & Wittchen, H.-U. (2010). Incidence and Risk Patterns of Anxiety and Depressive Disorders and Categorization of Generalized Anxiety Disorder. *Archives of General Psychiatry*, 67(1), 47  . [DOI: 10.1001/archgenpsychiatry.2009.177](https://doi.org/10.1001/archgenpsychiatry.2009.177)
      - JBI Score: 100. [See report](jbi-reports/Beesdo%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Alonso, J., Angermeyer, M. C., Bernert, S., Bruffaerts, R., Brugha, T. S., Bryson, H., de Girolamo, G., de Graaf, R., Demyttenaere, K., Gasquet, I., Haro, J. M., Katz, S. J., Kessler, R. C., Kovess, V., Lépine, J. P., Ormel, J., Polidori, G., Russo, L. J., … Vollebergh, W. A. M. (2004). Prevalence of mental disorders in Europe: results from the European Study of the Epidemiology of Mental Disorders (ESEMeD) project. *Acta Psychiatrica Scandinavica*, 109(s420), 21–27. [DOI: 10.1111/j.1600-0047.2004.00327.x](https://doi.org/10.1111/j.1600-0047.2004.00327.x)
      - JBI Score: 88.9 [See report](jbi-reports/Alonso%20et%20al.%20(2004).md)

### Depression
 - **Relative risk:**
    - Beesdo, K., Pine, D. S., Lieb, R., & Wittchen, H.-U. (2010). Incidence and Risk Patterns of Anxiety and Depressive Disorders and Categorization of Generalized Anxiety Disorder. *Archives of General Psychiatry*, 67(1), 47  . [DOI: 10.1001/archgenpsychiatry.2009.177](https://doi.org/10.1001/archgenpsychiatry.2009.177)
      - JBI Score: 100. [See report](jbi-reports/Beesdo%20et%20al.%20(2010).md)

 - **Prevalence:**
    - Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., & Grant, B. F. (2018). Epidemiology of Adult DSM-5 Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
      - JBI Score: 100. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)   

### Family history
 - **Relative risk and prevalence:**
    - Beesdo, K., Pine, D. S., Lieb, R., & Wittchen, H.-U. (2010). Incidence and Risk Patterns of Anxiety and Depressive Disorders and Categorization of Generalized Anxiety Disorder. *Archives of General Psychiatry*, 67(1), 47  . [DOI: 10.1001/archgenpsychiatry.2009.177](https://doi.org/10.1001/archgenpsychiatry.2009.177)
      - JBI Score: 100. [See report](jbi-reports/Beesdo%20et%20al.%20(2010).md)

### Job strain
 - **Relative risk and prevalence:**
    - Niedhammer, I., Malard, L., & Chastang, J.-F. (2015). Occupational factors and subsequent major depressive and generalized anxiety disorders in the prospective French national SIP study. BMC Public Health, 15(1). [DOI: 10.1186/s12889-015-1559-y](https://doi.org/10.1186/s12889-015-1559-y)
      - JBI Score: 100. [See report](jbi-reports/Niedhammer%20et%20al.%20(2015).md) 

### Physical activity
 - **Relative risk and prevalence:**
    - Sanchez-Villegas, A., Ara, I., Guillen-Grima, F., Bes-Rastrollo, M., Varo-Cenarruzabeitia, J. J., & Martinez-Gonzalez, M. A. (2008). Physical Activity, Sedentary Index, and Mental Disorders in the SUN Cohort Study. *Medicine &amp; Science in Sports &amp; Exercise*, 40(5), 827–834. [DOI: 10.1249/mss.0b013e31816348b9](https://doi.org/10.1249/mss.0b013e31816348b9)
      - JBI Score: 95.5. [See report](jbi-reports/Sanchez-Villegas%20et%20al.%20(2008).md)

### Sedentary behaviour
 - **Relative risk:**
    - Allen, M. S., Walter, E. E., & Swann, C. (2019). Sedentary behaviour and risk of anxiety: A systematic review and meta-analysis. *Journal of Affective Disorders*, 242, 5–13. [DOI: 10.1016/j.jad.2018.08.081](https://doi.org/10.1016/j.jad.2018.08.081)
      - JBI Score: 100. [See report](jbi-reports/Allen%20et%20al.%20(2019).md)

 - **Prevalence:**
    - Vallance, J. K., Winkler, E. A. H., Gardiner, P. A., Healy, G. N., Lynch, B. M., & Owen, N. (2011). Associations of objectively-assessed physical activity and sedentary time with depression: NHANES (2005–2006). *Preventive Medicine*, 53(4–5), 284–288. [DOI: 10.1016/j.ypmed.2011.07.013](https://doi.org/10.1016/j.ypmed.2011.07.013)
      - JBI Score: 100. [See report](jbi-reports/Vallance%20et%20al.%20(2011).md)

### Smoking - cigarettes
 - **Relative risk and prevalence:**
    - Mojtabai, R., & Crum, R. M. (2013) Cigarette Smoking and Onset of Mood and Anxiety Disorders. *American Journal of Public Health*, 103(9), 1656-1665. [DOI: 10.21052FAJPH.2012.300911](https://doi.org/10.21052FAJPH.2012.300911)
      - JBI Score: 100. [See report](jbi-reports/Mojtabai%20%26%20Crum%20(2013).md)

## Hypertension
### Age
 - **Relative risk:**
    - Muntner, P., Jaeger, B. C., Hardy, S. T., Foti, K., Reynolds, K., Whelton, P. K., & Bowling, C. B. (2021). Age-Specific Prevalence and Factors Associated With Normal Blood Pressure Among US Adults. *American Journal of Hypertension*, 35(4), 319–327. [DOI: 10.1093/ajh/hpab154](https://doi.org/10.1093/ajh/hpab154)
      - JBI Score: 100. [See report](jbi-reports/Muntner%20et%20al.%20(2021).md) 

- **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Alcohol
 - **Relative risk and prevalence:**
    - Briasoulis, A., Agarwal, V., & Messerli, F. H. (2012). Alcohol Consumption and the Risk of Hypertension in Men and Women: A Systematic Review and Meta‐Analysis. *The Journal of Clinical Hypertension*, 14(11), 792–798. [DOI: 10.1111/jch.12008](https://doi.org/10.1111/jch.12008)
      - JBI Score: 86.4. [See report](jbi-reports/Briasoulis%20et%20al.%20(2012).md)

### BMI
 - **Relative risk:**
    - Hu, G., Barengo, N. C., Tuomilehto, J., Lakka, T. A., Nissinen, A., & Jousilahti, P. (2004). Relationship of Physical Activity and Body Mass Index to the Risk of Hypertension: A Prospective Study in Finland. *Hypertension*, 43(1), 25–30. [DOI: 10.1161/01.hyp.0000107400.72456.19](https://doi.org/10.1161/01.hyp.0000107400.72456.19)
      - JBI Score: 90.9. [See report](jbi-reports/Hu%20et%20al.%20(2004).md)

 - **Prevalence:**
    - Flegal, K. M., Carroll, M. D., Kit, B. K., & Ogden, C. L. (2012). Prevalence of Obesity and Trends in the Distribution of Body Mass Index Among US Adults, 1999-2010. *JAMA*, 307(5), 491. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)
      - JBI Score: 94.4. [See report](jbi-reports/Flegal%20et%20al.%20(2012).md)

### Family history
 - **Relative risk and prevalence:**
    - Igarashi, R., Fujihara, K., Heianza, Y., Ishizawa, M., Kodama, S., Saito, K., Hara, S., Hanyu, O., Honda, R., Tsuji, H., Arase, Y., & Sone, H. (2016). Impact of individual components and their combinations within a family history of hypertension on the incidence of hypertension. *Medicine*, 95(38), e4564. [DOI: 10.1097/md.0000000000004564](https://doi.org/10.1097/md.0000000000004564)
      - JBI Score: 100. [See report](jbi-reports/Igarashi%20et%20al.%20(2016).md)

### Fruit and vegetable consumption
 - **Relative risk:**
    - Li, B., Li, F., Wang, L., & Zhang, D. (2016). Fruit and Vegetables Consumption and Risk of Hypertension: A Meta‐Analysis. *The Journal of Clinical Hypertension*, 18(5), 468–476. [DOI: 10.1111/jch.12777](https://doi.org/10.1111/jch.12777)
      - JBI Score: 90.9. [See report](jbi-reports/Li%20et%20al.%20(2016).md)

 - **Prevalence:**
   - Miller, V., Mente, A., Dehghan, M., Rangarajan, S., Zhang, X., Swaminathan, S., Dagenais, G., Gupta, R., Mohan, V., Lear, S., Bangdiwala, S. I., Schutte, A. E., Wentzel-Viljoen, E., Avezum, A., Altuntas, Y., Yusoff, K., Ismail, N., Peer, N., Chifamba, J., … Mapanga, R. (2017). Fruit, vegetable, and legume intake, and cardiovascular disease and deaths in 18 countries (PURE): a prospective cohort study. *The Lancet*, 390(10107), 2037–2049. [DOI: 10.1016/s0140-6736(17)32253-5](https://doi.org/10.1016/s0140-6736(17)32253-5)
      - JBI Score: 95.5. [See report](jbi-reports/Miller%20et%20al.%20(2017).md)

### Oral contraceptive use
 - **Relative risk:**
    - Liu, H., Yao, J., Wang, W., & Zhang, D. (2017). Association between duration of oral contraceptive use and risk of hypertension: A meta‐analysis. *The Journal of Clinical Hypertension*, 19(10), 1032–1041. [DOI: 10.1111/jch.13042](https://doi.org/10.1111/jch.13042)
      - JBI Score: 86.4. [See report](jbi-reports/Liu%20et%20al.%20(2017).md)

 - **Prevalence:**
   - Daniels, K., & Abma, J. C. (2020). Current Contraceptive Status Among Women Aged 15-49: United States, 2017-2019. NCHS data brief. National Center for Health Statistics. [https://www.cdc.gov/nchs/products/databriefs/db388.htm](https://www.cdc.gov/nchs/products/databriefs/db388.htm)

### Physical activity
 - **Relative risk and prevalence:**
    - Hu, G., Barengo, N. C., Tuomilehto, J., Lakka, T. A., Nissinen, A., & Jousilahti, P. (2004). Relationship of Physical Activity and Body Mass Index to the Risk of Hypertension: A Prospective Study in Finland. *Hypertension*, 43(1), 25–30. [DOI: 10.1161/01.hyp.0000107400.72456.19](https://doi.org/10.1161/01.hyp.0000107400.72456.19)
      - JBI Score: 90.9. [See report](jbi-reports/Hu%20et%20al.%20(2004).md)

### Premature birth
 - **Relative risk and prevalence:**
    - Crump, C., Sundquist, J., & Sundquist, K. (2019). Risk of hypertension into adulthood in persons born prematurely: a national cohort study. *European Heart Journal*, 41(16), 1542–1550. [DOI: 10.1093/eurheartj/ehz904](https://doi.org/10.1093/eurheartj/ehz904)
      - JBI Score: 95.5. [See report](jbi-reports/Crump%20et%20al.%20(2019).md)

### Race
 - **Relative risk:**
    - Bundy, J. D., Mills, K. T., Chen, J., Li, C., Greenland, P., & He, J. (2018). Estimating the Association of the 2017 and 2014 Hypertension Guidelines With Cardiovascular Events and Deaths in US Adults. *JAMA Cardiology*, 3(7), 572. [DOI: 10.1001/jamacardio.2018.1240](https://doi.org/10.1001/jamacardio.2018.1240)
      - JBI Score: 87.5. [See report](jbi-reports/Bundy%20et%20al.%20(2018).md)

 - **Prevalence:**
   - USAFacts. (2021). US population by year, race, age, ethnicity, & more. https://usafacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01  

### Sleep
 - **Relative risk:**
    - Li, H., Ren, Y., Wu, Y., & Zhao, X. (2018). Correlation between sleep duration and hypertension: a dose-response meta-analysis. *Journal of Human Hypertension*, 33(3), 218–228. [DOI: 10.1038/s41371-018-0135-1](https://doi.org/10.1038/s41371-018-0135-1)
      - JBI Score: 95.5. [See report](jbi-reports/Li%20et%20al.%20(2018).md)

 - **Prevalence:**
   - Song, Q., Liu, X., Wang, X., & Wu, S. (2016). Age- and gender-specific associations between sleep duration and incident hypertension in a Chinese population: the Kailuan study. Journal of Human Hypertension, 30(8), 503–507. [DOI: 10.1038/jhh.2015.118](https://doi.org/10.1038/jhh.2015.118)
      - JBI Score: 95.5. [See report](jbi-reports/Song%20et%20al.%20(2016).md)

### Sodium intake
 - **Relative risk:**
    - Filippini, T., Malavolti, M., Whelton, P. K., & Vinceti, M. (2022). Sodium Intake and Risk of Hypertension: A Systematic Review and Dose–Response Meta-analysis of Observational Cohort Studies. *Current Hypertension Reports*, 24(5), 133–144.[DOI: 10.1007/s11906-022-01182-9](https://doi.org/10.1007/s11906-022-01182-9)
      - JBI Score: 90.9. [See report](jbi-reports/Filippini%20et%20al.%20(2022).md)

 - **Prevalence:**
   - Ford, E. S., & Cooper, R. S. (1991). Risk factors for hypertension in a national cohort study. *Hypertension*, 18(5), 598–606. [DOI: 10.1161/01.hyp.18.5.598](https://doi.org/10.1161/01.hyp.18.5.598)
      - JBI Score: 90.9. [See report](jbi-reports/Ford%20%26%20Cooper%20(1991).md)

## Kidney cancer

### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). Available from: https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html

### BMI
 - **Relative risk:**
    - Adams, K. F., Leitzmann, M. F., Albanes, D., Kipnis, V., Moore, S. C., Schatzkin, A., & Chow, W.-H. (2008). Body Size and Renal Cell Cancer Incidence in a Large US Cohort Study. *American Journal of Epidemiology*, 168(3), 268–277.[DOI: 10.1093/aje/kwn122](https://doi.org/10.1093/aje/kwn122)
      - JBI Score: 100. [See report](jbi-reports/Adams%20et%20al.%20(2008).md)

 - **Prevalence:**
   - Statistics Canada. (2017). Measured adult body mass index (BMI) (World Health Organization classification), by age group and sex, Canada and provinces, Canadian Community Health Survey. Government of Canada . https://doi.org/10.25318/1310079401-ENG

### Diabetes - Type 2
 - **Relative risk:**
    - Bao, C., Yang, X., Xu, W., Luo, H., Xu, Z., Su, C., & Qi, X. (2013). Diabetes mellitus and incidence and mortality of kidney cancer: A meta-analysis. *Journal of Diabetes and Its Complications*, 27(4), 357–364. [DOI: 10.1016/j.jdiacomp.2013.01.004](https://doi.org/10.1016/j.jdiacomp.2013.01.004)
      - JBI Score: 95.5. [See report](jbi-reports/Bao%20et%20al.%20(2013).md)

 - **Prevalence:**
   - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. *Health Promotion and Chronic Disease Prevention in Canada*, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
      - JBI Score: 94.4. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk:**
    - Clague, J., Lin, J., Cassidy, A., Matin, S., Tannir, N. M., Tamboli, P., Wood, C. G., & Wu, X. (2009). Family History and Risk of Renal Cell Carcinoma: Results from a Case-Control Study and Systematic Meta-Analysis. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 18(3), 801–807. [DOI: 10.1158/1055-9965.epi-08-0601](https://doi.org/10.1158/1055-9965.epi-08-0601)
      - JBI Score: 95.5. [See report](jbi-reports/Clague%20et%20al.%20(2009).md)

 - **Prevalence:**
   - Pinsky, P. F. (2003). Reported Family History of Cancer in the Prostate, Lung, Colorectal, and Ovarian Cancer Screening Trial. *American Journal of Epidemiology*, 157(9), 792–799. [DOI: 10.1093/aje/kwg043](https://doi.org/10.1093/aje/kwg043)
      - JBI Score: 81.8. [See report](jbi-reports/Pinsky%20et%20al.%20(2003).md)

### Hepatitis C
 - **Relative risk:**
    - Gordon, S. C., Moonka, D., Brown, K. A., Rogers, C., Huang, M. A. Y., Bhatt, N., & Lamerato, L. (2010). Risk for Renal Cell Carcinoma in Chronic Hepatitis C Infection. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 19(4), 1066–1073. [DOI: 10.1158/1055-9965.epi-09-1275](https://doi.org/10.1158/1055-9965.epi-09-1275)
      - JBI Score: 100. [See report](jbi-reports/Gordon%20et%20al.%20(2010).md)

 - **Prevalence:**
   - Rosenberg, E. S., Rosenthal, E. M., Hall, E. W., Barker, L., Hofmeister, M. G., Sullivan, P. S., Dietz, P., Mermin, J., & Ryerson, A. B. (2018). Prevalence of Hepatitis C Virus Infection in US States and the District of Columbia, 2013 to 2016. *JAMA Network Open*, 1(8), e186371. [DOI: 10.1001/jamanetworkopen.2018.6371](https://doi.org/10.1001/jamanetworkopen.2018.6371)
      - JBI Score: 100. [See report](jbi-reports/Rosenberg%20et%20al.%20(2018).md)

### Hypertension
 - **Relative risk:**
    - Hidayat, K., Du, X., Zou, S.-Y., & Shi, B.-M. (2017). Blood pressure and kidney cancer risk. *Journal of Hypertension*, 35(7), 1333–1344. [DOI: 10.1097/hjh.0000000000001286](https://doi.org/10.1097/hjh.0000000000001286)
      - JBI Score: 100. [See report](jbi-reports/Hidayat%20et%20al.%20(2017).md)

 - **Prevalence:**
   - Booth, J. N., III, Li, J., Zhang, L., Chen, L., Muntner, P., & Egan, B. (2017). Trends in Prehypertension and Hypertension Risk Factors in US Adults. *Hypertension*, 70(2), 275–284. [DOI: 10.1161/hypertensionaha.116.09004](https://doi.org/10.1161/hypertensionaha.116.09004)
      - JBI Score: 100. [See report](jbi-reports/Booth%20et%20al.%20(2017).md)

### Kidney stones
 - **Relative risk:**
    - Cheungpasitporn, W., Thongprayoon, C., O’Corragain, O. A., Edmonds, P. J., Ungprasert, P., Kittanamongkolchai, W., & Erickson, S. B. (2014). The risk of kidney cancer in patients with kidney stones: a systematic review and meta-analysis. *QJM*, 108(3), 205–212. [DOI: 10.1093/qjmed/hcu195](https://doi.org/10.1093/qjmed/hcu195)
      - JBI Score: 100. [See report](jbi-reports/Cheungpasitporn%20et%20al.%20(2015).md)

 - **Prevalence:**
   - Stamatelou, K., & Goldfarb, D. S. (2023). Epidemiology of Kidney Stones. *Healthcare*, 11(3), 424. [DOI: 10.3390/healthcare11030424](https://doi.org/10.3390/healthcare11030424)

### Smoking - cigarettes
 - **Relative risk:**
    - Cumberbatch, M. G., Rota, M., Catto, J. W., & La Vecchia, C. (2016) The Role of Tobacco Smoke in Bladder and Kidney Carcinogenesis: A Comparison of Exposures and Meta-analysis of Incidence and Mortality Risks. *European Urology*, 70(3), 458-466. [DOI: 10.1016/j.eururo.2015.06.042](https://doi.org/10.1016/j.eururo.2015.06.042)
      - JBI Score: 86.4. [See report](jbi-reports/Cumberbatch%20et%20al.%20(2016).md)

 - **Prevalence:**
   - Government of Canada. (2021). Canadian Tobacco and Nicotine Survey (CTNS): 2020 detailed tables. Health Canada. https://www.canada.ca/en/health-canada/services/canadian-tobacco-nicotine-survey/2020-summary/2020-detailed-tables.html#t1

### Race
 - **Relative risk:**
   - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries.

 - **Prevalence:**
    - USAFacts. (2021). US population by year, race, age, ethnicity, & more. https://usafacts.org/data/topics/people-society/population-and-demographics/our-changing-population/?endDate=2021-01-01&startDate=2020-01-01

## Lung cancer
### Asbestos exposure
 - **Relative risk:**
    - Moon et al. (2013)
      - JBI Score: 86.4. [See report](jbi-reports/Moon%20et%20al.%20(2013).md)
    - Nielsen et al. (2014)
    - Fenton et al. (2023)
      - JBI Score: 88.9. [See report](jbi-reports/Fenton%20et%20al.%20(2023).md)

### BMI
 - **Relative risk:**
    - Zhu, H., & Zhang, S. (2018) Body mass index and lung cancer risk in never smokers: a meta-analysis. *BMC Cancer*, 18(1). [DOI: 10.1186/s12885-018-4543-y](https://doi.org/10.1186/s12885-018-4543-y)
      - JBI Score: 100.0. [See report](jbi-reports/Zhu%20%26%20Zhang%20(2018).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
    - [Lee et al. (2013)](http://dx.doi.org/10.1016/j.ejca.2013.02.025)
      - JBI Score: 95.5. [See report](jbi-reports/Lee%20et%20al.%20(2013).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
    - Cannon-Albright et al. (2019)
      - JBI Score: 81.8. [See report](jbi-reports/Cannon-Albright%20et%20al.%20(2019).md)
    - Matakidou, A., Eisen, T., & Houlston, R. S. (2005) Systematic review of the relationship between family history and lung cancer risk. *British Journal of Cancer*, 93(7), 825-833. [DOI: 10.1038/sj.bjc.6602769](https://doi.org/10.1038/sj.bjc.6602769)
      - JBI Score: 86.4. [See report](jbi-reports/Matakidou%20et%20al.%20(2005).md)

 - **Prevalence:**

### Inflammation and lung disease
 - **Relative risk:**
    - Ntritsos et al. (2022)
      - JBI Score: 100. [See report](jbi-reports/Ntritsos%20et%20al.%20(2022).md)
    - Littman et al. (2004)
      - JBI Score: 95.5. [See report](jbi-reports/Littman%20et%20al.%20(2004).md)
    - Zhang et al. (2017)
      - JBI Score: 86.4. [See report](jbi-reports/Zhang%20et%20al.%20(2017).md)
    - Miramontes et al. (2015)
      - JBI Score: 100.0. [See report](jbi-reports/Miramontes%20et%20al.%20(2015).md)
    - OReilly et al. (2023)
    - Brenner et al. (2012)
      - JBI Score: 86.4. [See report](jbi-reports/Brenner%20et%20al.%20(2012).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
    - Haiman et al. (2006)

 - **Prevalence:**

### Radiation therapy
 - **Relative risk:**
    - Taylor, D. P., Burt, R. W., Williams, M. S., Haug, P. J., & Cannon–Albright, L. A. (2010) Population-Based Family History–Specific Risks for Colorectal Cancer: A Constellation Approach. *Gastroenterology*, 138(3), 877-885. [DOI: 10.1053/j.gastro.2009.11.044](https://doi.org/10.1053/j.gastro.2009.11.044)
    - Lorigan et al. (2005)

 - **Prevalence:**

### Second-hand smoke
 - **Relative risk:**
    - [Levesque & Mischki (2021)](https://www.doi.org/10.25318/82-003-x202100200002-eng)
      - JBI Score: 100 [See report](jbi-reports/Levesque%20%26%20Mischki%20(2021).md)
    - Kim et al. (2015)
      - JBI Score: 86.4 [See report](jbi-reports/Kim%20et%20al.%20(2015).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
    - OKeeffe et al. (2018)
      - JBI Score: 100 [See report](jbi-reports/O'Keefe%20et%20al.%20(2018).md)

 - **Prevalence:**

## Osteoporosis
### Age
 - **Relative risk:**
    - Kanis, J. A., Johnell, O., Oden, A., De Laet, C., Dawson, A., & Jonsson, B. (2001) Ten Year Probabilities of Osteoporotic Fractures According to BMD and Diagnostic Thresholds. *Osteoporosis International*, 12(12), 989-995. [DOI: 10.1007/s001980170006](https://doi.org/10.1007/s001980170006)
      - JBI Score: 95.5 [See report](jbi-reports/Kanis%20et%20al.%20(2001).md)

 - **Prevalence:**

### Alcohol
 - **Relative risk:**
    - Berg, K. M., Kunins, H. V., Jackson, J. L., Nahvi, S., Chaudhry, A., Harris, K. A., ... Arnsten, J. H. (2008) Association Between Alcohol Consumption and Both Osteoporotic Fracture and Bone Density. *The American Journal of Medicine*, 121(5), 406-418. [DOI: 10.10162Fj.amjmed.2007.12.012](https://doi.org/10.10162Fj.amjmed.2007.12.012)
      - JBI Score: 100.0 [See report](jbi-reports/Berg%20et%20al.%20(2008).md)

### BMI
 - **Relative risk:**
    - De Laet, C., Kanis, J. A., Odén, A., Johanson, H., et al. (2005)
      - JBI Score: 86.4 [See report](jbi-reports/De%20Laet%20et%20al.%20(2005).md)

 - **Prevalence:**

### Breast cancer
 - **Relative risk:**
    - Lee, S., Yoo, J., Lee, Y., Park, J., Won, S., Yeom, J., ... Koo, K. (2020) Risk of Osteoporotic Fracture in Patients with Breast Cancer: Meta-Analysis. *Journal of Bone Metabolism*, 27(1), 27. [DOI: 10.110052Fjbm.2020.27.1.27](https://doi.org/10.110052Fjbm.2020.27.1.27)
      - JBI Score: 86.4 [See report](jbi-reports/Lee%20et%20al.%20(2020).md)

 - **Prevalence:**

### Celiac disease
 - **Relative risk:**
    - Heikkilä, K., Pearce, J., Mäki, M., & Kaukinen, K. (2015)
      - JBI Score: 86.4 [See report](jbi-reports/Heikkilä%20et%20al.%20(2015).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
    - Wang, J., You, W., Jing, Z., Wang, R., Fu, Z., & Wang, Y. (2016) Increased risk of vertebral fracture in patients with diabetes: a meta-analysis of cohort studies. *International Orthopaedics*, 40(6), 1299-1307. [DOI: 10.1007/s00264-016-3146-y](https://doi.org/10.1007/s00264-016-3146-y)

 - **Prevalence:**

### Epilepsy
 - **Relative risk:**
    - Vestergaard P. (2005)
      - JBI Score: 95.5 [See report](jbi-reports/Vestergaard%20(2005).md)

 - **Prevalence:**

### Family history of fractures
 - **Relative risk:**
    - Kanis, J., Johansson, H., Oden, A., Johnell, O., De Laet, C., Eisman, J., ... Tenenhouse, A. (2004) A family history of fracture and fracture risk: a meta-analysis. *Bone*, 35(5), 1029-1037. [DOI: 10.1016/j.bone.2004.06.017](https://doi.org/10.1016/j.bone.2004.06.017)
      - JBI Score: 81.8 [See report](jbi-reports/Kanis%20et%20al.%20(2004).md)

 - **Prevalence:**

### Glucocorticoid replacement therapy
 - **Relative risk:**
    - Li, L., Bensing, S., & Falhammar, H. (2021) Rate of fracture in patients with glucocorticoid replacement therapy: a systematic review and meta-analysis. *Endocrine*, 74(1), 29-37. [DOI: 10.1007/s12020-021-02723-z](https://doi.org/10.1007/s12020-021-02723-z)
      - JBI Score: 95.5 [See report](jbi-reports/Li%20et%20al.%20(2021).md)

 - **Prevalence:**

### Irritable bowel syndrome
 - **Relative risk:**
    - Wongtrakul, W., Charoenngam, N., & Ungprasert, P. (2020) The association between irritable bowel syndrome and osteoporosis: a systematic review and meta-analysis. *Osteoporosis International*, 31(6), 1049-1057. [DOI: 10.1007/s00198-020-05318-y](https://doi.org/10.1007/s00198-020-05318-y)
      - JBI Score: 100.0 [See report](jbi-reports/Wongtrakul%20et%20al.%20(2020).md)

 - **Prevalence:**

### Previous fracture
 - **Relative risk:**
    - Kanis, J. A., Johnell, O., Oden, A., Johansson, H., De Laet, C., Eisman, J. A., ... Tenenhouse, A. (2005) Smoking and fracture risk: a meta-analysis. *Osteoporosis International*, 16(2), 155-162. [DOI: 10.1007/s00198-004-1640-3](https://doi.org/10.1007/s00198-004-1640-3)

 - **Prevalence:**

### Race
 - **Relative risk:**
    - Bao, Y., Xu, Y., Li, Z., & Wu, Q. (2023) Racial and ethnic difference in the risk of fractures in the United States: a systematic review and meta-analysis. *Scientific Reports*, 13(1). [DOI: 10.1038/s41598-023-32776-1](https://doi.org/10.1038/s41598-023-32776-1)
      - JBI Score: 100.0 [See report](jbi-reports/Bao%20et%20al.%20(2023).md)

 - **Prevalence:**

### Rheumatoid arthritis
 - **Relative risk:**
    - Jin, S., Hsieh, E., Peng, L., Yu, C., Wang, Y., Wu, C., ... Zeng, X. (2018) Incidence of fractures among patients with rheumatoid arthritis: a systematic review and meta-analysis. *Osteoporosis International*, 29(6), 1263-1275. [DOI: 10.1007/s00198-018-4473-1](https://doi.org/10.1007/s00198-018-4473-1)
      - JBI Score: 100.0 [See report](jbi-reports/Jin%20et%20al.%20(2018).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
    - Kanis, J. A., Johnell, O., Oden, A., Johansson, H., De Laet, C., Eisman, J. A., ... Tenenhouse, A. (2005) Smoking and fracture risk: a meta-analysis. *Osteoporosis International*, 16(2), 155-162. [DOI: 10.1007/s00198-004-1640-3](https://doi.org/10.1007/s00198-004-1640-3)
      - JBI Score: 86.4 [See report](jbi-reports/Kanis%20et%20al.%20(2005).md)

 - **Prevalence:**

### Subclinical hyperthyroidism
 - **Relative risk:**
    - Blum, M. R., Bauer, D. C., Collet, T. H., Fink, H. A., Cappola, A. R., da Costa, B. R., Wirth, C. D., et al. (2015)
      - JBI Score: 95.5 [See report](jbi-reports/Blum%20et%20al.%20(2015).md)

 - **Prevalence:**

## Ovarian cancer
### Asbestos exposure
 - **Relative risk:**
    - Camargo, M. C., Stayner, L. T., Straif, K., Reina, M., Al-Alem, U., Demers, P. A., ... Landrigan, P. J. (2011) Occupational Exposure to Asbestos and Ovarian Cancer: A Meta-analysis. *Environmental Health Perspectives*, 119(9), 1211-1217. [DOI: 10.1289/ehp.1003283](https://doi.org/10.1289/ehp.1003283)
      - JBI Score: 86.4 [See report](jbi-reports/Camargo%20et%20al.%20(2011).md)

 - **Prevalence:**

### Breastfeeding
 - **Relative risk:**
    - Li, D., Du, C., Zhang, Z., Li, G., Yu, Z., Wang, X., ... Zhao, Y. (2014) Breastfeeding and Ovarian Cancer Risk: a Systematic Review and Meta-analysis of 40 Epidemiological Studies. *Asian Pacific Journal of Cancer Prevention*, 15(12), 4829-4837. [DOI: 10.7314/apjcp.2014.15.12.4829](https://doi.org/10.7314/apjcp.2014.15.12.4829)
      - JBI Score: 100.0 [See report](jbi-reports/Li%20et%20al.%20(2014).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
    - Stratton, J. F., Pharoah, P., Smith, S. K., Easton, D., & Ponder, B. A. J. (1998) A systematic review and meta‐analysis of family history and risk of ovarian cancer. *BJOG: An International Journal of Obstetrics &amp; Gynaecology*, 105(5), 493-499. [DOI: 10.1111/j.1471-0528.1998.tb10148.x](https://doi.org/10.1111/j.1471-0528.1998.tb10148.x)
      - JBI Score: 86.4 [See report](jbi-reports/Stratton%20et%20al.%20(1998).md)

 - **Prevalence:**

### High parity and Oral contraception
 - **Relative risk:**
    - Tsilidis, K. K., Allen, N. E., Key, T. J., Dossus, L., Lukanova, A., Bakken, K., et al. (2011)
      - JBI Score: 90.9 [See report](jbi-reports/Tsilidis%20et%20al.%20(2011).md)

 - **Prevalence:**

### Hysterectomy and tubal ligation
 - **Relative risk:**
    - Rice, M. S., Murphy, M. A., & Tworoger, S. S. (2012) Tubal ligation, hysterectomy and ovarian cancer: A meta-analysis. *Journal of Ovarian Research*, 5(1), 13. [DOI: 10.1186/1757-2215-5-13](https://doi.org/10.1186/1757-2215-5-13)
      - JBI Score: 81.8 [See report](jbi-reports/Rice%20et%20al.%20(2012).md)

 - **Prevalence:**

## Pancreatic cancer
### Alcohol
 - **Relative risk:**
    - Tramacere, I., Scotti, L., Jenab, M., Bagnardi, V., Bellocco, R., Rota, M., ... La Vecchia, C. (2010) Alcohol drinking and pancreatic cancer risk: a meta‐analysis of the dose‐risk relation. *International Journal of Cancer*, 126(6), 1474-1486. [DOI: 10.1002/ijc.24936](https://doi.org/10.1002/ijc.24936)
      - JBI Score: 95.5 [See report](jbi-reports/Tramacere%20et%20al.%20(2010).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
    - Larsson, S. C., Orsini, N., & Wolk, A. (2007) Body mass index and pancreatic cancer risk: A meta‐analysis of prospective studies. *International Journal of Cancer*, 120(9), 1993-1998. [DOI: 10.1002/ijc.22535](https://doi.org/10.1002/ijc.22535)
      - JBI Score: 95.5 [See report](jbi-reports/Larsson%20et%20al.%20(2007).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
    - Ben, Q., Xu, M., Ning, X., Liu, J., Hong, S., Huang, W., ... Li, Z. (2011) Diabetes mellitus and risk of pancreatic cancer: A meta-analysis of cohort studies. *European Journal of Cancer*, 47(13), 1928-1937. [DOI: 10.1016/j.ejca.2011.03.003](https://doi.org/10.1016/j.ejca.2011.03.003)
      - JBI Score: 86.4 [See report](jbi-reports/Ben%20et%20al.%20(2011).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
    - Permuth-Wey, J., & Egan, K. M. (2009) Family history is a significant risk factor for pancreatic cancer: results from a systematic review and meta-analysis. *Familial Cancer*, 8(2), 109-117. [DOI: 10.1007/s10689-008-9214-8](https://doi.org/10.1007/s10689-008-9214-8)
      - JBI Score: 95.5 [See report](jbi-reports/Permuth-Wey%20%26%20Egan%20(2009).md)

 - **Prevalence:**

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Lugo, A., Peveri, G., Bosetti, C., Bagnardi, V., Crippa, A., Orsini, N., ... Gallus, S. (2018) Strong excess risk of pancreatic cancer for low frequency and duration of cigarette smoking: A comprehensive review and meta-analysis. *European Journal of Cancer*, 104, 117-126. [DOI: 10.1016/j.ejca.2018.09.007](https://doi.org/10.1016/j.ejca.2018.09.007)
    - JBI Score: 86.4 [See report](jbi-reports/Lugo20et20al.20(2018).md)

 - **Prevalence:**

## Prostate cancer
### 5-a reductase inhibitors
 - **Relative risk:**
- [Hu, X., Wang, Y., Yang, Z., Shao, Y., Yang, W., & Li, X. (2020)](http://dx.doi.org/10.21037/tau-20-843)
    - JBI Score: 100 [See report](jbi-reports/Hu20et20al.20(2020).md)

 - **Prevalence:**

### Ejaculation frequency
 - **Relative risk:**
- Rider, J. R., Wilson, K. M., Sinnott, J. A., Kelly, R. S., Mucci, L. A., & Giovannucci, E. L. (2016) Ejaculation Frequency and Risk of Prostate Cancer: Updated Results with an Additional Decade of Follow-up. *European Urology*, 70(6), 974-982. [DOI: 10.1016/j.eururo.2016.03.027](https://doi.org/10.1016/j.eururo.2016.03.027)
    - JBI Score: 100 [See report](jbi-reports/Rider20et20al.20(2016).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Watkins Bruner, D., Moore, D., Parlanti, A., Dorgan, J., & Engstrom, P. (2003) Relative risk of prostate cancer for men with affected relatives: Systematic review and meta‐analysis. *International Journal of Cancer*, 107(5), 797-803. [DOI: 10.1002/ijc.11466](https://doi.org/10.1002/ijc.11466)
    - JBI Score: 86.4 [See report](jbi-reports/Bruner20et20al.20(2003).md)

 - **Prevalence:**

### Sexual activity and STIs
 - **Relative risk:**
    - Dennis, L. K., & Dawson, D. V. (2002) Meta-Analysis of Measures of Sexual Activity and Prostate Cancer. *Epidemiology*, 13(1), 72-79. [DOI: 10.1097/00001648-200201000-00012](https://doi.org/10.1097/00001648-200201000-00012)
      - JBI Score: 86.4 [See report](jbi-reports/Dennis%20%26%20Dawson%20(2002).md)

 - **Prevalence:**

### Tomato sauce
 - **Relative risk:**
    - Graff, R. E., Pettersson, A., Lis, R. T., Ahearn, T. U., Markt, S. C., Wilson, K. M., ... Mucci, L. A. (2016) Dietary lycopene intake and risk of prostate cancer defined by ERG protein expression. *The American Journal of Clinical Nutrition*, 103(3), 851-860. [DOI: 10.3945/ajcn.115.118703](https://doi.org/10.3945/ajcn.115.118703)
      - JBI Score: 95.5 [See report](jbi-reports/Graff%20et%20al.%20(2016).md)

 - **Prevalence:**

## Skin cancer (Melanoma)
### Alcohol
 - **Relative risk:**
    - Rivera, A., Nan, H., Li, T., Qureshi, A., & Cho, E. (2016) Alcohol Intake and Risk of Incident Melanoma: A Pooled Analysis of Three Prospective Studies in the United States. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 25(12), 1550-1558. [DOI: 10.11582F1055-9965.EPI-16-0303](https://doi.org/10.11582F1055-9965.EPI-16-0303)
      - JBI Score: 100 [See report](jbi-reports/Rivera%20et%20al.%20(2016).md)

 - **Prevalence:**

### Eye colour, family history, hair colour
 - **Relative risk:**
    - Gandini, S., Sera, F., Cattaruzza, M. S., Pasquini, P., Zanetti, R., Masini, C., ... Melchi, C. F. (2005) Meta-analysis of risk factors for cutaneous melanoma: III. Family history, actinic damage and phenotypic factors. *European Journal of Cancer*, 41(14), 2040-2059. [DOI: 10.1016/j.ejca.2005.03.034](https://doi.org/10.1016/j.ejca.2005.03.034)
      - JBI Score: 81.8 [See report](jbi-reports/Gandini%20et%20al.%20(2005).md)

 - **Prevalence:**

### Tanning beds
 - **Relative risk:**
    - Zhang, M., Qureshi, A. A., Geller, A. C., Frazier, L., Hunter, D. J., & Han, J. (2012) Use of Tanning Beds and Incidence of Skin Cancer. *Journal of Clinical Oncology*, 30(14), 1588-1593. [DOI: 10.1200/jco.2011.39.3652](https://doi.org/10.1200/jco.2011.39.3652)

 - **Prevalence:**

## Stroke

### Age
 - **Relative risk:**

### Alcohol intake
 - **Relative risk:**
    - O_Donnell et al. (2016)

 - **Prevalence:**

### BMI
 - **Relative risk:**
    - Strazzullo et al. (2010)
      - JBI Score: 100 [See report](jbi-reports/Strazzullo%20et%20al.%20(2010).md)

 - **Prevalence:**

### Coronary heart disease
 - **Relative risk:**
    - Benjamin et al. (2019)
    - Li et al. (2005)
      - JBI Score: 95.5 [See report](jbi-reports/Li%20et%20al.%20(2005).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
    - [Peters, Huxley, & Woodward (2014)](http://dx.doi.org/10.1016/S0140-6736(14)60040-4 )
      - JBI Score: 100 [See report](jbi-reports/Peters%20et%20al.%20(2014).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
    - Yu et al. (2019)
      - JBI Score: 100 [See report](jbi-reports/Yu%20et%20al.%20(2019).md)
    - Liao et al. (1997)
      - JBI Score: 100 [See report](jbi-reports/Liao%20et%20al.%20(1997).md)

 - **Prevalence:**

### Fruit and vegetable consumption
 - **Relative risk:**
    - [He, Nowson, & MacGregor (2006)](https://doi.org/10.1016/S0140-6736(06)68069-0)
      - JBI Score: 100 [See report](jbi-reports/He%20et%20al.%20(2006).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
    - O_Donnell et al. (2016)
      - JBI Score: 100 [See report](jbi-reports/O'Donnell%20et%20al.%20(2016).md)

 - **Prevalence:**

### Oral contraceptives
 - **Relative risk:**
    - Li et al. (2019)
      - JBI Score: 100 [See report](jbi-reports/Li%20et%20al.%20(2019).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
    - Lee, C. D., Folsom, A. R., & Blair, S. N. (2003) Physical Activity and Stroke Risk. *Stroke*, 34(10), 2475-2481. [DOI: 10.1161/01.STR.0000091843.02517.9D](https://doi.org/10.1161/01.STR.0000091843.02517.9D)
      - JBI Score: 86.4 [See report](jbi-reports/Lee%20et%20al.%20(2003).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
    - Tsao et al. (2023)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
    - Kelly et al. (2008)
    - Peters et al. (2013)
      - JBI Score: 81.8 [See report](jbi-reports/Peters%20et%20al.%20(2013).md)

 - **Prevalence:**

### Sodium intake
 - **Relative risk:**
    - [Jackson et al. (2016)](https://www.cdc.gov/mmwr/preview/mmwrhtml/mm6452a1.htm#:~:text=During202009E2809320122C20most20Americans,exceeded2022C30020mg20per20day)
      - JBI Score: 100 [See report](jbi-reports/Jackson%20et%20al.%20(2016).md)
    - Strazzullo et al. (2009)
      - JBI Score: 100 [See report](jbi-reports/Strazzullo%20et%20al.%20(2009).md)

 - **Prevalence:**
