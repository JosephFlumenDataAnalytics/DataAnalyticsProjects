# Data Analytics Portfolio
 
Interactive dashboards, statistical modeling, and machine learning projects built with **SQL, Python, and Tableau**. The work here spans public health, environmental data, and operational analytics, with a focus on turning complex datasets into clear, decision-ready insights.
 
**Live dashboards:** [Tableau Public profile](https://public.tableau.com/app/profile/josephflumen/vizzes)
**Analytics platform:** [flumendataanalytics.com](https://flumendataanalytics.com)
**LinkedIn:** [linkedin.com/in/joseph-v-3182983a5](https://www.linkedin.com/in/joseph-v-3182983a5)
 
**Core tools:** Python, SQL, MySQL, Tableau, pandas, NumPy, scikit-learn, statsmodels, TensorFlow, seaborn, matplotlib, mlxtend
 
---
 
## Featured Tableau Dashboards
  
### 1. Hospital Readmission Rate by Regional Pollutant Levels
 
An interactive tool exploring whether environmental pollutant levels correlate with hospital readmission rates at the county level. Surfaces two patterns: longer hospital stays carry a higher readmission risk, and a wide range of pollutants have risen across the United States over the last fifty years.
 
- **Intro dashboard:** [view on Tableau Public](https://public.tableau.com/app/profile/josephflumen/viz/HospitalReAdmissionRatebyRegionalPollutantsAnalysis/HospitalReAdmissionRatebyRegionalPollutantAnalysis)
 
### 2. Respiratory Disease Death Rate by Ammonium Levels
 
A four-dashboard analysis testing the relationship between environmental ammonium concentration and respiratory disease mortality. Key findings: respiratory death rates vary sharply by state, ammonium levels have risen significantly over the last fifty years, and an ordinary least squares regression confirms a statistically meaningful relationship between ammonium concentration and respiratory death rates at the county level.
 
- **Intro dashboard:** [view on Tableau Public](https://public.tableau.com/shared/WCG4GYP5W?:display_count=n&:origin=viz_share_link)
 
---
 
## Analytics & Machine Learning Projects
 
A collection of projects completed during my Master of Science in Data Analytics. Most analyze a 10,000-record hospital patient dataset covering detailed clinical and demographic information.
  
| Topic | Technique | Question explored | Code | Write-Up |
| --- | --- | --- | --- | --- |
| Data Cleaning & PCA | Outlier imputation, categorical re-expression, principal component analysis | Prepares the patient dataset and reduces dimensionality to the variables driving the most variance | [.py](./Projects/ExecutableCleaningFile.py) | [PDF](./Project%20Summaries/DataCleaning_PCA.pdf) |
| Exploratory Data Analysis | Chi-square test of independence | Tests whether key categorical patient variables are statistically independent | [.py](./Projects/Chi%20Square.py) | [PDF](./Project%20Summaries/Chi_square_Summary.pdf) |
| Predictive Modeling | Multiple linear regression | Models a continuous patient outcome against multiple clinical and demographic predictors | [.py](./Projects/LinearRegression.py) | [PDF](./Project%20Summaries/LinearRegression_Summary.pdf) |
| Predictive Modeling | Logistic regression | Predicts a binary patient outcome from clinical and demographic features | [.py](./Projects/LogisticRegression.py) | [PDF](./Project%20Summaries/LogisticRegression_Modeling_Summary.pdf) |
| Data Mining | K-nearest neighbor classification | Classifies patients using KNN on standardized features | [.py](./Projects/KNN%20Modeling.py) | [PDF](./Project%20Summaries/KNN_Modeling_Summary.pdf) |
| Data Mining | Random forest regression | Predicts a continuous patient outcome using an ensemble random forest model | [.py](./Projects/Data%20Mining%3A%20Random%20Forest%20Regression.py) | [PDF](./Project%20Summaries/RandomForestRegression_Summary.pdf) |
| Reporting & Visualization | Tableau dashboard, EPA air quality integration | Integrates EPA air quality data with readmission data and visualizes the relationship in Tableau | [.sql](./Projects/Readmission%20Rate%20by%20Pollutants.sql) | [PDF](./Project%20Summaries/ReadmissionRate_byPollutants_Summary.pdf) |
| Advanced Analytics | K-means clustering | Segments patients into clusters based on shared characteristics | [.py](./Projects/KMeansClustering.py) | [PDF](./Project%20Summaries/KMeansClustering_Summary.pdf) |
| Advanced Analytics | Principal component analysis | Identifies the variables responsible for the most variance in the dataset | [.py](./Projects/Principal%20Component%20Analysis.py) | [PDF](./Project%20Summaries/PrincipalComponentAnalysis.pdf) |
| Advanced Analytics | Market basket analysis, Apriori algorithm | Identifies frequently co-occurring items using association rules | [.py](./Projects/Market%20Basket%20Analysis.py) | [PDF](./Project%20Summaries/MarketBasket_Summary.pdf) |
| Advanced Analytics | ARIMA time series forecasting | Forecasts a time-indexed series using an ARIMA model | [.py](./Projects/Time%20Series%20Modeling.py) | [PDF](./Project%20Summaries/TimeSeriesModeling_Summary.pdf) |
| Advanced Analytics | LSTM neural network, sentiment analysis | Classifies text sentiment using a long short-term memory neural network | [.py](./Projects/Sentiment%20Analysis.py) | [PDF](./Project%20Summaries/Sentiment_Analysis_Summary.pdf) |
| SQL Data Acquisition | Querying and data preparation | Queries and prepares source data in SQL for downstream analysis | [.sql](./Projects/SQL%20Data%20Acquisition.sql) | — |
 
---
 
## Tools & Libraries
 
**Languages:** Python, SQL
**Data & modeling:** pandas, NumPy, scikit-learn, statsmodels, TensorFlow, mlxtend
**Visualization:** Tableau, seaborn, matplotlib
**Databases:** MySQL
 
