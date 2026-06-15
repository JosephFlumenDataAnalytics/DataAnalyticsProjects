# Data Analytics Portfolio
 
Interactive dashboards, statistical modeling, and machine learning projects built with **SQL, Python, and Tableau**. The work here spans public health, environmental data, and operational analytics, with a focus on turning complex datasets into clear, decision-ready insights.
 
**Live dashboards:** [Tableau Public profile](https://public.tableau.com/app/profile/josephflumen/vizzes)
**Analytics platform:** [flumendataanalytics.com](https://flumendataanalytics.com)
**LinkedIn:** [linkedin.com/in/joseph-v-3182983a5](https://www.linkedin.com/in/joseph-v-3182983a5)
 
**Core tools:** Python, SQL, MySQL, Tableau, pandas, NumPy, scikit-learn, statsmodels, TensorFlow, seaborn, matplotlib, mlxtend
 
## Analytics & Machine Learning Projects
 
A collection of projects completed during my Master of Science in Data Analytics. Most analyze a 10,000-record hospital patient dataset covering detailed clinical and demographic information.
 
> Note: the "Question explored" column below describes each project's approach. Adjust any line to match the specific outcome variable or finding in your write-up.
 
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
 
 # Data Analysis Project 1): Hospital ReAdmission Rate By Local Pollutant Levels
All dashboards are fully interactive, all visible filters are adjustable by any user. 

**Introduction to Re-Admission Problem:**

Tableau Public: 
https://public.tableau.com/app/profile/josephflumen/viz/HospitalReAdmissionRatebyRegionalPollutantsAnalysis/HospitalReAdmissionRatebyRegionalPollutantAnalysis

This dashboard visually introduces two concepts: Patients who are in the hospital longer are at much higher risk of re-admission, and the introduction of many new pollutants at increasing levels in our environment over the last 50 years.

<img width="1920" height="1080" alt="Intro to ReAdmis" src="https://github.com/user-attachments/assets/a72cd4f5-1462-44c2-964b-eeb235ec8325" />

**Pollutant and & Re-Admission Maps:**

Tableau Public: https://public.tableau.com/shared/WC8NG6Q28?:display_count=n&:origin=viz_share_link 

This Dashboard showcases two maps: Re-admission percentage by county and pollutant measurements by county. This is intended to be a functioning tool allowing users to visually correlate hospital re-admission rates with regional pollutant levels. 

<img width="1920" height="1080" alt="ReAdmisandPollutantMaps" src="https://github.com/user-attachments/assets/2ac5327e-3aab-4967-b044-7ea503b9d092" />

**Pollutants by State Bar Chart:**

This is an interactive bar chart designed to allow users to visualize pollutant measurements by state. This is intended to allow users to view pollutant measurements by state, and compare between states.

Tableau Public: https://public.tableau.com/shared/DRHBQXK72?:display_count=n&:origin=viz_share_link 

<img width="1920" height="1080" alt="PollutantsStateBar" src="https://github.com/user-attachments/assets/74ef48a6-8208-4bd5-8ca4-c126f0930835" />


# Data Analysis Project 2) Respiratory Disease as Cause of Death Rate by Ammonium Levels Analysis
**Introduction to Respiratory Problem:**

This dashboard is designed to introduce users to two trends: First, there is a significant discrepancy in respiratory disease death rates based on state location. Second, Ammonium levels in the environment have significantly increased over the last 50 years. 

Tableau Public: https://public.tableau.com/shared/WCG4GYP5W?:display_count=n&:origin=viz_share_link 

<img width="1920" height="1080" alt="DB1" src="https://github.com/user-attachments/assets/b217d50f-a3ec-4aec-a9ea-769259391c37" />

**Respiratory Disease Rate by Ammonium Levels Maps:**

This dashboard is designed to allow for visual comparison between state level respiratory rate and county level pollutant measurements. This encourages visual correlation between pollutant level and respiratory disease rate.

Tableau Public: https://public.tableau.com/shared/NTRPM2BZP?:display_count=n&:origin=viz_share_link

<img width="1920" height="1080" alt="DB2" src="https://github.com/user-attachments/assets/59866e5f-2af4-40eb-921a-538c416d8d6f" />


**Respiratory Disease Rate by Ammonium Levels bar charts:**

This visualization is designed to allow users to both view states which contain the same selected pollutants, and a pollutant measurement breakdown by selected state.

Tableau Public: https://public.tableau.com/shared/56Z5Q84H4?:display_count=n&:origin=viz_share_link

<img width="1920" height="1080" alt="DB3" src="https://github.com/user-attachments/assets/f6700b48-547b-473e-975b-2d50dbc4435a" />


**Respiratory Disease Rate by Ammonium Levels - Ordinary Least Squares Linear Regression:**

This dashboard presents a linear regression model illustrating the relationship between ammonium level and respiratory rate.                           

Tableau Public: https://public.tableau.com/shared/P7FZY3BKF?:display_count=n&:origin=viz_share_link

<img width="1920" height="1080" alt="DB4" src="https://github.com/user-attachments/assets/7ec466ed-1190-4783-ad20-19da79efeec2" />


## Data Analytics Project Write-Ups
Summary write-ups for data analytics projects completed during Master of Science program in Data Analytics. The majority of projects analyze a hospital patient dataset of 10,000 records covering detailed patient information.

---

### Projects

| Topic | Technique | Code | Write-Up |
|-------|-----------|------|----------|
| Data Cleaning & PCA | Outlier imputation, categorical re-expression, principal component analysis | [.py](Projects/ExecutableCleaningFile.py) | [PDF](Project%20Summaries/DataCleaning_PCA.pdf) |
| Exploratory Data Analysis | Chi-square test of independence | [.py](Projects/Chi%20Square.py) | [PDF](Project%20Summaries/Chi_square_Summary.pdf) |
| Predictive Modeling | Multiple linear regression | [.py](Projects/LinearRegression.py) | [PDF](Project%20Summaries/LinearRegression_Summary.pdf) |
| Predictive Modeling | Logistic regression | [.py](Projects/LogisticRegression.py) | [PDF](Project%20Summaries/LogisticRegression_Modeling_Summary.pdf) |
| Data Mining | K-nearest neighbor classification | [.py](Projects/KNN%20Modeling.py) | [PDF](Project%20Summaries/KNN_Modeling_Summary.pdf) |
| Data Mining | Random forest regression | [.py](Projects/Data%20Mining%3A%20Random%20Forest%20Regression.py) | [PDF](Project%20Summaries/RandomForestRegression_Summary.pdf) |
| Reporting & Visualization | Tableau dashboard, EPA air quality integration | [.sql](Projects/Readmission%20Rate%20by%20Pollutants.sql) | [PDF](Project%20Summaries/ReadmissionRate_byPollutants_Summary.pdf) |
| Advanced Data Analytics | K-means clustering | [.py](Projects/KMeansClustering.py) | [PDF](Project%20Summaries/KMeansClustering_Summary.pdf) |
| Advanced Data Analytics | Principal component analysis | [.py](Projects/Principal%20Component%20Analysis.py) | [PDF](Project%20Summaries/PrincipalComponentAnalysis.pdf) |
| Advanced Data Analytics | Market basket analysis, Apriori algorithm | [.py](Projects/Market%20Basket%20Analysis.py) | [PDF](Project%20Summaries/MarketBasket_Summary.pdf) |
| Advanced Analytics | ARIMA time series forecasting | [.py](Projects/Time%20Series%20Modeling.py) | [PDF](Project%20Summaries/TimeSeriesModeling_Summary.pdf) |
| Advanced Analytics | LSTM neural network, sentiment analysis | [.py](Projects/Sentiment%20Analysis.py) | [PDF](Project%20Summaries/Sentiment_Analysis_Summary.pdf) |
| SQL Data Acquisition | Data querying and preparation | [.sql](Projects/SQL%20Data%20Acquisition.sql) | — |

---

### Tools & Libraries
Python, SQL, pandas, numpy, scikit-learn, statsmodels, seaborn, matplotlib, tensorflow, mlxtend, Tableau, MySQL
