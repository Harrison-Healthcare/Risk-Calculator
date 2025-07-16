<div align="center">
  <img src="../../assets/harrison-logo.jpg" alt="Harrison Healthcare Logo" width="150">
</div>

# Evidence Summary

## Introduction

This document outlines the scientific evidence underlying the relative risk and prevalence values used in the Harrison Healthcare Risk Calculator outlined in the [risk-calculator.csv](../../data/risk-calculator.csv) file. 

The document is structured by disease risk dial and then by risk factor. Each section transparently presents the data sources and Joanna Briggs Institute (JBI) quality ratings (normalized on a scale from 0 to 100) used to determine the calculator’s inputs and forms the scientific foundation of the Harrison Healthcare Risk Calculator.

## Table of Contents

- [Bladder cancer](#bladder-cancer)
  - [Age](#age)
  - [BMI](#bmi)
  - [Diabetes - Type 2](#diabetes---type-2)
  - [Family history](#family-history)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption)
  - [Smoking - cigarettes](#smoking---cigarettes)
- [Breast cancer](#breast-cancer)
  - [Age](#age)
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
  - [Smoking - cigarettes](#smoking---cigarettes-1)
- [Cervical cancer](#cervical-cancer)
  - [Family history](#family-history-2)
  - [HIV](#hiv)
  - [Number of sexual partners](#number-of-sexual-partners)
  - [Oral contraceptive use](#oral-contraceptive-use)
  - [Smoking - cigarettes](#smoking---cigarettes-2)
- [Colorectal cancer](#colorectal-cancer)
  - [Alcohol](#alcohol-1)
  - [Aspirin](#aspirin)
  - [BMI](#bmi-1)
  - [Crohn's disease](#crohns-disease)
  - [Diabetes - Type 2](#diabetes---type-2-2)
  - [Family history](#family-history-3)
  - [Oral contraceptives](#oral-contraceptives)
  - [Physical activity](#physical-activity-1)
  - [Smoking - cigarettes](#smoking---cigarettes-3)
  - [Ulcerative colitis](#ulcerative-colitis)
  - [Vegetables](#vegetables)
- [Coronary heart disease](#coronary-heart-disease)
  - [Anxiety](#anxiety)
  - [Apolipoprotein B-100](#apolipoprotein-b-100)
  - [Apolipoproteins (B-100 and A-I)](#apolipoproteins-b-100-and-a-i)
  - [BMI](#bmi-2)
  - [C-reactive protein](#c-reactive-protein)
  - [Smoking - cigarettes](#smoking---cigarettes-4)
  - [Depression](#depression)
  - [Diabetes - Type 2](#diabetes---type-2-3)
  - [Family history](#family-history-4)
  - [Fruit and vegetable consumption](#fruit-and-vegetable-consumption-1)
  - [Hemoglobin A1c](#hemoglobin-a1c)
  - [Homocysteine level](#homocysteine-level)
  - [Hypertension](#hypertension)
  - [Job strain](#job-strain)
  - [Cholesterol - HDL, LDL, total](#cholesterol---hdl-ldl-total)
  - [Lipoprotein (a)](#lipoprotein-a)
  - [Periodontal disease](#periodontal-disease)
  - [Physical activity](#physical-activity-2)
  - [Red meat consumption](#red-meat-consumption)
  - [Second-hand smoke](#second-hand-smoke)
  - [Social deprivation](#social-deprivation)
  - [Sugar-sweetened beverages](#sugar-sweetened-beverages)
  - [Systolic blood pressure](#systolic-blood-pressure)
- [Dementia](#dementia)
  - [Age](#age)
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
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### BMI
 - **Relative risk:**
    - Sun, J., Zhao, L., Yang, Y., Ma, X., Wang, Y., & Xiang, Y. (2015) Obesity and Risk of Bladder Cancer: A Dose-Response Meta-Analysis of 15 Cohort Studies. *PLOS ONE*, 10(3), e0119313. [DOI: 10.1371/journal.pone.0119313](https://doi.org/10.1371/journal.pone.0119313)
      - JBI Score: 100%. [See report](jbi-reports/Sun%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Flegal, K. M., Carroll, M. D., Kit, B. K., & Ogden, C. L. (2012). Prevalence of Obesity and Trends in the Distribution of Body Mass Index Among US Adults, 1999-2010. *JAMA*, 307(5), 491. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)
      - JBI Score: 94.4%. [See report](jbi-reports/Flegal%20et%20al.%20(2012).md)

### Diabetes - Type 2
 - **Relative risk:**
    - Larsson, S. C., Orsini, N., Brismar, K., & Wolk, A. (2006) Diabetes mellitus and risk of bladder cancer: a meta-analysis. *Diabetologia*, 49(12), 2819-2823. [DOI: 10.1007/s00125-006-0468-0](https://doi.org/10.1007/s00125-006-0468-0)
      - JBI Score: 95.5%. [See report](jbi-reports/Larsson%20et%20al.%20(2006).md)

 - **Prevalence:**
    - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. Health Promotion and Chronic Disease Prevention in Canada, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
      - JBI Score: 94.4%. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk:**
    - Murta-Nascimento, C., Silverman, D. T., Kogevinas, M., García-Closas, M., Rothman, N., Tardón, A., ... Malats, N. (2007) Risk of Bladder Cancer Associated with Family History of Cancer: Do Low-Penetrance Polymorphisms Account for the Increase in Risk?. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 16(8), 1595-1600. [DOI: 10.1158/1055-9965.epi-06-0743](https://doi.org/10.1158/1055-9965.epi-06-0743)
      - JBI Score: 90%. [See report](jbi-reports/Murta-Nascimento%20et%20al.%20(2007).md)

 - **Prevalence:**
    - Pinsky, P. F. (2003). Reported Family History of Cancer in the Prostate, Lung, Colorectal, and Ovarian Cancer Screening Trial. *American Journal of Epidemiology*, 157(9), 792–799. [DOI: 10.1093/aje/kwg043](https://doi.org/10.1093/aje/kwg043)
      - JBI Score: 81.8%. [See report](jbi-reports/Pinsky%20et%20al.%20(2003).md)

### Fruit and vegetable consumption
 - **Relative risk:**
    - Yao, B., Yan, Y., Ye, X., Fang, H., Xu, H., Liu, Y., Li, S., & Zhao, Y. (2014). Intake of fruit and vegetables and risk of bladder cancer: a dose–response meta-analysis of observational studies. *Cancer Causes & Control*, 25(12), 1645–1658. [DOI: 10.1007/s10552-014-0469-0](https://doi.org/10.1007/s10552-014-0469-0)
      - JBI Score: Missing

 - **Prevalence:**
    - Miller, V., Mente, A., Dehghan, M., Rangarajan, S., Zhang, X., Swaminathan, S., Dagenais, G., Gupta, R., Mohan, V., Lear, S., Bangdiwala, S. I., Schutte, A. E., Wentzel-Viljoen, E., Avezum, A., Altuntas, Y., Yusoff, K., Ismail, N., Peer, N., Chifamba, J., … Mapanga, R. (2017). Fruit, vegetable, and legume intake, and cardiovascular disease and deaths in 18 countries (PURE): a prospective cohort study. *The Lancet*, 390(10107), 2037–2049. [DOI: 10.1016/s0140-6736(17)32253-5](https://doi.org/10.1016/s0140-6736(17)32253-5)
      - JBI Score: 95.5% [see report](jbi-reports/Miller%20et%20al.%20(2017).md)

### Smoking - cigarettes
 - **Relative risk and prevalence:**
    - Freedman, N. D. (2011). Association Between Smoking and Risk of Bladder Cancer Among Men and Women. *JAMA*, 306(7), 737. [DOI: 10.1001/jama.2011.1142](https://doi.org/10.1001/jama.2011.1142)
      - JBI Score: 95.5% [see report](jbi-reports/Freedman%20et%20al.%20(2011).md)

## Breast cancer

### Age
 - **Relative risk:**
    - SEER*Explorer: An interactive website for SEER cancer statistics [Internet]. Surveillance Research Program, National Cancer Institute; cited 2024 Jan 15. Available from: https://seer.cancer.gov/statistics-network/explorer/. Data source(s): SEER Incidence Data, November 2024 Submission (1975-2022), SEER 21 registries. [DOI: 10.1001/jama.2012.39](https://doi.org/10.1001/jama.2012.39)

 - **Prevalence:**
    - U.S. Census Bureau. (2021). Age and Sex Composition in the United States, Table 1: Population by Age and Sex 2021 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/age-and-sex/2021/age-sex-composition/2021agesex_table1.xlsx). <https://www.census.gov/data/tables/2021/demo/age-and-sex/2021-age-sex-composition.html>

### Age - Menarche
 - **Relative risk and prevalence:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2012). Menarche, menopause, and breast cancer risk: individual participant meta-analysis, including 118 964 women with breast cancer from 117 epidemiological studies. *The Lancet Oncology*, 13(11), 1141–1151. [DOI: 10.1016/s1470-2045(12)70425-4](https://doi.org/10.1016/s1470-2045(12)70425-4)
      - JBI Score: 100%. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2012).md)

### Age - Menopause
 - **Relative risk and prevalence:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2012). Menarche, menopause, and breast cancer risk: individual participant meta-analysis, including 118 964 women with breast cancer from 117 epidemiological studies. *The Lancet Oncology*, 13(11), 1141–1151. [DOI: 10.1016/s1470-2045(12)70425-4](https://doi.org/10.1016/s1470-2045(12)70425-4)
      - JBI Score: 100%. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2012).md)

### Alcohol
 - **Relative risk:**
     - Bagnardi, V., Rota, M., Botteri, E., Tramacere, I., Islami, F., Fedirko, V., ... La Vecchia, C. (2015) Alcohol consumption and site-specific cancer risk: a comprehensive dose–response meta-analysis. *British Journal of Cancer*, 112(3), 580-593. [DOI: 10.1038/bjc.2014.579](https://doi.org/10.1038/bjc.2014.579)
        - JBI Score: 100%. [See report](jbi-reports/Bagnardi%20et%20al.%20(2015).md)

 - **Prevalence:**
    - Feigelson, H. S., Calle, E. E., Robertson, A. S., Wingo, P. A., & Thun, M. J. (2001) Alcohol consumption increases the risk of fatal breast cancer (United States). *Cancer Causes &amp; Control*, 12(10), 895-902. [DOI: 10.1023/a:1013737616987](https://doi.org/10.1023/a:1013737616987)
      - JBI Score: 86.4%. [See report](jbi-reports/Feigelson%20et%20al.%20(2001).md)

### Breastfeeding
 - **Relative risk:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2002). Breast cancer and breastfeeding: collaborative reanalysis of individual data from 47 epidemiological studies in 30 countries, including 50 302 women with breast cancer and 96 973 women without the disease. *The Lancet*, 360(9328), 187–195. [DOI: 10.1016/s0140-6736(02)09454-0](https://doi.org/10.1016/s0140-6736(02)09454-0)
      - JBI Score: 100%. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2002).md)

 - **Prevalence:**
    - Merritt, M. A., Riboli, E., Murphy, N., Kadi, M., Tjønneland, A., Olsen, A., ... Gunter, M. J. (2015) Reproductive factors and risk of mortality in the European Prospective Investigation into Cancer and Nutrition; a cohort study. *BMC Medicine*, 13(1). [DOI: 10.1186/s12916-015-0484-3](https://doi.org/10.1186/s12916-015-0484-3)
      - JBI Score: 95.5%. [See report](jbi-reports/Merritt%20et%20al.%20(2015).md)

### Diabetes - Type 2
 - **Relative risk:**
   - Boyle, P., Boniol, M., Koechlin, A., Robertson, C., Valentini, F., Coppens, K., Fairley, L.-L., Boniol, M., Zheng, T., Zhang, Y., Pasterk, M., Smans, M., Curado, M. P., Mullie, P., Gandini, S., Bota, M., Bolli, G. B., Rosenstock, J., & Autier, P. (2012). Diabetes and breast cancer risk: a meta-analysis. British Journal of Cancer, 107(9), 1608–1617. [DOI: 10.1038/bjc.2012.414](https://doi.org/10.1038/bjc.2012.414)
      - JBI Score: 100%. [See report](jbi-reports/Boyle%20et%20al.%20(2012).md)

 - **Prevalence:**
     - LeBlanc, A. G., Gao, Y. J., McRae, L., & Pelletier, C. (2019). At-a-glance - Twenty years of diabetes surveillance using the Canadian Chronic Disease Surveillance System. Health Promotion and Chronic Disease Prevention in Canada, 39(11), 306–309. [DOI: 10.24095/hpcdp.39.11.03](https://doi.org/10.24095/hpcdp.39.11.03)
        - JBI Score: 94.4%. [See report](jbi-reports/LeBlanc%20et%20al.%20(2019).md)

### Family history
 - **Relative risk:**
    - Collaborative Group on Hormonal Factors in Breast Cancer. (2001). Familial breast cancer: collaborative reanalysis of individual data from 52 epidemiological studies including 58 209 women with breast cancer and 101 986 women without the disease. *The Lancet*, 358(9291), 1389–1399. [DOI: 10.1016/s0140-6736(01)06524-2](https://doi.org/10.1016/s0140-6736(01)06524-2)
        - JBI Score: 100%. [See report](jbi-reports/Collaborative%20Group%20on%20Hormonal%20Factors%20in%20Breast%20Cancer%20(2001).md)

 - **Prevalence:**
    - Ramsey, S. D., Yoon, P., Moonesinghe, R., & Khoury, M. J. (2006) Population-based study of the prevalence of family history of cancer: Implications for cancer screening and prevention. *Genetics in Medicine*, 8(9), 571-575. [DOI: 10.1097/01.gim.0000237867.34011.12](https://doi.org/10.1097/01.gim.0000237867.34011.12)
        - JBI Score: 88.9%. [See report](jbi-reports/Ramsey%20et%20al.%20(2006).md)

### Height
 - **Relative risk and prevalence:**
    - Green, J., Cairns, B. J., Casabonne, D., Wright, F. L., Reeves, G., & Beral, V. (2011). Height and cancer incidence in the Million Women Study: prospective cohort, and meta-analysis of prospective studies of height and total cancer risk. *The Lancet Oncology*, 12(8), 785–794. [DOI: 10.1016/s1470-2045(11)70154-1](https://doi.org/10.1016/s1470-2045(11)70154-1)
      - JBI Score: 95.5%. [See report](jbi-reports/Green%20et%20al.%20(2011).md)

### Hormone replacement therapy
 - **Relative risk and prevalence:**
    - Beral, V., & Million Women Study Collaborators (2003). Breast cancer and hormone-replacement therapy in the Million Women Study. *Lancet*, 362(9382), 419–427. [DOI: 10.1016/s0140-6736(03)14065-2](https://doi.org/10.1016/s0140-6736(03)14065-2)
      - JBI Score: 95.5%. [See report](jbi-reports/Beral%20et%20al.%20(2003).md)

### Parity
 - **Relative risk:**
    - Lambe, M., Hsieh, C., Chan, H., Ekbom, A., Trichopoulos, D., & Adami, H.-O. (1996). Parity, age at first and last birth, and risk of breast cancer: A population-based study in Sweden. *Breast Cancer Research and Treatment*, 38(3), 305–311. [DOI: 10.1007/bf01806150](https://doi.org/10.1007/bf01806150)
      - JBI Score: 100%. [See report](jbi-reports/Lambe%20et%20al.%20(1996).md)

 - **Prevalence:**
    - U.S. Census Bureau. (2022).Fertility of Women in the United States, Table 1: Women's Number of Children Ever Born by Age and Marital Status: June 2022 [Dataset](https://www2.census.gov/programs-surveys/demo/tables/fertility/time-series/his-cps/h2.xlsx). <https://www.census.gov/data/tables/2022/demo/fertility/women-fertility.html>

### Physical activity
 - **Relative risk and prevalence:**
    - McTiernan, A., Kooperberg, C., White, E., Wilcox, S., Coates, R., Adams-Campbell, L. L., ... Ockene, J. (2003) Recreational Physical Activity and the Risk of Breast Cancer in Postmenopausal Women. *JAMA*, 290(10), 1331. [DOI: 10.1001/jama.290.10.1331](https://doi.org/10.1001/jama.290.10.1331)
      - JBI Score: 95.5%. [See report](jbi-reports/McTiernan%20et%20al.%20(2003).md)

### Smoking - cigarettes
 - **Relative risk:**
    - Gram, I. T., Park, S., Kolonel, L. N., Maskarinec, G., Wilkens, L. R., Henderson, B. E., ... Le Marchand, L. (2015) Smoking and Risk of Breast Cancer in a Racially/Ethnically Diverse Population of Mainly Women Who Do Not Drink Alcohol. *American Journal of Epidemiology*, 182(11), 917-925. [DOI: 10.1093/aje/kwv092](https://doi.org/10.1093/aje/kwv092)
        - JBI Score: 95.5%. [See report](jbi-reports/Gram%20et%20al.%20(2015).md)

 - **Prevalence:**

## Cervical cancer

### Family history
 - **Relative risk:**
- Magnusson, P. K. E., Sparén, P., & Gyllensten, U. B. (1999) Genetic link to cervical tumours. *Nature*, 400(6739), 29-30. [DOI: 10.1038/21801](https://doi.org/10.1038/21801)
    - JBI Score: 90.9%. [See report](jbi-reports/Magnusson%20et%20al.%20(1999).md)

 - **Prevalence:**

### HIV
 - **Relative risk:**
- Liu, G., Sharma, M., Tan, N., & Barnabas, R. V. (2018) HIV-positive women have higher risk of human papilloma virus infection, precancerous lesions, and cervical cancer. *AIDS*, 32(6), 795-808. [DOI: 10.1097%2FQAD.0000000000001765](https://doi.org/10.1097%2FQAD.0000000000001765)
    - JBI Score: 100%. [See report](jbi-reports/Liu%20et%20al.%20(2018).md)

 - **Prevalence:**

### Number of sexual partners
 - **Relative risk:**
- International Collaboration of Epidemiological Studies of Cervical Cancer (2007)
    - JBI Score: 100%. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2007).md)

 - **Prevalence:**

### Oral contraceptive use
 - **Relative risk:**
- International Collaboration of Epidemiological Studies of Cervical Cancer, Appleby, P., Beral, V., Berrington de González, A., Colin, D., Franceschi, S., Goodhill, A., Green, J., Peto, J., Plummer, M., & Sweetland, S. (2007)
    - JBI Score: 100%. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2007).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- (2006) Carcinoma of the cervix and tobacco smoking: Collaborative reanalysis of individual data on 13,541 women with carcinoma of the cervix and 23,017 women without carcinoma of the cervix from 23 epidemiological studies. *International Journal of Cancer*, 118(6), 1481-1495. [DOI: 10.1002/ijc.21493](https://doi.org/10.1002/ijc.21493)
    - JBI Score: 100%. [See report](jbi-reports/International%20Collaboration%20of%20Epidemiological%20Studies%20of%20Cervical%20Cancer%20(2006).md)

 - **Prevalence:**

## Colorectal cancer
### Alcohol
 - **Relative risk:**
- Fedirko, V., Tramacere, I., Bagnardi, V., Rota, M., Scotti, L., Islami, F., ... Jenab, M. (2011) Alcohol drinking and colorectal cancer risk: an overall and dose–response meta-analysis of published studies. *Annals of Oncology*, 22(9), 1958-1972. [DOI: 10.1093/annonc/mdq653](https://doi.org/10.1093/annonc/mdq653)
    - JBI Score: 100%. [See report](jbi-reports/Fedirko%20et%20al.%20(2011).md)

 - **Prevalence:**

### Aspirin
 - **Relative risk:**
- Cole, B. F., Logan, R. F., Halabi, S., Benamouzig, R., Sandler, R. S., Grainge, M. J., ... Baron, J. A. (2009) Aspirin for the Chemoprevention of Colorectal Adenomas: Meta-analysis of the Randomized Trials. *JNCI: Journal of the National Cancer Institute*, 101(4), 256-266. [DOI: 10.1093/jnci/djn485](https://doi.org/10.1093/jnci/djn485)
    - JBI Score: 100%. [See report](jbi-reports/Cole%20et%20al.%20(2009).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
- Moghaddam, A. A., Woodward, M., & Huxley, R. (2007) Obesity and Risk of Colorectal Cancer: A Meta-analysis of 31 Studies with 70,000 Events. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 16(12), 2533-2547. [DOI: 10.1158/1055-9965.epi-07-0708](https://doi.org/10.1158/1055-9965.epi-07-0708)
    - JBI Score: 100%. [See report](jbi-reports/Moghaddam%20et%20al.%20(2007).md)

 - **Prevalence:**

### Crohn's disease
 - **Relative risk:**
- Card, T., Canavan, C., & West, J. (2014) The epidemiology of irritable bowel syndrome. *Clinical Epidemiology*, 71. [DOI: 10.2147%2FCLEP.S40245](https://doi.org/10.2147%2FCLEP.S40245)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Yuhara, H., Steinmaus, C., Cohen, S. E., Corley, D. A., Tei, Y., & Buffler, P. A. (2011) Is Diabetes Mellitus an Independent Risk Factor for Colon Cancer and Rectal Cancer?. *American Journal of Gastroenterology*, 106(11), 1911-1921. [DOI: 10.1038/ajg.2011.301](https://doi.org/10.1038/ajg.2011.301)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Taylor, D. P., Burt, R. W., Williams, M. S., Haug, P. J., & Cannon–Albright, L. A. (2010) Population-Based Family History–Specific Risks for Colorectal Cancer: A Constellation Approach. *Gastroenterology*, 138(3), 877-885. [DOI: 10.1053/j.gastro.2009.11.044](https://doi.org/10.1053/j.gastro.2009.11.044)
    - JBI Score: 95.5%. [See report](jbi-reports/Taylor%20et%20al.%20(2010).md)

 - **Prevalence:**

### Oral contraceptives
 - **Relative risk:**
- Abusal, F., Aladwan, M., Alomari, Y., Obeidat, S., Abuwardeh, S., AlDahdouh, H., ... Odat, Q. (2022) Oral contraceptives and colorectal cancer risk - A meta-analysis and systematic review. *Annals of Medicine &amp; Surgery*, 83. [DOI: 10.1016/j.amsu.2022.104254](https://doi.org/10.1016/j.amsu.2022.104254)
    - JBI Score: 100%. [See report](jbi-reports/Abusal%20et%20al.%20(2022).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Wolin, K. Y., Yan, Y., Colditz, G. A., & Lee, I. (2009) Physical activity and colon cancer prevention: a meta-analysis. *British Journal of Cancer*, 100(4), 611-616. [DOI: 10.1038/sj.bjc.6604917](https://doi.org/10.1038/sj.bjc.6604917)
    - JBI Score: 100%. [See report](jbi-reports/Wolin%20et%20al.%20(2009).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Tsoi, K. K., Pau, C. Y., Wu, W. K., Chan, F. K., Griffiths, S., & Sung, J. J. (2009) Cigarette Smoking and the Risk of Colorectal Cancer: A Meta-analysis of Prospective Cohort Studies. *Clinical Gastroenterology and Hepatology*, 7(6), 682-688.e5. [DOI: 10.1016/j.cgh.2009.02.016](https://doi.org/10.1016/j.cgh.2009.02.016)
    - JBI Score: 100%. [See report](jbi-reports/Tsoi%20et%20al.%20(2009).md)

 - **Prevalence:**

### Ulcerative colitis
 - **Relative risk:**
- Jess, T., Rungoe, C., & Peyrin–Biroulet, L. (2012) Risk of Colorectal Cancer in Patients With Ulcerative Colitis: A Meta-analysis of Population-Based Cohort Studies. *Clinical Gastroenterology and Hepatology*, 10(6), 639-645. [DOI: 10.1016/j.cgh.2012.01.010](https://doi.org/10.1016/j.cgh.2012.01.010)
    - JBI Score: 100%. [See report](jbi-reports/Jess%20et%20al.%20(2012).md)

 - **Prevalence:**

### Vegetables
 - **Relative risk:**
- Aune, D., Lau, R., Chan, D. S., Vieira, R., Greenwood, D. C., Kampman, E., ... Norat, T. (2011) Nonlinear Reduction in Risk for Colorectal Cancer by Fruit and Vegetable Intake Based on Meta-analysis of Prospective Studies. *Gastroenterology*, 141(1), 106-118. [DOI: 10.1053/j.gastro.2011.04.013](https://doi.org/10.1053/j.gastro.2011.04.013)
    - JBI Score: 100%. [See report](jbi-reports/Aune%20et%20al.%20(2011).md)

 - **Prevalence:**

## Coronary heart disease
### Anxiety
 - **Relative risk:**
- Roest, A. M., Martens, E. J., de Jonge, P., Denollet, J. (2010)
    - JBI Score: 100%. [See report](jbi-reports/Roest%20et%20al.%20(2010).md)

 - **Prevalence:**

### Apolipoprotein B-100
 - **Relative risk:**
- Benn, M., Nordestgaard, B. G., Jensen, G. B., & Tybjærg-Hansen, A. (2007) Improving Prediction of Ischemic Cardiovascular Disease in the General Population Using Apolipoprotein B. *Arteriosclerosis, Thrombosis, and Vascular Biology*, 27(3), 661-670. [DOI: 10.1161/01.ATV.0000255580.73689.8e](https://doi.org/10.1161/01.ATV.0000255580.73689.8e)

 - **Prevalence:**

### Apolipoproteins (B-100 and A-I)
 - **Relative risk:**
- Walldius, G., de Faire, U., Alfredsson, L., Leander, K., Westerholm, P., Malmström, H., ... Hammar, N. (2021) Long-term risk of a major cardiovascular event by apoB, apoA-1, and the apoB/apoA-1 ratio—Experience from the Swedish AMORIS cohort: A cohort study. *PLOS Medicine*, 18(12), e1003853. [DOI: 10.1371/JOURNAL.PMED.1003853](https://doi.org/10.1371/JOURNAL.PMED.1003853)
    - JBI Score: 95.5%. [See report](jbi-reports/Walldius%20et%20al.%20(2021).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
- Flint, A. J., Rexrode, K. M., Hu, F. B., Glynn, R. J., Caspard, H., Manson, J. E., ... Rimm, E. B. (2010) Body mass index, waist circumference, and risk of coronary heart disease: A prospective study among men and women. *Obesity Research &amp; Clinical Practice*, 4(3), e171-e181. [DOI: 10.1016%2Fj.orcp.2010.01.001](https://doi.org/10.1016%2Fj.orcp.2010.01.001)
    - JBI Score: 95.5%. [See report](jbi-reports/Flint%20et%20al.%20(2010).md)
- Lu Y., Hajifathalian K., Ezzati M., Woodward M., Rimm E.B. , Danaei G (2013)

 - **Prevalence:**

### C-reactive protein
 - **Relative risk:**
- Pai, J. K., Pischon, T., Ma, J., Manson, J. E., Hankinson, S. E., Joshipura, K., ... Rimm, E. B. (2004) Inflammatory Markers and the Risk of Coronary Heart Disease in Men and Women. *New England Journal of Medicine*, 351(25), 2599-2610. [DOI: 10.1056/NEJMoa040967](https://doi.org/10.1056/NEJMoa040967)
    - JBI Score: 95.5%. [See report](jbi-reports/Pai%20et%20al.%20(2004).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Prescott, E., Hippe, M., Schnohr, P., Hein, H. O., & Vestbo, J. (1998) Smoking and risk of myocardial infarction in women and men: longitudinal population study. *BMJ*, 316(7137), 1043-1047. [DOI: 10.1136/bmj.316.7137.1043](https://doi.org/10.1136/bmj.316.7137.1043)
    - JBI Score: 95.5%. [See report](jbi-reports/Prescott%20et%20al.%20(1998).md)

 - **Prevalence:**

### Depression
 - **Relative risk:**
- Gan, Y., Gong, Y., Tong, X. et al. (2014)
    - JBI Score: 100%. [See report](jbi-reports/Gan%20et%20al.%20(2014).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- [Peters, S.A.E., Huxley, R.R. & Woodward, M. (2014)](http://dx.doi.org/10.1016/S0140-6736(14)60040-4 )
    - JBI Score: 100%. [See report](jbi-reports/Peters%20et%20al.%20(2014).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Sivapalaratnam, S., Boekholdt, S. M., Trip, M. D., Sandhu, M. S., Luben, R., Kastelein, J. J. P., ... Khaw, K. (2010) Family history of premature coronary heart disease and risk prediction in the EPIC-Norfolk prospective population study. *Heart*, 96(24), 1985-1989. [DOI: 10.1136/hrt.2010.210740](https://doi.org/10.1136/hrt.2010.210740)
    - JBI Score: 95.5%. [See report](jbi-reports/Sivapalaratnam%20et%20al.%20(2010).md)

 - **Prevalence:**

### Fruit and vegetable consumption
 - **Relative risk:**
- He, F. J., Nowson, C. A., Lucas, M., & MacGregor, G. A. (2007) Increased consumption of fruit and vegetables is related to a reduced risk of coronary heart disease: meta-analysis of cohort studies. *Journal of Human Hypertension*, 21(9), 717-728. [DOI: 10.1038/sj.jhh.1002212](https://doi.org/10.1038/sj.jhh.1002212)
    - JBI Score: 100%. [See report](jbi-reports/He%20et%20al.%20(2007).md)

 - **Prevalence:**

### Hemoglobin A1c
 - **Relative risk:**
- [Pai, J. K., et al. (2013) Hemoglobin A1c Is Associated With Increased Risk of Incident Coronary Heart Disease Among Apparently Healthy, Nondiabetic Men and Women.](https://doi.org/10.1161/JAHA.112.000077)
  - JBI Score: 100%. [See report](jbi-reports/Pai%20et%20al.%20(2013).md)

 - **Prevalence:**

### Homocysteine level
 - **Relative risk:**
- Folsom, A. R., Chambless, L. E., Ballantyne, C. M., Coresh, J., Heiss, G., Wu, K. K., ... Sharrett, A. R. (2006) An Assessment of Incremental Coronary Risk Prediction Using C-Reactive Protein and Other Novel Risk Markers. *Archives of Internal Medicine*, 166(13), 1368. [DOI: 10.1001/archinte.166.13.1368](https://doi.org/10.1001/archinte.166.13.1368)
  - JBI Score: 95.5%. [See report](jbi-reports/Folsom%20et%20al.%20(2006).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
- [Yusuf, S., Hawken, S., Ounpuu, S., Dans, T., Avezum, A., Lanas, F., McQueen, M., Budaj, A., Pais, P., Varigos, J., Lisheng, L., & INTERHEART Study Investigators (2004)](https://doi.org/10.1016/s0140-6736(04)17018-9)
  - JBI Score: 100%. [See report](jbi-reports/Yusuf%20et%20al.%20(2004).md)

 - **Prevalence:**

### Job strain
 - **Relative risk:**
- Kivimäki, M., Nyberg, S. T., Fransson, E. I., Heikkilä, K., Alfredsson, L., Casini, A., ... Batty, G. D. (2013) Associations of job strain and lifestyle risk factors with risk of coronary artery disease: a meta-analysis of individual participant data. *Canadian Medical Association Journal*, 185(9), 763-769. [DOI: 10.1503%2Fcmaj.121735](https://doi.org/10.1503%2Fcmaj.121735)
  - JBI Score: 100%. [See report](jbi-reports/Kivimaki%20et%20al.%20(2013).md)

 - **Prevalence:**

### Cholesterol - HDL, LDL, total
 - **Relative risk:**
- Peters, S. A., Singhateh, Y., Mackay, D., Huxley, R. R., & Woodward, M. (2016) Total cholesterol as a risk factor for coronary heart disease and stroke in women compared with men: A systematic review and meta-analysis. *Atherosclerosis*, 248, 123-131. [DOI: 10.1016/j.atherosclerosis.2016.03.016](https://doi.org/10.1016/j.atherosclerosis.2016.03.016)
  - JBI Score: 95.5%. [See report](jbi-reports/Peters%20et%20al.%20(2016).md)
- [Mortensen, M. B., & Nordestgaard, B. G. (2020)](https://doi.org/10.1016/S0140-6736(20)32233-9)
  - JBI Score: 90.9%. [See report](jbi-reports/Mortensen%20%26%20Nordestgaard%20(2020).md)
- Manninen, V., Tenkanen, L., Koskinen, P., Huttunen, J. K., Mänttäri, M., Heinonen, O. P., ... Frick, M. H. (1992) Joint effects of serum triglyceride and LDL cholesterol and HDL cholesterol concentrations on coronary heart disease risk in the Helsinki Heart Study. Implications for treatment.. *Circulation*, 85(1), 37-45. [DOI: 10.1161/01.CIR.85.1.37](https://doi.org/10.1161/01.CIR.85.1.37)
  - JBI Score: 96.1%. [See report](jbi-reports/Manninen%20et%20al.%20(1992).md)

 - **Prevalence:**

### Lipoprotein (a)
 - **Relative risk:**
- Bhatia, H. S., Ambrosio, M., Razavi, A. C., Alebna, P. L., Yeang, C., Spitz, J. A., ... Mehta, A. (2025) <b>AHA PREVENT Equations and Lipoprotein(a) for Cardiovascular Disease Risk </b>. *JAMA Cardiology*. [DOI: 10.1001/jamacardio.2025.1603](https://doi.org/10.1001/jamacardio.2025.1603)

 - **Prevalence:**

### Periodontal disease
 - **Relative risk:**
- Janket, S., Baird, A. E., Chuang, S., & Jones, J. A. (2003) Meta-analysis of periodontal disease and risk of coronary heart disease and stroke. *Oral Surgery, Oral Medicine, Oral Pathology, Oral Radiology, and Endodontology*, 95(5), 559-569. [DOI: 10.1067/moe.2003.107](https://doi.org/10.1067/moe.2003.107)
  - JBI Score: 100%. [See report](jbi-reports/Janket%20et%20al.%20(2003).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Kyu, H. H., Bachman, V. F., Alexander, L. T., Mumford, J. E., Afshin, A., Estep, K., ... Forouzanfar, M. H. (2016) Physical activity and risk of breast cancer, colon cancer, diabetes, ischemic heart disease, and ischemic stroke events: systematic review and dose-response meta-analysis for the Global Burden of Disease Study 2013. *BMJ*, i3857. [DOI: 10.1136/bmj.i3857](https://doi.org/10.1136/bmj.i3857)
  - JBI Score: 95.5%. [See report](jbi-reports/Kyu%20et%20al.%20(2016).md)
- Kyu, H. H., Bachman, V. F., Alexander, L. T., Mumford, J. E., Afshin, A., Estep, K., ... Forouzanfar, M. H. (2016) Physical activity and risk of breast cancer, colon cancer, diabetes, ischemic heart disease, and ischemic stroke events: systematic review and dose-response meta-analysis for the Global Burden of Disease Study 2013. *BMJ*, i3857. [DOI: 10.1136/bmj.i3857](https://doi.org/10.1136/bmj.i3857)

 - **Prevalence:**

### Red meat consumption
 - **Relative risk:**
- Papier, K., Fensom, G. K., Knuppel, A., Appleby, P. N., Tong, T. Y. N., Schmidt, J. A., ... Perez-Cornago, A. (2021) Meat consumption and risk of 25 common conditions: outcome-wide analyses in 475,000 men and women in the UK Biobank study. *BMC Medicine*, 19(1). [DOI: 10.1186/s12916-021-01922-9](https://doi.org/10.1186/s12916-021-01922-9)
  - JBI Score: 95.5%. [See report](jbi-reports/Papier%20et%20al.%20(2021).md)

- Papier, K., Fensom, G. K., Knuppel, A., Appleby, P. N., Tong, T. Y. N., Schmidt, J. A., Travis, R. C., Key, T. J., & Perez-Cornago, A. (2021) - Supplementary Data → [Add link to `Papier, K., Fensom, G. K., Knuppel, A., Appleby, P. N., Tong, T. Y. N., Schmidt, J. A., Travis, R. C., Key, T. J., & Perez-Cornago, A. (2021) - Supplementary Data.md`]

 - **Prevalence:**

### Second-hand smoke
 - **Relative risk:**
- Fischer, F., & Kraemer, A. (2015) Meta-analysis of the association between second-hand smoke exposure and ischaemic heart diseases, COPD and stroke. *BMC Public Health*, 15(1). [DOI: 10.1186/s12889-015-2489-4](https://doi.org/10.1186/s12889-015-2489-4)
  - JBI Score: 100%. [See report](jbi-reports/Fischer%20%26%20Kraemer%20(2015).md)

 - **Prevalence:**

### Social deprivation
 - **Relative risk:**
- Woodward, M., Brindle, P., Tunstall-Pedoe, H. (2007)
- Hippisley-Cox, J., Coupland, C., Vinogradova, Y., Robson, J., May, M., Brindle, P. (2007)

 - **Prevalence:**

### Sugar-sweetened beverages
 - **Relative risk:**
- Huang, Y., Chen, Z., Chen, B., Li, J., Yuan, X., Li, J., ... Liu, L. (2023) Dietary sugar consumption and health: umbrella review. *BMJ*, e071609. [DOI: 10.1136/bmj-2022-071609](https://doi.org/10.1136/bmj-2022-071609)
  - JBI Score: 90.9%. [See report](jbi-reports/Huang%20et%20al.%20(2023).md)

 - **Prevalence:**

### Systolic blood pressure
 - **Relative risk:**
- Razo et al. (2022)
  - JBI Score: 100%. [See report](jbi-reports/Razo%20et%20al.%20(2022).md)

## Dementia
### Age
 - **Relative risk:**

 - **Prevalence:**

### Atrial fibrillation
 - **Relative risk:**
- Santangeli, P., Di Biase, L., Bai, R., Mohanty, S., Pump, A., Cereceda Brantes, M., ... Natale, A. (2012) Atrial fibrillation and the risk of incident dementia: A meta-analysis. *Heart Rhythm*, 9(11), 1761-1768.e2. [DOI: 10.1016/j.hrthm.2012.07.026](https://doi.org/10.1016/j.hrthm.2012.07.026)
  - JBI Score: 100%. [See report](jbi-reports/Santangeli%20et%20al.%20(2012).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
- Whitmer et al. (2005)
  - JBI Score: 100%. [See report](jbi-reports/Whitmer%20et%20al.%20(2005).md)
- Morys F., Dadar M., Dagher A., 2021

 - **Prevalence:**

### Coronary artery disease
 - **Relative risk:**
- Wolters, F. J., Segufa, R. A., Darweesh, S. K., Bos, D., Ikram, M. A., Sabayan, B., ... Sedaghat, S. (2018) Coronary heart disease, heart failure, and the risk of dementia: A systematic review and meta‐analysis. *Alzheimer's &amp; Dementia*, 14(11), 1493-1504. [DOI: 10.1016/j.jalz.2018.01.007](https://doi.org/10.1016/j.jalz.2018.01.007)
  - JBI Score: 100%. [See report](jbi-reports/Wolters%20et%20al.%20(2018).md)

 - **Prevalence:**

### Depression
 - **Relative risk:**
- Katon et al. (2015)
  - JBI Score: 100%. [See report](jbi-reports/Katon%20et%20al.%20(2015).md)
- Hasin et al. (2018)
  - JBI Score: 100%. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Xu et al. (2018)
- Xue et al. (2019)
  - JBI Score: 100%. [See report](jbi-reports/Xue%20et%20al.%20(2019).md)
- CDC (2020)

 - **Prevalence:**

### Education
 - **Relative risk:**
- Launer et al. (1999)
  - JBI Score: 86.4%. [See report](jbi-reports/Launer%20et%20al.%20(1999).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Cannon-Albright et al. (2019)
  - JBI Score: 81.8%. [See report](jbi-reports/Cannon-Albright%20et%20al.%20(2019).md)

 - **Prevalence:**

### Hearing loss
 - **Relative risk:**
- Goman & Lin (2016)
- Mick et al. (2021)
  - JBI Score: 100%. [See report](jbi-reports/Mick%20et%20al.%20(2021).md)
- Ford, E. S., & Cooper, R. S. (1991) Risk factors for hypertension in a national cohort study.. *Hypertension*, 18(5), 598-606. [DOI: 10.1161/01.HYP.18.5.598](https://doi.org/10.1161/01.HYP.18.5.598)
- Liang et al. (2021)
  - JBI Score: 100%. [See report](jbi-reports/Liang%20et%20al.%20(2021).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
- Gottesman et al. (2017)
  - JBI Score: 100%. [See report](jbi-reports/Gottesman%20et%20al.%20(2017).md)
- Booth et al. (2017)
  - JBI Score: 100%. [See report](jbi-reports/Booth%20et%20al.%20(2017).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
- Lim et al. (2021)
- Shiekh et al. (2021)
  - JBI Score: 100%. [See report](jbi-reports/Shiekh%20et%20al.%20(2021).md)

 - **Prevalence:**

### Sedentary behaviour
 - **Relative risk:**
- Yan et al. (2020)
- Kivimäki, M., Nyberg, S. T., Fransson, E. I., Heikkilä, K., Alfredsson, L., Casini, A., ... Batty, G. D. (2013) Associations of job strain and lifestyle risk factors with risk of coronary artery disease: a meta-analysis of individual participant data. *Canadian Medical Association Journal*, 185(9), 763-769. [DOI: 10.1503%2Fcmaj.121735](https://doi.org/10.1503%2Fcmaj.121735)
- Huang et al. (2022)
  - JBI Score: 100%. [See report](jbi-reports/Huang%20et%20al.%20(2022).md)

 - **Prevalence:**

### Sleep
 - **Relative risk:**
- Fan et al. (2019)
  - JBI Score: 100%. [See report](jbi-reports/Fan%20et%20al.%20(2019).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Rusanen et al. (2011)
  - JBI Score: 100%. [See report](jbi-reports/Rusanen%20et%20al.%20(2011).md)
- Zhong et al. (2015)
  - JBI Score: 100%. [See report](jbi-reports/Zhong%20et%20al.%20(2015).md)

 - **Prevalence:**

### Social relationships
 - **Relative risk:**
- [Kuiper et al. (2015)](http://dx.doi.org/10.1016/j.arr.2015.04.006)
  - JBI Score: 100%. [See report](jbi-reports/Kuiper%20et%20al.%20(2015).md)
- Rohr et al. (2021)
  - JBI Score: 100%. [See report](jbi-reports/Rohr%20et%20al.%20(2021).md)

 - **Prevalence:**

### Stroke
 - **Relative risk:**
- Kuzma et al. (2018)
  - JBI Score: 100%. [See report](jbi-reports/Kuzma%20et%20al.%20(2018).md)

 - **Prevalence:**

## Depression
### Adverse childhood experiences
 - **Relative risk:**
- Giano, Z., Wheeler, D. L., & Hubach, R. D. (2020) The frequencies and disparities of adverse childhood experiences in the U.S.. *BMC Public Health*, 20(1). [DOI: 10.1186/s12889-020-09411-z](https://doi.org/10.1186/s12889-020-09411-z)
  - JBI Score: 100%. [See report](jbi-reports/Giano%20et%20al.%20(2020).md)
- Björkenstam, E., Vinnerljung, B., & Hjern, A. (2017)
  - JBI Score: 100%. [See report](jbi-reports/Bjorkenstam%20et%20al.%20(2017).md)
- Nelson et al. (2017)
  - JBI Score: 100%. [See report](jbi-reports/Nelson%20et%20al.%20(2017).md)

 - **Prevalence:**

### Chronic pain
 - **Relative risk:**
- Ohayon, M. M., & Schatzberg, A. F. (2003) Using Chronic Pain to Predict Depressive Morbidity in the General Population. *Archives of General Psychiatry*, 60(1), 39. [DOI: 10.1001/archpsyc.60.1.39](https://doi.org/10.1001/archpsyc.60.1.39)
  - JBI Score: 100%. [See report](jbi-reports/Ohayon%20%26%20Schatzberg%20(2003).md)
- NCHS (2020)

 - **Prevalence:**

### Demographic variables (age, marital status, race)
 - **Relative risk:**
- Hasin, D. S., Sarvet, A. L., Meyers, J. L., Saha, T. D., Ruan, W. J., Stohl, M., ... Grant, B. F. (2018) Epidemiology of Adult <i>DSM-5</i> Major Depressive Disorder and Its Specifiers in the United States. *JAMA Psychiatry*, 75(4), 336. [DOI: 10.1001/jamapsychiatry.2017.4602](https://doi.org/10.1001/jamapsychiatry.2017.4602)
  - JBI Score: 100%. [See report](jbi-reports/Hasin%20et%20al.%20(2018).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Rotella, F., & Mannucci, E. (2013) Diabetes mellitus as a risk factor for depression. A meta-analysis of longitudinal studies. *Diabetes Research and Clinical Practice*, 99(2), 98-104. [DOI: 10.1016/j.diabres.2012.11.022](https://doi.org/10.1016/j.diabres.2012.11.022)
  - JBI Score: 100%. [See report](jbi-reports/Rotella%20%26%20Mannucci%20(2013).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Van Dijk et al. (2021)
  - JBI Score: 100%. [See report](jbi-reports/Van%20Dijk%20et%20al.%20(2021).md)

 - **Prevalence:**

### Job strain
 - **Relative risk:**
- Nyberg et al. (2013)
  - JBI Score: 100%. [See report](jbi-reports/Nyberg%20et%20al.%20(2013).md)
- Madsen et al. (2017)
  - JBI Score: 100%. [See report](jbi-reports/Madsen%20et%20al.%20(2017).md)

 - **Prevalence:**

### Sedentary behaviour
 - **Relative risk:**
- Vallance et al. (2011)
  - JBI Score: 100%. [See report](jbi-reports/Vallance%20et%20al.%20(2011).md)
- Zhou et al. (2023)

 - **Prevalence:**

### Sleep
 - **Relative risk:**
- Zhai, L., Zhang, H., & Zhang, D. (2015) [DOI: 10.1002/da.2238](https://doi.org/10.1002/da.2238)
  - JBI Score: 100%. [See report](jbi-reports/Zhai%20et%20al.%20(2015).md)
- Sheehan et al. (2019)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Mojtabai, R., & Crum, R. M. (2013) Cigarette Smoking and Onset of Mood and Anxiety Disorders. *American Journal of Public Health*, 103(9), 1656-1665. [DOI: 10.2105%2FAJPH.2012.300911](https://doi.org/10.2105%2FAJPH.2012.300911)
  - JBI Score: 100%. [See report](jbi-reports/Mojtabai%20%26%20Crum%20(2013).md)

 - **Prevalence:**

## Diabetes - Type 2
### Adiponectin
 - **Relative risk:**
- Duncan, B. B., Schmidt, M. I., Pankow, J. S., Bang, H., Couper, D., Ballantyne, C. M., ... Heiss, G. (2004) Adiponectin and the Development of Type 2 Diabetes. *Diabetes*, 53(9), 2473-2478. [DOI: 10.2337/diabetes.53.9.2473](https://doi.org/10.2337/diabetes.53.9.2473)
  - JBI Score: 100%. [See report](jbi-reports/Duncan%20et%20al.%20(2004).md)

 - **Prevalence:**

### Age
 - **Relative risk:**
 - **Prevalence:**
### BMI
 - **Relative risk:**
- Abdullah, A., Peeters, A., de Courten, M., & Stoelwinder, J. (2010) The magnitude of association between overweight and obesity and the risk of diabetes: A meta-analysis of prospective cohort studies. *Diabetes Research and Clinical Practice*, 89(3), 309-319. [DOI: 10.1016/j.diabres.2010.04.012](https://doi.org/10.1016/j.diabres.2010.04.012)
  - JBI Score: 100%. [See report](jbi-reports/Abdullah%20et%20al.%20(2010).md)

 - **Prevalence:**

### C-reactive protein (CRP)
 - **Relative risk:**
- WANG, X., BI, Y., ZHANG, Q., & PAN, F. (2013) Obstructive sleep apnoea and the risk of type 2 diabetes: A meta‐analysis of prospective cohort studies. *Respirology*, 18(1), 140-146. [DOI: 10.1111/j.1440-1843.2012.02267.x](https://doi.org/10.1111/j.1440-1843.2012.02267.x)
  - JBI Score: 100%. [See report](jbi-reports/Wang%20et%20al.%20(2013).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Willi, C., Bodenmann, P., Ghali, W. A., Faris, P. D., & Cornuz, J. (2007) Active Smoking and the Risk of Type 2 Diabetes. *JAMA*, 298(22), 2654. [DOI: 10.1001/jama.298.22.2654](https://doi.org/10.1001/jama.298.22.2654)
  - JBI Score: 100%. [See report](jbi-reports/Willi%20et%20al.%20(2007).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Valdez, R., Yoon, P. W., Liu, T., & Khoury, M. J. (2007) Family History and Prevalence of Diabetes in the U.S. Population. *Diabetes Care*, 30(10), 2517-2522. [DOI: 10.2337/dc07-0720](https://doi.org/10.2337/dc07-0720)
  - JBI Score: 100%. [See report](jbi-reports/Valdez%20et%20al.%20(2007).md)
- InterAct Consortium (2013)
  - JBI Score: 100%. [See report](jbi-reports/InterAct%20Consortium%20(2013).md)

 - **Prevalence:**

### Gestational diabetes
 - **Relative risk:**
- Vounzoulaki, E., Khunti, K., Abner, S. C., Tan, B. K., Davies, M. J., & Gillies, C. L. (2020) Progression to type 2 diabetes in women with a known history of gestational diabetes: systematic review and meta-analysis. *BMJ*, m1361. [DOI: 10.1136/bmj.m1361](https://doi.org/10.1136/bmj.m1361)
  - JBI Score: 100%. [See report](jbi-reports/Vounzoulaki%20et%20al.%20(2020).md)

 - **Prevalence:**

### Cholesterol - HDL
 - **Relative risk:**
- Montonen, J., Drogan, D., Joost, H., Boeing, H., Fritsche, A., Schleicher, E., ... Pischon, T. (2011) Estimation of the contribution of biomarkers of different metabolic pathways to risk of type 2 diabetes. *European Journal of Epidemiology*, 26(1), 29-38. [DOI: 10.1007/s10654-010-9539-0](https://doi.org/10.1007/s10654-010-9539-0)
  - JBI Score: 100%. [See report](jbi-reports/Montonen%20et%20al.%20(2011).md)

 - **Prevalence:**

### Hemoglobin A1c
 - **Relative risk:**
- Inoue, K., Matsumoto, M., & Akimoto, K. (2008) Fasting plasma glucose and HbA<sub>1c</sub> as risk factors for Type 2 diabetes. *Diabetic Medicine*, 25(10), 1157-1163. [DOI: 10.1111/j.1464-5491.2008.02572.x](https://doi.org/10.1111/j.1464-5491.2008.02572.x)
  - JBI Score: 100%. [See report](jbi-reports/Inoue%20et%20al.%20(2008).md)

 - **Prevalence:**

### Hepatitis C
 - **Relative risk:**
- Fabiani, S., Fallahi, P., Ferrari, S. M., Miccoli, M., & Antonelli, A. (2018) Hepatitis C virus infection and development of type 2 diabetes mellitus: Systematic review and meta-analysis of the literature. *Reviews in Endocrine and Metabolic Disorders*, 19(4), 405-420. [DOI: 10.1007/s11154-017-9440-1](https://doi.org/10.1007/s11154-017-9440-1)
  - JBI Score: 86.5%. [See report](jbi-reports/Fabiani%20et%20al.%20(2018).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
- Gress, T. W., Nieto, F. J., Shahar, E., Wofford, M. R., & Brancati, F. L. (2000) Hypertension and Antihypertensive Therapy as Risk Factors for Type 2 Diabetes Mellitus. *New England Journal of Medicine*, 342(13), 905-912. [DOI: 10.1056/NEJM200003303421301](https://doi.org/10.1056/NEJM200003303421301)
  - JBI Score: 90.9%. [See report](jbi-reports/Gress%20et%20al.%20(2000).md)

 - **Prevalence:**

### Interleukin 6 (IL-6)
 - **Relative risk:**
- Bertoni, A. G., Burke, G. L., Owusu, J. A., Carnethon, M. R., Vaidya, D., Barr, R. G., ... Rotter, J. I. (2010) Inflammation and the Incidence of Type 2 Diabetes. *Diabetes Care*, 33(4), 804-810. [DOI: 10.2337/dc09-1679](https://doi.org/10.2337/dc09-1679)
  - JBI Score: 90.9%. [See report](jbi-reports/Bertoni%20et%20al.%20(2010).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Smith, A. D., Crippa, A., Woodcock, J., & Brage, S. (2016) Physical activity and incident type 2 diabetes mellitus: a systematic review and dose–response meta-analysis of prospective cohort studies. *Diabetologia*, 59(12), 2527-2545. [DOI: 10.1007/s00125-016-4079-0](https://doi.org/10.1007/s00125-016-4079-0)
  - JBI Score: 86.4%. [See report](jbi-reports/Smith%20et%20al.%20(2016).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
- Menke, A., Casagrande, S., Geiss, L., & Cowie, C. C. (2015) Prevalence of and Trends in Diabetes Among Adults in the United States, 1988-2012. *JAMA*, 314(10), 1021. [DOI: 10.1001/jama.2015.10029](https://doi.org/10.1001/jama.2015.10029)
  - JBI Score: 100%. [See report](jbi-reports/Menke%20et%20al.%20(2015).md)

 - **Prevalence:**

### Sedentary behaviour
 - **Relative risk:**
- Grøntved, A. (2011) Television Viewing and Risk of Type 2 Diabetes, Cardiovascular Disease, and All-Cause Mortality. *JAMA*, 305(23), 2448. [DOI: 10.1001%2Fjama.2011.812](https://doi.org/10.1001%2Fjama.2011.812)
  - JBI Score: 86.4%. [See report](jbi-reports/Grontved%20%26%20Hu%20(2011).md)

 - **Prevalence:**

### Sleep
 - **Relative risk:**
- Cappuccio, F. P., D'Elia, L., Strazzullo, P., & Miller, M. A. (2010) Quantity and Quality of Sleep and Incidence of Type 2 Diabetes. *Diabetes Care*, 33(2), 414-420. [DOI: 10.2337/dc09-1124](https://doi.org/10.2337/dc09-1124)
  - JBI Score: 86.4%. [See report](jbi-reports/Cappuccio%20et%20al.%20(2010).md)

 - **Prevalence:**

### Sleep apnea
 - **Relative risk:**
- WANG, X., BI, Y., ZHANG, Q., & PAN, F. (2013) Obstructive sleep apnoea and the risk of type 2 diabetes: A meta‐analysis of prospective cohort studies. *Respirology*, 18(1), 140-146. [DOI: 10.1111/j.1440-1843.2012.02267.x](https://doi.org/10.1111/j.1440-1843.2012.02267.x)

 - **Prevalence:**

### Sugar sweetened beverages
 - **Relative risk:**
- Imamura, F., O’Connor, L., Ye, Z., Mursu, J., Hayashino, Y., Bhupathiraju, S. N., ... Forouhi, N. G. (2015) Consumption of sugar sweetened beverages, artificially sweetened beverages, and fruit juice and incidence of type 2 diabetes: systematic review, meta-analysis, and estimation of population attributable fraction. *BMJ*, h3576. [DOI: 10.1136/bmj.h3576](https://doi.org/10.1136/bmj.h3576)
  - JBI Score: 86.4%. [See report](jbi-reports/Imamura%20et%20al.%20(2015).md)

 - **Prevalence:**

### Waist circumference
 - **Relative risk:**
- Feller, S., Boeing, H., & Pischon, T. (2010) Body Mass Index, Waist Circumference, and the Risk of Type 2 Diabetes Mellitus. *Deutsches Ärzteblatt international*. [DOI: 10.3238/arztebl.2010.0470](https://doi.org/10.3238/arztebl.2010.0470)
- Vazquez, G., Duval, S., Jacobs, D. R., Jr, & Silventoinen, K. (2007)
  - JBI Score: 90.9%. [See report](jbi-reports/Feller%20et%20al.%20(2010).md)

 - **Prevalence:**

### Whole grain consumption
 - **Relative risk:**
- Aune, D., Norat, T., Romundstad, P., & Vatten, L. J. (2013) Whole grain and refined grain consumption and the risk of type 2 diabetes: a systematic review and dose–response meta-analysis of cohort studies. *European Journal of Epidemiology*, 28(11), 845-858. [DOI: 10.1007/s10654-013-9852-5](https://doi.org/10.1007/s10654-013-9852-5)
  - JBI Score: 86.4%. [See report](jbi-reports/Aune%20et%20al.%20(2013).md)

 - **Prevalence:**

## Generalized anxiety disorder
### ACEs-Childhood maltreatment
 - **Relative risk:**
- Whitaker et al. (2021)
  - JBI Score: 87.5%. [See report](jbi-reports/Whitaker%20et%20al.%20(2021).md)
- Bellis et al. (2019)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Mojtabai, R., & Crum, R. M. (2013) Cigarette Smoking and Onset of Mood and Anxiety Disorders. *American Journal of Public Health*, 103(9), 1656-1665. [DOI: 10.2105%2FAJPH.2012.300911](https://doi.org/10.2105%2FAJPH.2012.300911)
  - JBI Score: 86.4%. [See report](jbi-reports/Mojtabai%20%26%20Crum%20(2013).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Beesdo et al. (2010)
  - JBI Score: 100%. [See report](jbi-reports/Beesdo%20et%20al.%20(2010).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Sanchez-Villegas et al. (2007)
  - JBI Score: 95.5%. [See report](jbi-reports/Sanchez-Villegas%20et%20al.%20(2007).md)

 - **Prevalence:**

### Previous mental disorders
 - **Relative risk:**
- Beesdo et al. (2010)
- Alonso et al. (2004)
  - JBI Score: 90.0%. [See report](jbi-reports/Alonso%20et%20al.%20(2004).md)

 - **Prevalence:**

### Sedentary behaviour
 - **Relative risk:**
- Allen et al. (2019)
  - JBI Score: 100%. [See report](jbi-reports/Allen%20et%20al.%20(2019).md)

 - **Prevalence:**

### Substance abuse
 - **Relative risk:**
- Brook et al. (2016)
- Vesga-Lopez et al. (2008)

 - **Prevalence:**

### Work stress-Job strain
 - **Relative risk:**
- Niedhammer et al. (2015)
  - JBI Score: 100%. [See report](jbi-reports/Niedhammer%20et%20al.%20(2015).md)

 - **Prevalence:**

## Hypertension
### Age
 - **Relative risk:**
- Muntner et al. (2022)
  - JBI Score: 100%. [See report](jbi-reports/Muntner%20et%20al.%20(2022).md)
- [Ostchega et al. (2020)](https://www.cdc.gov/nchs/products/databriefs/db364.htm)

### Alcohol
 - **Relative risk:**
- Sesso et al. (2008)
- Briasoulis et al. (2012)
    - JBI Score: 86.4%. [See report](jbi-reports/Briasoulis%20et%20al.%20(2012).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
- Hu et al. (2004)
    - JBI Score: 90.9%. [See report](jbi-reports/Hu%20et%20al.%20(2004).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Ranasinghe et al. (2015)
- Igarashi et al. (2016)
    - JBI Score: 100%. [See report](jbi-reports/Igarashi%20et%20al.%20(2016).md)

 - **Prevalence:**

### Fruit and vegetable consumption
 - **Relative risk:**
- Li et al. (2015)
    - JBI Score: 90.9%. [See report](jbi-reports/Li%20et%20al.%20(2015).md)
- Fan et al. (2010)

 - **Prevalence:**

### Oral contraceptive use
 - **Relative risk:**
- Liu et al. (2017)
    - JBI Score: 86.4%. [See report](jbi-reports/Liu%20et%20al.%20(2017).md)
- Daniels & Abma (2020)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Warburton et al. (2010)
- Williams & Thompson (2013)
- Hu et al. (2004)
    - JBI Score: 90.9%. [See report](jbi-reports/Hu%20et%20al.%20(2004).md)

 - **Prevalence:**

### Premature birth
 - **Relative risk:**
- Crump, C., Sundquist, J., & Sundquist, K. (2020) Risk of hypertension into adulthood in persons born prematurely: a national cohort study. *European Heart Journal*, 41(16), 1542-1550. [DOI: 10.1093/eurheartj/ehz904](https://doi.org/10.1093/eurheartj/ehz904)
    - JBI Score: 95.5%. [See report](jbi-reports/Crump%20et%20al.%20(2020).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
- Bundy et al. (2018)
    - JBI Score: 87.5%. [See report](jbi-reports/Bundy%20et%20al.%20(2018).md)

 - **Prevalence:**

### Sleep
 - **Relative risk:**
- Li et al. (2019)
    - JBI Score: 100%. [See report](jbi-reports/Li%20et%20al.%20(2019).md)
- Song et al. (2016)
    - JBI Score: 95.5%. [See report](jbi-reports/Song%20et%20al.%20(2016).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Pickering, Eguchi & Kario (2007)

 - **Prevalence:**

### Sodium intake
 - **Relative risk:**
- Filippini et al. (2022)
    - JBI Score: 90.9%. [See report](jbi-reports/Filippini%20et%20al.%20(2022).md)
- Forman et al. (2012)
- Ford, E. S., & Cooper, R. S. (1991) Risk factors for hypertension in a national cohort study.. *Hypertension*, 18(5), 598-606. [DOI: 10.1161/01.HYP.18.5.598](https://doi.org/10.1161/01.HYP.18.5.598)
    - JBI Score: 90.9%. [See report](jbi-reports/Ford%20%26%20Cooper%20(1991).md)

 - **Prevalence:**

## Kidney cancer
### BMI
 - **Relative risk:**
- Adams, K. F., Leitzmann, M. F., Albanes, D., Kipnis, V., Moore, S. C., Schatzkin, A., ... Chow, W. (2008) Body Size and Renal Cell Cancer Incidence in a Large US Cohort Study. *American Journal of Epidemiology*, 168(3), 268-277. [DOI: 10.1093/aje/kwn122](https://doi.org/10.1093/aje/kwn122)
    - JBI Score: 100%. [See report](jbi-reports/Adams%20et%20al.%20(2008).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Cumberbatch, M. G., Rota, M., Catto, J. W., & La Vecchia, C. (2016) The Role of Tobacco Smoke in Bladder and Kidney Carcinogenesis: A Comparison of Exposures and Meta-analysis of Incidence and Mortality Risks. *European Urology*, 70(3), 458-466. [DOI: 10.1016/j.eururo.2015.06.042](https://doi.org/10.1016/j.eururo.2015.06.042)
    - JBI Score: 86.4%. [See report](jbi-reports/Cumberbatch%20et%20al.%20(2016).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Bao, C., Yang, X., Xu, W., Luo, H., Xu, Z., Su, C., ... Qi, X. (2013) Diabetes mellitus and incidence and mortality of kidney cancer: A meta-analysis. *Journal of Diabetes and its Complications*, 27(4), 357-364. [DOI: 10.1016/j.jdiacomp.2013.01.004](https://doi.org/10.1016/j.jdiacomp.2013.01.004)
    - JBI Score: 95.5%. [See report](jbi-reports/Bao%20et%20al.%20(2013).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Clague, J., Lin, J., Cassidy, A., Matin, S., Tannir, N. M., Tamboli, P., ... Wu, X. (2009) Family History and Risk of Renal Cell Carcinoma: Results from a Case-Control Study and Systematic Meta-Analysis. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 18(3), 801-807. [DOI: 10.1158/1055-9965.epi-08-0601](https://doi.org/10.1158/1055-9965.epi-08-0601)
    - JBI Score: 95.5%. [See report](jbi-reports/Clague%20et%20al.%20(2009).md)

 - **Prevalence:**

### Hepatitis C
 - **Relative risk:**
- Gordon, S. C., Moonka, D., Brown, K. A., Rogers, C., Huang, M. A. Y., Bhatt, N., ... Lamerato, L. (2010) Risk for Renal Cell Carcinoma in Chronic Hepatitis C Infection. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 19(4), 1066-1073. [DOI: 10.1158/1055-9965.epi-09-1275](https://doi.org/10.1158/1055-9965.epi-09-1275)
    - JBI Score: 100%. [See report](jbi-reports/Gordon%20et%20al.%20(2010).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
- Hidayat, K., Du, X., Zou, S., & Shi, B. (2017) Blood pressure and kidney cancer risk. *Journal of Hypertension*, 35(7), 1333-1344. [DOI: 10.1097/hjh.0000000000001286](https://doi.org/10.1097/hjh.0000000000001286)
    - JBI Score: 100%. [See report](jbi-reports/Hidayat%20et%20al.%20(2017).md)

### Kidney stones
 - **Relative risk:**
- Cheungpasitporn, W., Thongprayoon, C., O’Corragain, O., Edmonds, P., Ungprasert, P., Kittanamongkolchai, W., ... Erickson, S. (2015) The risk of kidney cancer in patients with kidney stones: a systematic review and meta-analysis. *QJM*, 108(3), 205-212. [DOI: 10.1093/qjmed/hcu195](https://doi.org/10.1093/qjmed/hcu195)
    - JBI Score: 100%. [See report](jbi-reports/Cheungpasitporn%20et%20al.%20(2015).md)

 - **Prevalence:**

## Lung cancer
### Asbestos exposure
 - **Relative risk:**
- Moon et al. (2013)
    - JBI Score: 86.4%. [See report](jbi-reports/Moon%20et%20al.%20(2013).md)
- Nielsen et al. (2014)
- Fenton et al. (2023)
    - JBI Score: 88.9%. [See report](jbi-reports/Fenton%20et%20al.%20(2023).md)

### BMI
 - **Relative risk:**
- Zhu, H., & Zhang, S. (2018) Body mass index and lung cancer risk in never smokers: a meta-analysis. *BMC Cancer*, 18(1). [DOI: 10.1186/s12885-018-4543-y](https://doi.org/10.1186/s12885-018-4543-y)
    - JBI Score: 100.0%. [See report](jbi-reports/Zhu%20%26%20Zhang%20(2018).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- [Lee et al. (2013)](http://dx.doi.org/10.1016/j.ejca.2013.02.025)
    - JBI Score: 95.5%. [See report](jbi-reports/Lee%20et%20al.%20(2013).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Cannon-Albright et al. (2019)
    - JBI Score: 81.8%. [See report](jbi-reports/Cannon-Albright%20et%20al.%20(2019).md)
- Matakidou, A., Eisen, T., & Houlston, R. S. (2005) Systematic review of the relationship between family history and lung cancer risk. *British Journal of Cancer*, 93(7), 825-833. [DOI: 10.1038/sj.bjc.6602769](https://doi.org/10.1038/sj.bjc.6602769)
    - JBI Score: 86.4%. [See report](jbi-reports/Matakidou%20et%20al.%20(2005).md)

 - **Prevalence:**

### Inflammation and lung disease
 - **Relative risk:**
- Ntritsos et al. (2022)
    - JBI Score: 100%. [See report](jbi-reports/Ntritsos%20et%20al.%20(2022).md)
- Littman et al. (2004)
    - JBI Score: 95.5%. [See report](jbi-reports/Littman%20et%20al.%20(2004).md)
- Zhang et al. (2017)
    - JBI Score: 86.4%. [See report](jbi-reports/Zhang%20et%20al.%20(2017).md)
- Miramontes et al. (2015)
    - JBI Score: 100.0%. [See report](jbi-reports/Miramontes%20et%20al.%20(2015).md)
- OReilly et al. (2023)
- Brenner et al. (2012)
    - JBI Score: 86.4%. [See report](jbi-reports/Brenner%20et%20al.%20(2012).md)

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
    - JBI Score: 100% [See report](jbi-reports/Levesque%20%26%20Mischki%20(2021).md)
- Kim et al. (2015)
    - JBI Score: 86.4% [See report](jbi-reports/Kim%20et%20al.%20(2015).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- OKeeffe et al. (2018)
    - JBI Score: 100% [See report](jbi-reports/O'Keefe%20et%20al.%20(2018).md)

 - **Prevalence:**

## Osteoporosis
### Age
 - **Relative risk:**
- Kanis, J. A., Johnell, O., Oden, A., De Laet, C., Dawson, A., & Jonsson, B. (2001) Ten Year Probabilities of Osteoporotic Fractures According to BMD and Diagnostic Thresholds. *Osteoporosis International*, 12(12), 989-995. [DOI: 10.1007/s001980170006](https://doi.org/10.1007/s001980170006)
    - JBI Score: 95.5% [See report](jbi-reports/Kanis%20et%20al.%20(2001).md)

 - **Prevalence:**

### Alcohol
 - **Relative risk:**
- Berg, K. M., Kunins, H. V., Jackson, J. L., Nahvi, S., Chaudhry, A., Harris, K. A., ... Arnsten, J. H. (2008) Association Between Alcohol Consumption and Both Osteoporotic Fracture and Bone Density. *The American Journal of Medicine*, 121(5), 406-418. [DOI: 10.1016%2Fj.amjmed.2007.12.012](https://doi.org/10.1016%2Fj.amjmed.2007.12.012)
    - JBI Score: 100.0% [See report](jbi-reports/Berg%20et%20al.%20(2008).md)

### BMI
 - **Relative risk:**
- De Laet, C., Kanis, J. A., Odén, A., Johanson, H., et al. (2005)
    - JBI Score: 86.4% [See report](jbi-reports/De%20Laet%20et%20al.%20(2005).md)

 - **Prevalence:**

### Breast cancer
 - **Relative risk:**
- Lee, S., Yoo, J., Lee, Y., Park, J., Won, S., Yeom, J., ... Koo, K. (2020) Risk of Osteoporotic Fracture in Patients with Breast Cancer: Meta-Analysis. *Journal of Bone Metabolism*, 27(1), 27. [DOI: 10.11005%2Fjbm.2020.27.1.27](https://doi.org/10.11005%2Fjbm.2020.27.1.27)
    - JBI Score: 86.4% [See report](jbi-reports/Lee%20et%20al.%20(2020).md)

 - **Prevalence:**

### Celiac disease
 - **Relative risk:**
- Heikkilä, K., Pearce, J., Mäki, M., & Kaukinen, K. (2015)
    - JBI Score: 86.4% [See report](jbi-reports/Heikkilä%20et%20al.%20(2015).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Wang, J., You, W., Jing, Z., Wang, R., Fu, Z., & Wang, Y. (2016) Increased risk of vertebral fracture in patients with diabetes: a meta-analysis of cohort studies. *International Orthopaedics*, 40(6), 1299-1307. [DOI: 10.1007/s00264-016-3146-y](https://doi.org/10.1007/s00264-016-3146-y)

 - **Prevalence:**

### Epilepsy
 - **Relative risk:**
- Vestergaard P. (2005)
    - JBI Score: 95.5% [See report](jbi-reports/Vestergaard%20(2005).md)

 - **Prevalence:**

### Family history of fractures
 - **Relative risk:**
- Kanis, J., Johansson, H., Oden, A., Johnell, O., De Laet, C., Eisman, J., ... Tenenhouse, A. (2004) A family history of fracture and fracture risk: a meta-analysis. *Bone*, 35(5), 1029-1037. [DOI: 10.1016/j.bone.2004.06.017](https://doi.org/10.1016/j.bone.2004.06.017)
    - JBI Score: 81.8% [See report](jbi-reports/Kanis%20et%20al.%20(2004).md)

 - **Prevalence:**

### Glucocorticoid replacement therapy
 - **Relative risk:**
- Li, L., Bensing, S., & Falhammar, H. (2021) Rate of fracture in patients with glucocorticoid replacement therapy: a systematic review and meta-analysis. *Endocrine*, 74(1), 29-37. [DOI: 10.1007/s12020-021-02723-z](https://doi.org/10.1007/s12020-021-02723-z)
    - JBI Score: 95.5% [See report](jbi-reports/Li%20et%20al.%20(2021).md)

 - **Prevalence:**

### Irritable bowel syndrome
 - **Relative risk:**
- Wongtrakul, W., Charoenngam, N., & Ungprasert, P. (2020) The association between irritable bowel syndrome and osteoporosis: a systematic review and meta-analysis. *Osteoporosis International*, 31(6), 1049-1057. [DOI: 10.1007/s00198-020-05318-y](https://doi.org/10.1007/s00198-020-05318-y)
    - JBI Score: 100.0% [See report](jbi-reports/Wongtrakul%20et%20al.%20(2020).md)

 - **Prevalence:**

### Previous fracture
 - **Relative risk:**
- Kanis, J. A., Johnell, O., Oden, A., Johansson, H., De Laet, C., Eisman, J. A., ... Tenenhouse, A. (2005) Smoking and fracture risk: a meta-analysis. *Osteoporosis International*, 16(2), 155-162. [DOI: 10.1007/s00198-004-1640-3](https://doi.org/10.1007/s00198-004-1640-3)

 - **Prevalence:**

### Race
 - **Relative risk:**
- Bao, Y., Xu, Y., Li, Z., & Wu, Q. (2023) Racial and ethnic difference in the risk of fractures in the United States: a systematic review and meta-analysis. *Scientific Reports*, 13(1). [DOI: 10.1038/s41598-023-32776-1](https://doi.org/10.1038/s41598-023-32776-1)
    - JBI Score: 100.0% [See report](jbi-reports/Bao%20et%20al.%20(2023).md)

 - **Prevalence:**

### Rheumatoid arthritis
 - **Relative risk:**
- Jin, S., Hsieh, E., Peng, L., Yu, C., Wang, Y., Wu, C., ... Zeng, X. (2018) Incidence of fractures among patients with rheumatoid arthritis: a systematic review and meta-analysis. *Osteoporosis International*, 29(6), 1263-1275. [DOI: 10.1007/s00198-018-4473-1](https://doi.org/10.1007/s00198-018-4473-1)
    - JBI Score: 100.0% [See report](jbi-reports/Jin%20et%20al.%20(2018).md)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Kanis, J. A., Johnell, O., Oden, A., Johansson, H., De Laet, C., Eisman, J. A., ... Tenenhouse, A. (2005) Smoking and fracture risk: a meta-analysis. *Osteoporosis International*, 16(2), 155-162. [DOI: 10.1007/s00198-004-1640-3](https://doi.org/10.1007/s00198-004-1640-3)
    - JBI Score: 86.4% [See report](jbi-reports/Kanis%20et%20al.%20(2005).md)

 - **Prevalence:**

### Subclinical hyperthyroidism
 - **Relative risk:**
- Blum, M. R., Bauer, D. C., Collet, T. H., Fink, H. A., Cappola, A. R., da Costa, B. R., Wirth, C. D., et al. (2015)
    - JBI Score: 95.5% [See report](jbi-reports/Blum%20et%20al.%20(2015).md)

 - **Prevalence:**

## Ovarian cancer
### Asbestos exposure
 - **Relative risk:**
- Camargo, M. C., Stayner, L. T., Straif, K., Reina, M., Al-Alem, U., Demers, P. A., ... Landrigan, P. J. (2011) Occupational Exposure to Asbestos and Ovarian Cancer: A Meta-analysis. *Environmental Health Perspectives*, 119(9), 1211-1217. [DOI: 10.1289/ehp.1003283](https://doi.org/10.1289/ehp.1003283)
    - JBI Score: 86.4% [See report](jbi-reports/Camargo%20et%20al.%20(2011).md)

 - **Prevalence:**

### Breastfeeding
 - **Relative risk:**
- Li, D., Du, C., Zhang, Z., Li, G., Yu, Z., Wang, X., ... Zhao, Y. (2014) Breastfeeding and Ovarian Cancer Risk: a Systematic Review and Meta-analysis of 40 Epidemiological Studies. *Asian Pacific Journal of Cancer Prevention*, 15(12), 4829-4837. [DOI: 10.7314/apjcp.2014.15.12.4829](https://doi.org/10.7314/apjcp.2014.15.12.4829)
    - JBI Score: 100.0% [See report](jbi-reports/Li%20et%20al.%20(2014).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Stratton, J. F., Pharoah, P., Smith, S. K., Easton, D., & Ponder, B. A. J. (1998) A systematic review and meta‐analysis of family history and risk of ovarian cancer. *BJOG: An International Journal of Obstetrics &amp; Gynaecology*, 105(5), 493-499. [DOI: 10.1111/j.1471-0528.1998.tb10148.x](https://doi.org/10.1111/j.1471-0528.1998.tb10148.x)
    - JBI Score: 86.4% [See report](jbi-reports/Stratton%20et%20al.%20(1998).md)

 - **Prevalence:**

### High parity and Oral contraception
 - **Relative risk:**
- Tsilidis, K. K., Allen, N. E., Key, T. J., Dossus, L., Lukanova, A., Bakken, K., et al. (2011)
    - JBI Score: 90.9% [See report](jbi-reports/Tsilidis%20et%20al.%20(2011).md)

 - **Prevalence:**

### Hysterectomy and tubal ligation
 - **Relative risk:**
- Rice, M. S., Murphy, M. A., & Tworoger, S. S. (2012) Tubal ligation, hysterectomy and ovarian cancer: A meta-analysis. *Journal of Ovarian Research*, 5(1), 13. [DOI: 10.1186/1757-2215-5-13](https://doi.org/10.1186/1757-2215-5-13)
    - JBI Score: 81.8% [See report](jbi-reports/Rice%20et%20al.%20(2012).md)

 - **Prevalence:**

## Pancreatic cancer
### Alcohol
 - **Relative risk:**
- Tramacere, I., Scotti, L., Jenab, M., Bagnardi, V., Bellocco, R., Rota, M., ... La Vecchia, C. (2010) Alcohol drinking and pancreatic cancer risk: a meta‐analysis of the dose‐risk relation. *International Journal of Cancer*, 126(6), 1474-1486. [DOI: 10.1002/ijc.24936](https://doi.org/10.1002/ijc.24936)
    - JBI Score: 95.5% [See report](jbi-reports/Tramacere%20et%20al.%20(2010).md)

 - **Prevalence:**

### BMI
 - **Relative risk:**
- Larsson, S. C., Orsini, N., & Wolk, A. (2007) Body mass index and pancreatic cancer risk: A meta‐analysis of prospective studies. *International Journal of Cancer*, 120(9), 1993-1998. [DOI: 10.1002/ijc.22535](https://doi.org/10.1002/ijc.22535)
    - JBI Score: 95.5% [See report](jbi-reports/Larsson%20et%20al.%20(2007).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- Ben, Q., Xu, M., Ning, X., Liu, J., Hong, S., Huang, W., ... Li, Z. (2011) Diabetes mellitus and risk of pancreatic cancer: A meta-analysis of cohort studies. *European Journal of Cancer*, 47(13), 1928-1937. [DOI: 10.1016/j.ejca.2011.03.003](https://doi.org/10.1016/j.ejca.2011.03.003)
    - JBI Score: 86.4% [See report](jbi-reports/Ben%20et%20al.%20(2011).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Permuth-Wey, J., & Egan, K. M. (2009) Family history is a significant risk factor for pancreatic cancer: results from a systematic review and meta-analysis. *Familial Cancer*, 8(2), 109-117. [DOI: 10.1007/s10689-008-9214-8](https://doi.org/10.1007/s10689-008-9214-8)
    - JBI Score: 95.5% [See report](jbi-reports/Permuth-Wey%20%26%20Egan%20(2009).md)

 - **Prevalence:**

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Lugo, A., Peveri, G., Bosetti, C., Bagnardi, V., Crippa, A., Orsini, N., ... Gallus, S. (2018) Strong excess risk of pancreatic cancer for low frequency and duration of cigarette smoking: A comprehensive review and meta-analysis. *European Journal of Cancer*, 104, 117-126. [DOI: 10.1016/j.ejca.2018.09.007](https://doi.org/10.1016/j.ejca.2018.09.007)
    - JBI Score: 86.4% [See report](jbi-reports/Lugo%20et%20al.%20(2018).md)

 - **Prevalence:**

## Prostate cancer
### 5-a reductase inhibitors
 - **Relative risk:**
- [Hu, X., Wang, Y., Yang, Z., Shao, Y., Yang, W., & Li, X. (2020)](http://dx.doi.org/10.21037/tau-20-843)
    - JBI Score: 100% [See report](jbi-reports/Hu%20et%20al.%20(2020).md)

 - **Prevalence:**

### Ejaculation frequency
 - **Relative risk:**
- Rider, J. R., Wilson, K. M., Sinnott, J. A., Kelly, R. S., Mucci, L. A., & Giovannucci, E. L. (2016) Ejaculation Frequency and Risk of Prostate Cancer: Updated Results with an Additional Decade of Follow-up. *European Urology*, 70(6), 974-982. [DOI: 10.1016/j.eururo.2016.03.027](https://doi.org/10.1016/j.eururo.2016.03.027)
    - JBI Score: 100% [See report](jbi-reports/Rider%20et%20al.%20(2016).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Watkins Bruner, D., Moore, D., Parlanti, A., Dorgan, J., & Engstrom, P. (2003) Relative risk of prostate cancer for men with affected relatives: Systematic review and meta‐analysis. *International Journal of Cancer*, 107(5), 797-803. [DOI: 10.1002/ijc.11466](https://doi.org/10.1002/ijc.11466)
    - JBI Score: 86.4% [See report](jbi-reports/Bruner%20et%20al.%20(2003).md)

 - **Prevalence:**

### Sexual activity and STIs
 - **Relative risk:**
- Dennis, L. K., & Dawson, D. V. (2002) Meta-Analysis of Measures of Sexual Activity and Prostate Cancer. *Epidemiology*, 13(1), 72-79. [DOI: 10.1097/00001648-200201000-00012](https://doi.org/10.1097/00001648-200201000-00012)
    - JBI Score: 86.4% [See report](jbi-reports/Dennis%20%26%20Dawson%20(2002).md)

 - **Prevalence:**

### Tomato sauce
 - **Relative risk:**
- Graff, R. E., Pettersson, A., Lis, R. T., Ahearn, T. U., Markt, S. C., Wilson, K. M., ... Mucci, L. A. (2016) Dietary lycopene intake and risk of prostate cancer defined by ERG protein expression. *The American Journal of Clinical Nutrition*, 103(3), 851-860. [DOI: 10.3945/ajcn.115.118703](https://doi.org/10.3945/ajcn.115.118703)
    - JBI Score: 95.5% [See report](jbi-reports/Graff%20et%20al.%20(2016).md)

 - **Prevalence:**

## Skin cancer (Melanoma)
### Alcohol
 - **Relative risk:**
- Rivera, A., Nan, H., Li, T., Qureshi, A., & Cho, E. (2016) Alcohol Intake and Risk of Incident Melanoma: A Pooled Analysis of Three Prospective Studies in the United States. *Cancer Epidemiology, Biomarkers &amp; Prevention*, 25(12), 1550-1558. [DOI: 10.1158%2F1055-9965.EPI-16-0303](https://doi.org/10.1158%2F1055-9965.EPI-16-0303)
    - JBI Score: 100% [See report](jbi-reports/Rivera%20et%20al.%20(2016).md)

 - **Prevalence:**

### Eye colour, family history, hair colour
 - **Relative risk:**
- Gandini, S., Sera, F., Cattaruzza, M. S., Pasquini, P., Zanetti, R., Masini, C., ... Melchi, C. F. (2005) Meta-analysis of risk factors for cutaneous melanoma: III. Family history, actinic damage and phenotypic factors. *European Journal of Cancer*, 41(14), 2040-2059. [DOI: 10.1016/j.ejca.2005.03.034](https://doi.org/10.1016/j.ejca.2005.03.034)
    - JBI Score: 81.8% [See report](jbi-reports/Gandini%20et%20al.%20(2005).md)

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
    - JBI Score: 100% [See report](jbi-reports/Strazzullo%20et%20al.%20(2010).md)

 - **Prevalence:**

### Coronary heart disease
 - **Relative risk:**
- Benjamin et al. (2019)
- Li et al. (2005)
    - JBI Score: 95.5% [See report](jbi-reports/Li%20et%20al.%20(2005).md)

 - **Prevalence:**

### Diabetes - Type 2
 - **Relative risk:**
- [Peters, Huxley, & Woodward (2014)](http://dx.doi.org/10.1016/S0140-6736(14)60040-4 )
    - JBI Score: 100% [See report](jbi-reports/Peters%20et%20al.%20(2014).md)

 - **Prevalence:**

### Family history
 - **Relative risk:**
- Yu et al. (2019)
    - JBI Score: 100% [See report](jbi-reports/Yu%20et%20al.%20(2019).md)
- Liao et al. (1997)
    - JBI Score: 100% [See report](jbi-reports/Liao%20et%20al.%20(1997).md)

 - **Prevalence:**

### Fruit and vegetable consumption
 - **Relative risk:**
- [He, Nowson, & MacGregor (2006)](https://doi.org/10.1016/S0140-6736(06)68069-0)
    - JBI Score: 100% [See report](jbi-reports/He%20et%20al.%20(2006).md)

 - **Prevalence:**

### Hypertension
 - **Relative risk:**
- O_Donnell et al. (2016)
    - JBI Score: 100% [See report](jbi-reports/O'Donnell%20et%20al.%20(2016).md)

 - **Prevalence:**

### Oral contraceptives
 - **Relative risk:**
- Li et al. (2019)
    - JBI Score: 100% [See report](jbi-reports/Li%20et%20al.%20(2019).md)

 - **Prevalence:**

### Physical activity
 - **Relative risk:**
- Lee, C. D., Folsom, A. R., & Blair, S. N. (2003) Physical Activity and Stroke Risk. *Stroke*, 34(10), 2475-2481. [DOI: 10.1161/01.STR.0000091843.02517.9D](https://doi.org/10.1161/01.STR.0000091843.02517.9D)
    - JBI Score: 86.4% [See report](jbi-reports/Lee%20et%20al.%20(2003).md)

 - **Prevalence:**

### Race
 - **Relative risk:**
- Tsao et al. (2023)

 - **Prevalence:**

### Smoking - cigarettes
 - **Relative risk:**
- Kelly et al. (2008)
- Peters et al. (2013)
    - JBI Score: 81.8% [See report](jbi-reports/Peters%20et%20al.%20(2013).md)

 - **Prevalence:**

### Sodium intake
 - **Relative risk:**
- [Jackson et al. (2016)](https://www.cdc.gov/mmwr/preview/mmwrhtml/mm6452a1.htm#:~:text=During%202009%E2%80%932012%2C%20most%20Americans,exceeded%202%2C300%20mg%20per%20day)
    - JBI Score: 100% [See report](jbi-reports/Jackson%20et%20al.%20(2016).md)
- Strazzullo et al. (2009)
    - JBI Score: 100% [See report](jbi-reports/Strazzullo%20et%20al.%20(2009).md)

 - **Prevalence:**
