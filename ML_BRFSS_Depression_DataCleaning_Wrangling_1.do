****************************************************
* DO-FILE:     BRFSS_AI_Depression_Labels.do
* PROJECT:     AI Prediction of Self-Reported Depression
* DATASET:     BRFSS 2023 - Tennessee Subset
* VARIABLES:   59 predictors for AI/ML modeling
* AUTHORs:     Mustapha Aliyu Muhammad $ Jamilu Sani
* DATE:        16th July, 2025
****************************************************

* 1. Set working directory
cd "C:\Users\maliy\Downloads\BRFSS ML Depression Project\Data"

* 2. Load dataset (CSV format assumed)
import delimited "Tennessee_BRFSS_Depression_2023.csv", clear

* 3. Label the variables (lowercase due to import delimited behavior)
label variable _rfhlth       "Good or Better Health"
label variable _phys14d      "Physical Health: 0, 1–13, 14+ days not good"
label variable _ment14d      "Mental Health: 0, 1–13, 14+ days not good"
label variable _hlthpl1      "Have any health insurance"
label variable _totinda      "Physical activity in past 30 days"
label variable _rfhype6      "High blood pressure"
label variable _rfchol3      "High cholesterol"
label variable _michd        "Ever had CHD or heart attack"
label variable _casthm1      "Currently have asthma"
label variable _drdxar2      "Diagnosed with arthritis"
label variable _racegr3      "Race/ethnicity: 5-level"
label variable _sex          "Sex"
label variable _age_g        "Age group (6-level)"
label variable htm4          "Height in meters"
label variable wtkg3         "Weight in kilograms"
label variable _bmi5cat      "Body Mass Index (4-category)"
label variable _chldcnt      "Number of children in household"
label variable _educag       "Education level"
label variable _incomg1      "Income group"
label variable _smoker3      "Smoking status"
label variable drnkany6      "Drank alcohol in past 30 days"
label variable medcost1      "Could not afford to see doctor"
label variable cvdstrk3      "Diagnosed with stroke"
label variable chcscnc1      "Non-melanoma skin cancer"
label variable chcocnc1      "Melanoma or other cancer"
label variable chccopd3      "COPD/emphysema/chronic bronchitis"
label variable addepev3      "Self-reported depression diagnosis (outcome)"
label variable chckdny2      "Kidney disease diagnosis"
label variable diabete4      "Diabetes status"
label variable marital       "Marital status"
label variable renthom1      "Home ownership status"
label variable veteran3      "Veteran status"
label variable employ1       "Employment status"
label variable pregnant      "Pregnancy status"
label variable deaf          "Deaf or serious hearing difficulty"
label variable blind         "Blind or serious visual impairment"
label variable decide        "Difficulty concentrating or remembering"
label variable diffwalk      "Difficulty walking or climbing stairs"
label variable diffdres      "Difficulty dressing or bathing"
label variable diffalon      "Difficulty doing errands alone"
label variable fall12mn      "Falls in past 12 months"
label variable _urbstat      "Urban/rural classification"
label variable cncrdiff      "Number of cancer types"
label variable cimemlo1      "Experienced memory/thinking decline"
label variable caregiv1      "Provided care for family/friend"
label variable crgvexpt      "Expect to provide care in next 2 years"
label variable acetouch      "Touched sexually as child"
label variable acetthem      "Made you touch them sexually"
label variable acehvsex      "Forced to have sex as child"
label variable aceadsaf      "Adult made you feel safe"
label variable aceadned      "Adult met basic needs"
label variable acedeprs      "Lived with mentally ill adult"
label variable acedrink      "Lived with alcoholic"
label variable acedrugs      "Lived with drug user"
label variable aceprisn      "Lived with incarcerated person"
label variable acedivrc      "Parents divorced or separated"
label variable acepunch      "Parents physically abused each other"
label variable acehurt1      "Physically hurt by parent"
label variable aceswear      "Sworn at/insulted by parent"

* 3. Investigate the data types
describe

* 4. Change the variables from string to numeric
* Step 1: Automatically destring all string variables if possible
destring _rfchol3 _michd _drdxar2 htm4 wtkg3 _bmi5cat cvdstrk3 renthom1 veteran3 employ1 pregnant deaf blind decide diffwalk diffdres diffalon fall12mn cncrdiff cimemlo1 caregiv1 crgvexpt acetouch acetthem acehvsex aceadsaf aceadned acedeprs acedrink acedrugs aceprisn acedivrc acepunch acehurt1 aceswear, replace force

* Step 2: Confirm conversion was successful
describe


* 5. Univariate frequency tables for all variables (including missing)
tabulate _rfhlth, missing
tabulate _phys14d, missing
tabulate _ment14d, missing
tabulate _hlthpl1, missing
tabulate _totinda, missing
tabulate _rfhype6, missing
tabulate _rfchol3, missing
tabulate _michd, missing
tabulate _casthm1, missing
tabulate _drdxar2, missing
tabulate _racegr3, missing
tabulate _sex, missing
tabulate _age_g, missing
tabulate htm4, missing
tabulate wtkg3, missing
tabulate _bmi5cat, missing
tabulate _chldcnt, missing
tabulate _educag, missing
tabulate _incomg1, missing
tabulate _smoker3, missing
tabulate drnkany6, missing
tabulate medcost1, missing
tabulate cvdstrk3, missing
tabulate chcscnc1, missing
tabulate chcocnc1, missing
tabulate chccopd3, missing
tabulate addepev3, missing
tabulate chckdny2, missing
tabulate diabete4, missing
tabulate marital, missing
tabulate renthom1, missing
tabulate veteran3, missing
tabulate employ1, missing
tabulate pregnant, missing
tabulate deaf, missing
tabulate blind, missing
tabulate decide, missing
tabulate diffwalk, missing
tabulate diffdres, missing
tabulate diffalon, missing
tabulate fall12mn, missing
tabulate _urbstat, missing
tabulate cncrdiff, missing
tabulate cimemlo1, missing
tabulate caregiv1, missing
tabulate crgvexpt, missing
tabulate acetouch, missing
tabulate acetthem, missing
tabulate acehvsex, missing
tabulate aceadsaf, missing
tabulate aceadned, missing
tabulate acedeprs, missing
tabulate acedrink, missing
tabulate acedrugs, missing
tabulate aceprisn, missing
tabulate acedivrc, missing
tabulate acepunch, missing
tabulate acehurt1, missing
tabulate aceswear, missing

* 6. Flip the variables with 
* Recode 1 = No, 2 = Yes  -->  1 = Yes, 2 = No
recode _casthm1 (1=2) (2=1)
recode _rfhype6 (1=2) (2=1)
recode _rfchol3 (1=2) (2=1)

* To confirm the flip
tabulate _casthm1
tabulate _rfhype6
tabulate _rfchol3


* 7. Recode variables per study protocol
* -- Starting with the variable Pregnancy
* Step 1: Replace system missing (.) with 2 (No)
replace pregnant = 2 if missing(pregnant)
* Step 2: Recode 'Don't know' and 'Refused' to system missing
recode pregnant (7 9 = .)

* -- Recode missing and combine categories where specified
recode _rfhlth (9 = .)
recode _phys14d (9 = .)
recode _ment14d (9 = .)
recode _hlthpl1 (9 = .)
recode _totinda (9 = .)
recode _rfhype6 (9 = .)
recode _rfchol3 (9 = .)
recode _casthm1 (9 = .)
recode _racegr3 (9 = .)
recode _chldcnt (9 = .)
recode _educag (9 = .)
recode _incomg1 (9 = .)
recode _smoker3 (9 = .)
recode drnkany6 (7 9 = .)
recode medcost1 (7 9 = .)
recode cvdstrk3 (7 9 = .)
recode chcscnc1 (7 9 = .)
recode chcocnc1 (7 9 = .)
recode chccopd3 (7 9 = .)
recode addepev3 (7 9 = .)
recode chckdny2 (7 9 = .)
recode diabete4 (7 9 = .)
recode marital (9 = .)
recode renthom1 (7 9 = .)
recode veteran3 (7 9 = .)
recode employ1 (9 = .)
recode deaf (7 9 = .)
recode blind (7 9 = .)
recode decide (7 9 = .)
recode diffwalk (7 9 = .)
recode diffdres (7 9 = .)
recode diffalon (7 9 = .)
recode fall12mn (77 99 = .) (88 = 0)
recode cncrdiff (7 9 = .)
recode cimemlo1 (7 9 = .)
recode caregiv1 (8 = 2) (7 9 = .)
drop crgvexpt
recode acetouch (7 9 = .)
recode acetthem (7 9 = .)
recode acehvsex (7 9 = .)
recode aceadsaf (7 9 = .)
recode aceadned (7 9 = .)
recode acedeprs (7 9 = .)
recode acedrink (7 9 = .)
recode acedrugs (7 9 = .)
recode aceprisn (7 9 = .)
recode acedivrc (7 9 = .)
recode acepunch (7 9 = .)
recode acehurt1 (7 9 = .)
recode aceswear (7 9 = .)

* 8. To confirm that the recoding works (including missing values)
tabulate _rfhlth, missing
tabulate _phys14d, missing
tabulate _ment14d, missing
tabulate _hlthpl1, missing
tabulate _totinda, missing
tabulate _rfhype6, missing
tabulate _rfchol3, missing
tabulate _michd, missing
tabulate _casthm1, missing
tabulate _drdxar2, missing
tabulate _racegr3, missing
tabulate _sex, missing
tabulate _age_g, missing
tabulate htm4, missing
tabulate wtkg3, missing
tabulate _bmi5cat, missing
tabulate _chldcnt, missing
tabulate _educag, missing
tabulate _incomg1, missing
tabulate _smoker3, missing
tabulate drnkany6, missing
tabulate medcost1, missing
tabulate cvdstrk3, missing
tabulate chcscnc1, missing
tabulate chcocnc1, missing
tabulate chccopd3, missing
tabulate addepev3, missing
tabulate chckdny2, missing
tabulate diabete4, missing
tabulate marital, missing
tabulate renthom1, missing
tabulate veteran3, missing
tabulate employ1, missing
tabulate pregnant, missing
tabulate deaf, missing
tabulate blind, missing
tabulate decide, missing
tabulate diffwalk, missing
tabulate diffdres, missing
tabulate diffalon, missing
tabulate fall12mn, missing
tabulate _urbstat, missing
tabulate cncrdiff, missing
tabulate cimemlo1, missing
tabulate caregiv1, missing
tabulate acetouch, missing
tabulate acetthem, missing
tabulate acehvsex, missing
tabulate aceadsaf, missing
tabulate aceadned, missing
tabulate acedeprs, missing
tabulate acedrink, missing
tabulate acedrugs, missing
tabulate aceprisn, missing
tabulate acedivrc, missing
tabulate acepunch, missing
tabulate acehurt1, missing
tabulate aceswear, missing


* 9. create a new variable called Total_Comorbidities using the variables: _michd, _casthm1, 
* _drdxar2, chccopd3, cvdstr3, chckdny2, diabete4, _rfhype6, _rfchol3
gen michd       = (_michd == 1)
gen asthma      = (_casthm1 == 1)
gen arthritis   = (_drdxar2 == 1)
gen copd        = (chccopd3 == 1)
gen stroke      = (cvdstrk3 == 1)
gen kidney      = (chckdny2 == 1)
gen diabetes    = (diabete4 == 1)
gen hypertension= (_rfhype6 == 1)
gen cholesterol = (_rfchol3 == 1)
egen Total_Comorbidities = rowtotal(michd asthma arthritis copd stroke kidney diabetes hypertension cholesterol)

replace Total_Comorbidities = . if missing(michd, asthma, arthritis, copd, stroke, kidney, diabetes, hypertension, cholesterol)

label variable Total_Comorbidities "Count of Self-Reported Chronic Comorbidities (1 = Yes)"
tabulate Total_Comorbidities, missing

* create a variable Comorbid_Cat for me. with classes: 1 = 0, 2 = 1-2, 3 = 3+ comorbidities.
gen Comorbid_Cat = .
replace Comorbid_Cat = 1 if Total_Comorbidities == 0
replace Comorbid_Cat = 2 if inrange(Total_Comorbidities, 1, 2)
replace Comorbid_Cat = 3 if inrange(Total_Comorbidities, 3, 9)
label define comocat 1 "0 comorbidities" 2 "1–2 comorbidities" 3 "3+ comorbidities"
label values Comorbid_Cat comocat
label variable Comorbid_Cat "Category of Comorbidities"
tabulate Comorbid_Cat, missing

* 10. To create the Cancer_diagnosis variable that reflects whether either 
* CHCSCNC1 (non-melanoma) or CHCOCNC1 (melanoma/other) indicates a cancer diagnosis (1 = Yes, 2 = No)
gen Cancer_diagnosis = .
replace Cancer_diagnosis = 1 if chcscnc1 == 1 | chcocnc1 == 1
replace Cancer_diagnosis = 2 if chcscnc1 == 2 & chcocnc1 == 2
label variable Cancer_diagnosis "Any Cancer Diagnosis (non-/melanoma)"
label define canclbl 1 "Yes" 2 "No"
label values Cancer_diagnosis canclbl
tabulate Cancer_diagnosis, missing


* 11. To create a new Total_ACES (Adverse Childhood Experiences Score) variable
* Step 1: Generate binary indicators for each ACE
* Category 1: If 2 or 3, count as 1
gen ace1_touch = inlist(acetouch, 2, 3)
gen ace1_them  = inlist(acetthem, 2, 3)
gen ace1_forced_sex = inlist(acehvsex, 2, 3)
* Category 2: If 1 or 2, count as 1
gen ace2_nosafety  = inlist(aceadsaf, 1, 2)
gen ace2_nobasics  = inlist(aceadned, 1, 2)
* Category 3: If 1, count as 1
gen ace3_mentill   = (acedeprs == 1)
gen ace3_alcoholic = (acedrink == 1)
gen ace3_drugs     = (acedrugs == 1)
gen ace3_prison    = (aceprisn == 1)
* Category 4: If 1 or 8, count as 1
gen ace4_divorce = inlist(acedivrc, 1, 8)
* Category 5: If 2 or 3, count as 1
gen ace5_punched = inlist(acepunch, 2, 3)
gen ace5_hurt    = inlist(acehurt1, 2, 3)
gen ace5_sworn   = inlist(aceswear, 2, 3)

*  Step 2: Compute the Total ACE Score
egen Total_ACES = rowtotal(ace1_touch ace1_them ace1_forced_sex ace2_nosafety ace2_nobasics ace3_mentill ace3_alcoholic ace3_drugs ace3_prison ace4_divorce ace5_punched ace5_hurt ace5_sworn)

replace Total_ACES = . if missing(acetouch, acetthem, acehvsex, aceadsaf, aceadned, acedeprs, acedrink, acedrugs, aceprisn, acedivrc, acepunch, acehurt1, aceswear)


* Step 3: Label the new variable
label variable Total_ACES "Total Adverse Childhood Experiences Score"

* Step 4 (Optional): Create a categorical version
gen ACES_Cat = .
replace ACES_Cat = 1 if Total_ACES == 0
replace ACES_Cat = 2 if inrange(Total_ACES, 1, 3)
replace ACES_Cat = 3 if inrange(Total_ACES, 4, 13)

label define aceslbl 1 "0 ACEs" 2 "1–3 ACEs" 3 "4+ ACEs"
label values ACES_Cat aceslbl
label variable ACES_Cat "ACES Category"

* Step 5: Verify your variable
tabulate Total_ACES, missing
tabulate ACES_Cat, missing


* 12. Conversion of height variable
* Convert htm4 to numeric (if it's still a string)
destring htm4, replace force
* Divide by 100 to get meters with decimals
gen height_m = htm4 / 100
* Label the new variable (optional)
label variable height_m "Height in meters (converted)"


* 13. Conversion of weight variable
* Convert wtkg3 to numeric (if still a string)
destring wtkg3, replace force
* Create a new variable with decimal weight in kilograms
gen weight_kg = wtkg3 / 100
* Label the new variable (optional)
label variable weight_kg "Weight in kilograms (converted)"


* 14. recode and label marital status
* Create a new binary marital status variable
gen married_binary = .
replace married_binary = 1 if marital == 1
replace married_binary = 2 if inlist(marital, 2, 3, 4, 5, 6)
* Label new variable
label variable married_binary "Marital Status"
* Add value labels (optional)
label define married_lbl 1 "Married" 2 "Unmarried"
label values married_binary married_lbl


* 15. recode and label employed
* Step 3: Create new binary employment status
gen employed_binary = .
replace employed_binary = 1 if inlist(employ1, 1, 2, 5)
replace employed_binary = 2 if inlist(employ1, 3, 4, 6, 7, 8)
* Step 4: Label the new variable
label variable employed_binary "Employment Status"
* Step 5: (Optional) Add value labels
label define emp_lbl 1 "Employed" 2 "Unemployed"
label values employed_binary emp_lbl


* 16. Label other variables
* Define value labels
label define hlthlbl   1 "Good/Better" 2 "Fair/Poor"
label define dayslbl   1 "Zero days" 2 "1–13 days" 3 "14+ days"
label define insurlbl  1 "Insured" 2 "Not insured"
label define yesnolbl2 1 "Yes" 2 "No"
label define race5lbl  1 "White" 2 "Black" 3 "Other" 4 "Multiracial" 5 "Hispanic"
label define sexlbl    1 "Male" 2 "Female"
label define agelbl    1 "18–24" 2 "25–34" 3 "35–44" 4 "45–54" 5 "55–64" 6 "65+"
label define chldlbl   1 "No children" 2 "One" 3 "Two" 4 "Three" 5 "Four" 6 "Five+"
label define edulbl    1 "<HS" 2 "HS Grad" 3 "Some college" 4 "College grad"
label define inclbl    1 "<15k" 2 "15–25k" 3 "25–35k" 4 "35–50k" 5 "50–100k" 6 "100–200k" 7 "200k+"
label define smoklbl   1 "Every day" 2 "Somedays" 3 "Former" 4 "Never"
label define drinklbl  1 "Yes" 2 "No"
label define strokeLbl 1 "Yes" 2 "No"
label define bmiLbl    1 "Underweight" 2 "Normal" 3 "Overweight" 4 "Obese"
label define ownlbl    1 "Own" 2 "Rent" 3 "Other"
label define maritalbl 1 "Married" 2 "Divorced" 3 "Widowed" 4 "Separated" 5 "Never married" 6 "Unmarried couple"
label define emplbl    1 "Employed for wages" 2 "Self-employed" 3 "Out of work ≥ 1 year" 4 "Out of work < 1 year" 5 "Homemaker" 6 "Student"  7 "Retired" 8 "Unable to work"
label define urbLbl    1 "Urban" 2 "Rural"
label define cncrLbl   1 "One type" 2 "Two types" 3 "Three+ types"
label define safeLbl   1 "Never" 2 "A little" 3 "Some" 4 "Most" 5 "All"
label define abuseLbl  1 "Never" 2 "Once" 3 "More than once"
label define diabeteLbl 1 "Yes" 2 "Yes, during pregnancy (females only)" 3 "No" 4 "No, pre-diabetes or borderline"
label define acedivrcLbl 1 "Yes" 2 "No" 8 "Parents not married"

* Apply value labels
label values _rfhlth       hlthlbl
label values _phys14d      dayslbl
label values _ment14d      dayslbl
label values _hlthpl1      insurlbl
label values _totinda      yesnolbl2
label values _rfhype6      yesnolbl2
label values _rfchol3      yesnolbl2
label values _michd        yesnolbl2
label values _casthm1      yesnolbl2
label values _drdxar2      yesnolbl2
label values _racegr3      race5lbl
label values _sex          sexlbl
label values _age_g        agelbl
label values _bmi5cat      bmiLbl
label values _chldcnt      chldlbl
label values _educag       edulbl
label values _incomg1      inclbl
label values _smoker3      smoklbl
label values drnkany6      drinklbl
label values medcost1      drinklbl
label values cvdstrk3      strokeLbl
label values chcscnc1      yesnolbl2
label values chcocnc1      yesnolbl2
label values chccopd3      yesnolbl2
label values addepev3      yesnolbl2
label values chckdny2      yesnolbl2
label values diabete4 diabeteLbl
label values marital       maritalbl
label values renthom1      ownlbl
label values veteran3      yesnolbl2
label values employ1       emplbl
label values pregnant      yesnolbl2
label values deaf          yesnolbl2
label values blind         yesnolbl2
label values decide        yesnolbl2
label values diffwalk      yesnolbl2
label values diffdres      yesnolbl2
label values diffalon      yesnolbl2
label values _urbstat      urbLbl
label values cncrdiff      cncrLbl
label values cimemlo1      yesnolbl2
label values caregiv1      yesnolbl2
label values acetouch      abuseLbl
label values acetthem      abuseLbl
label values acehvsex      abuseLbl
label values aceadsaf      safeLbl
label values aceadned      safeLbl
label values acedeprs      yesnolbl2
label values acedrink      yesnolbl2
label values acedrugs      yesnolbl2
label values aceprisn      yesnolbl2
label values acedivrc      acedivrcLbl
label values acepunch      abuseLbl
label values acehurt1      abuseLbl
label values aceswear      abuseLbl

* 17. Tabulate and summarize all the remaining variables
tabulate _rfhlth, missing
tabulate _phys14d, missing
tabulate _ment14d, missing
tabulate _hlthpl1, missing
tabulate _totinda, missing
tabulate _rfhype6, missing
tabulate _rfchol3, missing
tabulate _michd, missing
tabulate _casthm1, missing
tabulate _drdxar2, missing
tabulate _racegr3, missing
tabulate _sex, missing
tabulate _age_g, missing
tabulate _bmi5cat, missing
tabulate _chldcnt, missing
tabulate _educag, missing
tabulate _incomg1, missing
tabulate _smoker3, missing
tabulate drnkany6, missing
tabulate medcost1, missing
tabulate cvdstrk3, missing
tabulate chcscnc1, missing
tabulate chcocnc1, missing
tabulate chccopd3, missing
tabulate addepev3, missing
tabulate chckdny2, missing
tabulate diabete4, missing
tabulate marital, missing
tabulate renthom1, missing
tabulate veteran3, missing
tabulate employ1, missing
tabulate pregnant, missing
tabulate deaf, missing
tabulate blind, missing
tabulate decide, missing
tabulate diffwalk, missing
tabulate diffdres, missing
tabulate diffalon, missing
tabulate _urbstat, missing
tabulate cncrdiff, missing
tabulate cimemlo1, missing
tabulate caregiv1, missing
tabulate acetouch, missing
tabulate acetthem, missing
tabulate acehvsex, missing
tabulate aceadsaf, missing
tabulate aceadned, missing
tabulate acedeprs, missing
tabulate acedrink, missing
tabulate acedrugs, missing
tabulate aceprisn, missing
tabulate acedivrc, missing
tabulate acepunch, missing
tabulate acehurt1, missing
tabulate aceswear, missing
tabulate employed_binary, missing
tabulate married_binary, missing

* for continous variable
summarize height_m
summarize weight_kg

* Visualization of continous variables
histogram height_m
histogram weight_kg

* 18. Save Stata version
* Extract specified variables into a new dataset
keep addepev3 _rfhlth _phys14d _ment14d _hlthpl1 _totinda _racegr3 _sex _age_g _bmi5cat _chldcnt _educag _smoker3 drnkany6 Cancer_diagnosis renthom1 veteran3 pregnant deaf blind decide diffwalk diffdres diffalon _urbstat cimemlo1 caregiv1 Comorbid_Cat ACES_Cat employed_binary married_binary height_m weight_kg _psu _ststr _llcpwt

* Rename the variables name with more understandable ones
rename (addepev3 _rfhlth _phys14d _ment14d _hlthpl1 _totinda _racegr3 _sex _age_g _bmi5cat _chldcnt _educag _smoker3 drnkany6 renthom1 veteran3 pregnant deaf blind decide diffwalk diffdres diffalon _urbstat cimemlo1 caregiv1) (depression_dx self_health_good poor_phys_days poor_ment_days has_health_insurance physically_active race_ethnicity_5cat sex age_group_6cat bmi_category num_children education_level smoking_status drank_past_30d home_ownership veteran_status pregnant_status hearing_difficulty vision_difficulty cognitive_difficulty mobility_difficulty dressing_difficulty errands_difficulty urban_rural memory_decline is_caregiver)


* Save the new dataset
save "Selected_BRFSS_Cleaned.dta", replace

* 19. Done
display "Variables labeled successfully."
