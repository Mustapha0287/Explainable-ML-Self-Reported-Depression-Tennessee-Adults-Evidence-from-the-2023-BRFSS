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
use "Selected_BRFSS_Cleaned_Nomiss.dta", clear

* Take a look at the overall data
describe

* Take a look at the missingness in the data
misstable summarize

* 3. Create a new variable using the disability variables
* Step 1: Create Total_disability (0 to 6)
* Recode: 1 = Yes → 1, 2 = No → 0
foreach var in hearing_difficulty vision_difficulty cognitive_difficulty mobility_difficulty dressing_difficulty errands_difficulty {
    replace `var' = 1 if `var' == 1
    replace `var' = 0 if `var' == 2
}

* Create Total_disability as a sum of the six binary variables
gen Total_disability = hearing_difficulty + vision_difficulty + cognitive_difficulty + mobility_difficulty + dressing_difficulty + errands_difficulty


* Step 2: Create disability categories
gen disability_Cat = .
replace disability_Cat = 0 if Total_disability == 0
replace disability_Cat = 1 if Total_disability == 1
replace disability_Cat = 2 if Total_disability >= 2

* Optional: label the categories
label define dislbl 0 "No disability" 1 "Single disability" 2 "Multiple disabilities"
label values disability_Cat dislbl

* Add a variable label for clarity
label variable disability_Cat "Number of Functional Disabilities"

* Drop height, weight, and the six disability indicator variables
drop height_m weight_kg hearing_difficulty vision_difficulty cognitive_difficulty mobility_difficulty dressing_difficulty errands_difficulty Total_disability

* Save the final cleaned dataset
save "Selected_BRFSS_Cleaned_Nomiss_Final.dta", replace

