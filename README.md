# E - Commerce Customer Churn Analysis
## Project Overview and Objective:
This project analyzes e-commerce customer data using SQL to identify behavioral patterns and churn customer status.
It processes datasets such as customer profiles, orders, interactions, and tenure.
SQL queries are used for cleaning, transforming, and exploring large-scale data.
The goal is to turn raw transactional data into meaningful insights for customer retention.

The objective is to detect factors leading to customer churn in an e-commerce environment.
Using SQL analytics, the project uncovers trends in engagement, purchasing habits, and inactivity.
It identifies high-risk customer segments and key churn indicators.
The insights support data-driven retention strategies and improved customer experience.
## Problem Statement:
- E-commerce businesses struggle to understand customer behavior due to fragmented and unorganized datasets stored across various sources.
- Without clear insights into tenure, churn status, days since last order, and order amount changes, it becomes difficult to detect declining engagement or predict churn.
- As a result, the business faces challenges in identifying high-risk customers, understanding purchase trends, and addressing issues before customers churn.
- Critical behavioral indicators—such as delivery distance (warehouse to home), hours spent on the app, complaints received, coupon usage, preferred login device, and payment mode remain hidden within large datasets.
## Attribute (Column/Features) Details:
| Attribute  | Data Type | Description|
|------------|-----------|------------|
|CustomerID | INT (PRIMARY KEY) | Unique identifier assigned to each customer.|
|Tenure | INT | Number of months the customer has been associated with the platform.|
|PreferredLoginDevice | VARCHAR(20) | Device most frequently used by the customer to log in (e.g., Mobile, Desktop).|
|CityTier | INT |Classification of the customer’s city based on development or population tier (1, 2, or 3).|
|WarehouseToHome| INT | Distance between the warehouse and the customer’s home (in kilometers).|
|PreferredPaymentMode | VARCHAR(20) | Most commonly used payment method by the customer.|
|Gender | ENUM(MALE,FEMALE)|Gender of the customer.|
|HoursSpendOnApp | INT |Total hours the customer spends on the mobile app per month.|
|NumberOfDeviceRegistered |INT | Number of devices registered under the customer's account.|
|PreferredOrderCat | VARCHAR(20) | Category of products the customer orders most frequently.|
|SatisfactionScore | INT | Customer satisfaction rating (typically on a defined scale).|
|MaritalStatus | VARCHAR(10)|Customer’s marital status (e.g., Single, Married).|
|NumberOfAddress|INT | Total number of addresses saved by the customer.|
|OrderAmountHikeFromlastYear | INT |Increase in the customer’s order amount compared to the previous year.|
|CouponUsed | INT | Total number of coupons used by the customer.|
|OrderCount | INT |Total number of orders placed by the customer.|
| DaySinceLastOrder | INT |Number of days since the customer last placed an order. |
|CashbackAmount | INT | Total cashback amount received by the customer.|
|ComplaintReceived | VARCHAR(10) |Indicates whether the customer has submitted complaints (e.g., Yes/No).|
|ChurnStatus | VARCHAR(10) |Indicates whether the customer is **churned** or **active.**|

## Tools and Technologies:
### SQL:
- **Schemas:**    Logical structure or blueprint of the database
- **SQL Commands:**    Convert raw datasets into meaningful data (ALTER, UPDATE, REPLACE, DELETE, handle outliers)
- **Joins(INNER, LEFT, RIGHT, FULL):**   Combine data from multiple tables
- **Functions (Aggeregation):**   Perform calculations and transformations
## Data Preprocess:
### Task Performed:
  -  **Data Cleaning & Transformation:**  Removed duplicates, handled NULL values, standardized data types, corrected inconsistent entries.
  -  **Data Validation:** Ensured accuracy using constraints (PRIMARY KEY, UNIQUE, CHECK, NOT NULL).
  -  **Data Updates:** Applied UPDATE, ALTER, DELETE, and REPLACE to correct or restructure data.
  -  **Data Structuring:** Converted raw tables into Fact and Dimension tables for better analytics (Star & Snowflake schema).
  -  **Joins & Relationships:** Combined multiple tables using INNER, LEFT, RIGHT, FULL joins to create meaningful datasets.
  -  **Aggregations & Calculations:** Used GROUP BY, HAVING, and window functions for advanced calculations and summaries.
## Analysis & Visualization:






