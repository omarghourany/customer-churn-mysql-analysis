# 📊 Customer Churn Analysis Using MySQL

## Project Overview

This project analyzes a customer churn dataset using **MySQL** to identify the factors most strongly associated with customer churn. The analysis explores customer demographics, subscription plans, payment methods, customer activity, service interactions, and spending behavior to generate actionable business insights and retention recommendations.

The project demonstrates practical SQL skills by performing Exploratory Data Analysis (EDA) and translating analytical findings into business recommendations.

---

## Objectives

* Measure the overall customer churn rate.
* Identify customer segments with the highest churn.
* Analyze how demographics relate to churn.
* Evaluate the impact of subscription plans and payment methods.
* Investigate customer activity and service interactions.
* Examine the relationship between monthly spending and churn.
* Provide data-driven recommendations to improve customer retention.

---

## Dataset

The dataset contains customer information, subscription details, usage behavior, and churn status.

The dataset includes the following key fields:

* Customer ID
* Gender
* Region
* Subscription Plan
* Payment Method
* Age
* Days Since Last Login
* Customer Service Calls
* Monthly Spend
* Churn

---

## Data Cleaning Summary

The dataset was cleaned before analysis to ensure reliable results.

Cleaning steps included:

* Removed duplicate records.
* Converted data types where necessary.
* Standardized categorical values.
* Replaced invalid values with NULL where appropriate.
* Corrected unrealistic values.
* Handled missing values.
* Verified data consistency before performing the analysis.

---

## SQL Skills Demonstrated

* Aggregate Functions (`SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)
* `GROUP BY`
* `ORDER BY`
* Common Table Expressions (CTEs)
* `CASE` Expressions
* Data Cleaning Techniques
* Data Validation
* Business KPI Calculations
* Exploratory Data Analysis (EDA)

---

## Exploratory Data Analysis (EDA)

### 1. Overall Customer KPIs

* Total customers
* Churned customers
* Retained customers
* Overall churn rate
* Average customer age
* Average monthly spending
* Average customer service calls
* Average days since last login

### 2. Customer Demographics

* Gender analysis
* Region analysis
* Age group analysis

### 3. Customer Behavior Analysis

* Subscription plan analysis
* Payment method analysis
* Customer activity analysis
* Customer service calls analysis
* Monthly spending analysis

### 4. Relationship Analysis

* Subscription Plan vs. Monthly Spending

---

## Key Business Insights

* Customers on the **South** region exhibited the highest churn rate.
* Customers using the **Basic** subscription plan experienced the highest churn.
* Customers with long periods of inactivity were significantly more likely to churn.
* Customers who contacted customer service more frequently showed higher churn rates.
* Lower monthly spending was associated with higher customer churn.
* Customers subscribed to the **Plus** plan had the highest average monthly spending.

---

## Business Recommendations

* Prioritize retention campaigns for customers on the Basic subscription plan.
* Re-engage inactive customers before they become likely to churn.
* Investigate the reasons behind frequent customer service interactions.
* Develop targeted retention strategies for high-risk regions.
* Encourage Basic customers to upgrade through personalized offers and incentives.
* Increase customer engagement to improve long-term retention.

---

## What I Learned

Through this project, I practiced:

* Performing end-to-end customer churn analysis using MySQL.
* Cleaning and validating real-world datasets.
* Identifying patterns associated with customer churn.
* Writing structured SQL queries to answer business questions.
* Converting analytical findings into actionable business recommendations.
* Communicating business insights in a clear and professional manner.

## Repository Structure

```
customer-churn-mysql-analysis/
│
├── README.md
├── SQL/
│   └── customer_churn_analysis.sql
│
└── Dataset/
    ├── customer_churn_original.csv
    └── clean_customer_churn.csv
```
