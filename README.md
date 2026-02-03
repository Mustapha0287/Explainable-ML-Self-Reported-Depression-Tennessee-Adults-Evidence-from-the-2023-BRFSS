# Explainable-ML-Self-Reported-Depression-Tennessee-Adults-Evidence-from-the-2023-BRFSS
**Integrating Explainable Machine Learning to Predict and Interpret Self-Reported Depression among Adults in Tennessee, United States**

**Abstract**

**Background:** Depression is a major public health concern, with Tennessee ranking among the U.S. states with the highest prevalence. Despite its burden, many cases remain undetected due to limited screening and access to mental health services. This study explores the utility of explainable ML techniques in predicting self-reported depression and identifying key risk factors among Tennessee adults using the Behavioral Risk Factor Surveillance System (BRFSS) 2023 data.

**Methods:** We conducted a cross-sectional study including 5,596 (5,569,707 weighted) respondents. The primary outcome was self-reported diagnosis of depression. A diverse set of machine learning algorithms were trained using an 80/20 stratified train–test split, with 5-fold stratified cross-validation applied within the training data. Model performance was evaluated on the unresampled test set using relevant metrics. Model interpretability was assessed using SHapley Additive exPlanations (SHAP) for the best-performing models.

**Results:** The weighted prevalence of self-reported depression was 27.3%. Among all evaluated algorithms, Extreme Gradient Boosting (XGBoost) demonstrated the strongest overall discriminative performance on the independent test set (AUROC 0.787; accuracy 0.765; PR-AUC 0.612). SHAP-based interpretation of the XGBoost model revealed that age group, functional disability burden, adverse childhood experiences (ACEs), sex, poor physical health days, and comorbidity burden were the most influential predictors of self-reported depression.

**Conclusions:** This study demonstrates the utility of integrating explainable machine learning approaches to predict self-reported depression, thereby enhancing public health surveillance systems in early identification of high-risk populations and informing targeted mental health interventions.

**Keywords:** Depression, Machine Learning, SHAP analysis, Behavioral Risk Factor Surveillance System (BRFSS), Public Health Informatics, Risk Prediction, Population Surveillance, Mental Health

