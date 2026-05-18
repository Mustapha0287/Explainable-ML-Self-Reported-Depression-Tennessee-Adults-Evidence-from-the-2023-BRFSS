**Integrating Epidemiologic Modeling and Explainable Machine Learning to Predict and Identify Factors Associated with Self-Reported Depression among Adults in Tennessee, United States**

**Project Overview**
This repository contains all analytic code used in the study *“Integrating Epidemiologic Modeling and Explainable Machine Learning to Predict and Identify Factors Associated with Self-Reported Depression among Adults in Tennessee, United States”.* The materials are provided to ensure full transparency, reproducibility, and methodological clarity.
The repository includes two primary analytic components:

**Python Machine Learning Analysis notebook *(MachineLearning_Depression_Analysis.ipynb)***
The Jupyter Notebook implements the complete machine learning pipeline used in the study. This includes data preprocessing, categorical encoding, nested feature selection using recursive feature elimination (RFE), SMOTE oversampling applied strictly within training folds, hyperparameter tuning via stratified cross-validation, and final model evaluation on an independent hold-out test set. The notebook also includes model interpretation using SHapley Additive exPlanations (SHAP), with both aggregated feature importance and individual-level visualizations.
This repository is intended for researchers interested in reproducible epidemiologic and machine learning applications in population mental health research.

**Abstract**

**Background:** Depression is a major public health concern, with Tennessee ranking among the U.S. states with the highest prevalence. Despite its burden, many cases remain undetected due to limited screening and access to mental health services. This study integrated epidemiologic modelling and explainable ML techniques to predict self-reported depression and identify key risk factors among Tennessee adults using the Behavioral Risk Factor Surveillance System (BRFSS) 2023 data.

**Methods:** We conducted a cross-sectional analysis of 5,596 adults from the 2023 Tennessee BRFSS, representing 5,569,707 weighted respondents. The primary outcome was lifetime self-reported diagnosis of depression. The Oregon BRFSS 2023 was used as an external validation dataset. Eight machine learning algorithms were trained using 5-fold stratified cross-validation. Model performance was evaluated using AUROC, PR-AUC, accuracy, precision, recall, F1-score, balanced accuracy, DeLong’s test, and McNemar’s test, while model interpretability was assessed using SHapley Additive exPlanations (SHAP).

**Results:** The weighted prevalence of self-reported depression among Tennessee adults was 27.3%. Among the evaluated algorithms, XGBoost, Gradient Boosting, Random Forest, and Logistic Regression demonstrated the strongest and highly comparable external validation performance. DeLong’s test for AUROC and paired bootstrap resampling for PR-AUC showed no statistically significant differences among these four leading models. McNemar’s test produced a similar pattern for paired classification errors. SHAP interpretation identified sex, ACEs category, memory decline, disability category, race/ethnicity, poor physical activity, and age group as the most influential predictors of self-reported depression.

**Conclusions:** This study demonstrates the utility of integrating explainable machine learning approaches to predict and identify factors associated with self-reported depression, thereby enhancing the use of public health surveillance systems in early identification of high-risk populations and informing targeted mental health interventions.


**Keywords:** Depression, Machine Learning, SHAP analysis, Behavioral Risk Factor Surveillance System (BRFSS), Public Health Informatics, Risk Prediction, Population Surveillance, Mental Health

