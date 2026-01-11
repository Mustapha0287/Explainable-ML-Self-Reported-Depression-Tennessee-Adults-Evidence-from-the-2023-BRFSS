****************************************************
* DO-FILE:     BRFSS_AI_Depression_Labels.do
* PROJECT:     AI Prediction of Self-Reported Depression
* DATASET:     BRFSS 2023 - Tennessee Subset
* VARIABLES:   59 predictors for AI/ML modeling
* AUTHORs:     Mustapha Aliyu Muhammad $ Jamilu Sani
* DATE:        18th July, 2025
****************************************************

* 1. Set working directory
cd "C:\Users\maliy\Downloads\BRFSS ML Depression Project\Data"

* 2. Load dataset (Stata .dta format)
use "Selected_BRFSS_Cleaned.dta", clear


* 3. Step 1: Count how many will be dropped
* This gives you the number of observations with missing depression status (your outcome variable).
count if missing(depression_dx)
* Step 2: Drop them
drop if missing(depression_dx)
*Step 3: Confirm how many remain
* This tells you the number of observations after dropping missing depression_dx.
count


* 4. Step 4: Check missingness for all other variables
* You can loop through your variables like this:
* This will print the number of missing values for every variable in your dataset.
* Optional: If you want a full missing report
misstable summarize


* 5. Recoding depression_dx to 1 = Yes and 0 = No is the standard practice.
replace depression_dx = 0 if depression_dx == 2
label define depdxlbl 1 "Yes" 0 "No"
label values depression_dx depdxlbl
tabulate depression_dx, missing
tabulate depression_dx, nolabel missing
* To drop the variables memory_decline and ACES_Cat, use the following simple command:
* drop memory_decline ACES_Cat is_caregiver
describe
* Save the new dataset
save "Selected_BRFSS_Cleaned_NomissOutcome.dta", replace


****************************************************
* Replacing the missing of the variables with means for continous variables and 
* modes for the categorical variables
****************************************************

* 6. Impute missing values: Mean for continuous, Mode for categorical
* --- Impute Continuous Variables with MEAN ---
foreach var in height_m weight_kg {
    summarize `var' if !missing(`var'), meanonly
    replace `var' = r(mean) if missing(`var')
}

* --- Impute Continuous Variables with MEAN ---
foreach var in self_health_good poor_phys_days poor_ment_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category num_children education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status hearing_difficulty vision_difficulty cognitive_difficulty mobility_difficulty dressing_difficulty errands_difficulty urban_rural memory_decline is_caregiver Comorbid_Cat Cancer_diagnosis ACES_Cat married_binary employed_binary {
    di "Imputing missing values in `var' with mode..."
    quietly egen mode_`var' = mode(`var') if !missing(`var')
    quietly summarize mode_`var'
    local mode = r(mean)
    replace `var' = `mode' if missing(`var')
    drop mode_`var'
}

* To confirm, full missing report
misstable summarize

* Save the new dataset
save "Selected_BRFSS_Cleaned_Nomiss.dta", replace