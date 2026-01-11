****************************************************
* DO-FILE:     BRFSS_AI_Depression_Labels.do
* PROJECT:     AI Prediction of Self-Reported Depression
* DATASET:     BRFSS 2023 - Tennessee Subset
* VARIABLES:   59 predictors for AI/ML modeling
* AUTHORs:     Mustapha Aliyu Muhammad $ Jamilu Sani
* DATE:        19th July, 2025
****************************************************

* 1. Set working directory
cd "C:\Users\maliy\Downloads\BRFSS ML Depression Project\Data"

* 2. Load dataset (Stata .dta format)
use "Selected_BRFSS_Cleaned_Nomiss_Final.dta", clear

* 3. Collinearity investigation
* VIF investigation
regress depression_dx self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category num_children education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat

estat vif

* 4. Univariate table with all the covariates
* Univariate frequency tables for categorical variables
foreach var in depression_dx self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children {
    tabulate `var', missing
}

* 5. Bivariate Table with the covariates
* Example: Bivariate table for age group with row percentages
tabulate age_group_6cat depression_dx, row

* Loop through multiple variables for consistency
local vars self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children

foreach var of local vars {
    di "---------------------------------------------------"
    di "Row % bivariate table: `var' vs. depression_dx"
    tabulate `var' depression_dx, row
}


* 6. Logistic Regression
* Unadjusted Model - All Predictors are Categorical

local predictors self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category num_children education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat

foreach var of local predictors {
    di "---------------------------------------------------"
    di "Unadjusted logistic regression for: `var'"
    logistic depression_dx i.`var'
}


* 7. Stata Code to Run Adjusted Logistic Regression Model
* Adjusted Model - All Predictors are Categorical

logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.physically_active i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.num_children i.education_level i.smoking_status i.drank_past_30d i.home_ownership i.veteran_status i.pregnant_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.Cancer_diagnosis i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat


********************************************************************************
* Weighted Analysis of the study
* Univariate, Bivariate, Simple and Adjusted Logistic Regression
********************************************************************************

* Fitting the weighted analysis
* BRFSS 2023 design variables
svyset _psu [pweight = _llcpwt], strata(_ststr) vce(linearized) singleunit(centered)

* Weighted univariate tables for categorical variables
* Frequency
local covars depression_dx self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children

foreach var of local covars {
    di "---------------------------------------------------"
    di "Weighted Univariate Frequency for: `var'"
    svy: tabulate `var', count format(%15.0fc) missing
}

* Percentages
local covars depression_dx self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children

foreach var of local covars {
    di "---------------------------------------------------"
    di "Weighted Univariate Frequency for: `var'"
    svy: tabulate `var', percent missing
}

* Weighted Bivariate tables for the categorical variables
*Percentages
local covars self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children
foreach var of local covars {
    di "---------------------------------------------------"
    di "Weighted Row % Bivariate Table: `var' vs. depression_dx"
    svy: tabulate `var' depression_dx, row percent missing
}

* Frequency
local covars self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children
foreach var of local covars {
    di "---------------------------------------------------"
    di "Weighted Row % Bivariate Table: `var' vs. depression_dx"
    svy: tabulate `var' depression_dx, row count format(%15.0fc) missing
}


* Weighted Unadjusted Logistic Regressions
local predictors self_health_good poor_phys_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary disability_Cat num_children

foreach var of local predictors {
    di "---------------------------------------------------"
    di "Weighted Unadjusted Logistic Regression for: `var'"
    svy: logistic depression_dx i.`var'
}

* Weighted Adjusted Logistic Regression
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.physically_active i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.education_level i.smoking_status i.drank_past_30d i.home_ownership i.veteran_status i.pregnant_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.Cancer_diagnosis i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Backward selection process starts here at p-value of 0.20
* Pregnancy removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.physically_active i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.education_level i.smoking_status i.drank_past_30d i.home_ownership i.veteran_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.Cancer_diagnosis i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Cancer and Physical_Activity removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.education_level i.smoking_status i.drank_past_30d i.home_ownership i.veteran_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Education removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.smoking_status i.drank_past_30d i.home_ownership i.veteran_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Home-ownership removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.bmi_category i.smoking_status i.drank_past_30d i.veteran_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* BMI_category removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.smoking_status i.drank_past_30d i.veteran_status i.urban_rural i.memory_decline i.is_caregiver i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Is_caregiver removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.smoking_status i.drank_past_30d i.veteran_status i.urban_rural i.memory_decline i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Drank_past_30d removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.has_health_insurance i.race_ethnicity_5cat i.sex i.age_group_6cat i.smoking_status i.veteran_status i.urban_rural i.memory_decline i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* Has_health_insurance removed
svy: logistic depression_dx i.self_health_good i.poor_phys_days i.race_ethnicity_5cat i.sex i.age_group_6cat i.smoking_status i.veteran_status i.urban_rural i.memory_decline i.Comorbid_Cat i.ACES_Cat i.married_binary i.employed_binary i.disability_Cat i.num_children

* 5. In Stata, you can export to CSV like this:
export delimited cleaned_data.csv, replace