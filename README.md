# Data Analytics Portfolio
 
Interactive dashboards, statistical modeling, and machine learning projects built with **SQL, Python, and Tableau**. The work here spans public health, environmental data, and operational analytics, with a focus on turning complex datasets into actionable insights.
 
**Tableau dashboards:** [Tableau Public profile](https://public.tableau.com/app/profile/josephflumen/vizzes)

**Flumen Data Analytics platform:** [flumendataanalytics.com](https://flumendataanalytics.com)
 
**Core tools:** Python, SQL, MySQL, Tableau, pandas, NumPy, scikit-learn, statsmodels, TensorFlow, seaborn, matplotlib, mlxtend
 
---
 
## Featured Tableau Dashboards
  
### 1. Hospital Readmission Rate by Regional Pollutant Levels
 
An interactive tool exploring whether environmental pollutant levels correlate with hospital readmission rates at the county level. Surfaces two patterns: longer hospital stays carry a higher readmission risk, and a wide range of pollutants have risen across the United States over the last fifty years.

<img width="1920" height="1080" alt="ReAdmisandPollutantMaps" src="https://github.com/user-attachments/assets/9c6c8e47-db69-4bca-be8b-89bfb96fd0e2" />

[view on Tableau Public](https://public.tableau.com/app/profile/josephflumen/viz/HospitalReAdmissionRatebyRegionalPollutantsAnalysis/HospitalReAdmissionRatebyRegionalPollutantAnalysis)

 
### 2. Respiratory Disease Death Rate by Ammonium Levels
 
A four-dashboard analysis testing the relationship between environmental ammonium concentration and respiratory disease mortality. Key findings: respiratory death rates vary sharply by state, ammonium levels have risen significantly over the last fifty years, and an ordinary least squares regression confirms a statistically meaningful relationship between ammonium concentration and respiratory death rates at the county level.

<img width="1856" height="790" alt="Ammn" src="https://github.com/user-attachments/assets/31740eaf-ae78-45ee-af59-2f8deba04259" />

 
[view on Tableau Public](https://public.tableau.com/shared/WCG4GYP5W?:display_count=n&:origin=viz_share_link)
 
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

 
# E-commerce Metabase dashboard SQL

SQL queries for the e-commerce dashboards built in Metabase, organized
one file per dashboard. These are the raw metabase SQL queries of the dashboards on the live Flumen website.

## Files

| File | Dashboard | Cards |
|---|---|---|
| `01_voice_of_customer.sql` | Voice of Customer | Avg CSAT, NPS Score, CSAT over time, NPS over time, CSAT distribution, NPS breakdown, CSAT by topic, recent feedback |
| `02_customer_retention.sql` | Customer Retention | Returning customer rate, new vs returning, cohort size vs retention, new customer acquisition, cohort heatmap (optional) |
| `03_sales_per_employee.sql` | Sales per Employee | Sales leaderboard, avg revenue per employee |
| `04_customer_service.sql` | Customer Service Rating | Rating leaderboard, avg rating over time, ticket volume, by issue category, by channel |
| `05_employee_attendance.sql` | Employee Attendance | Attendance rate by employee, status breakdown by month, attendance rate by department |
| `06_financial_kpis.sql` | Financial KPIs | Gross margin %, operating expenses, net profit, COGS |
| `07_inventory.sql` | Inventory | Avg inventory value, current stock by category, inventory turnover (monthly and rolling 12-month versions) |
| `08_order_fulfillment.sql` | Order Fulfillment | On-time delivery rate, days to deliver by ship mode, status breakdown, by region, monthly volume |
| `09_revenue_and_sales.sql` | Revenue & Sales | Revenue by segment, by acquisition channel, average order value, discount impact |
| `10_product_analytics.sql` | Product Analytics | Top products, COGS vs gross profit by category, return rate by category, revenue by category over time |


## Filter conventions used throughout

Every card with a date dependency uses a Metabase field filter variable with
the optional `[[AND {{variable}}]]` or `[[WHERE {{variable}}]]` syntax, so the
card runs with or without a date selected. Two variable names appear across
files, mapped to the field noted in each file's header comment.

Widget type convention: KPI **Trend** cards use **Month and Year**, since
they compare one month to the previous. Every other chart type (Line, Bar,
Stacked Bar, Table) uses **Date Range**, so a span of time can be selected.

A small number of cards (customer retention's cohort/new-vs-returning queries,
inventory's turnover, current stock) intentionally have no date filter, or a
fixed "most recent snapshot" condition. The reason is noted in a comment
directly above each of those queries; filtering them would either break a
first-order/cohort calculation or wouldn't make sense for a point-in-time
metric like current stock level.
