-- CUSTOMER CHURN EDA PROJECT
--
-- Objective:
-- Analyze customer characteristics and behavior to identify which factors
-- are most strongly associated with customer churn.
--
-- Main variables analyzed:
-- Gender, Region, Subscription Plan, Payment Method, Age,
-- Customer Activity, Customer Service Calls, and Monthly Spending.

-- OVERALL CUSTOMER KPIs

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN churn = 0 THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(
        SUM(CASE WHEN churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS overall_churn_rate,
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(Monthly_Spend), 2) AS average_monthly_spend,
    ROUND(AVG(Customer_Service_Calls), 2) AS average_service_calls,
    ROUND(AVG(Days_Since_Last_Login), 2) AS average_days_since_last_login
FROM clean_customer_churn;

-- =====================================================
-- 1. CUSTOMER DEMOGRAPHICS
-- =====================================================

-- Gender
-- Region
-- Age

-- Gender:

-- Finding:
-- Male customers had the highest churn rate (76%), while female customers had the lowest churn rate (75%).

-- Interpretation:
-- Although Male customers had the highest churn rate, the difference between genders was relatively so small.
-- The very small difference in churn rates suggests that gender is unlikely to be a strong predictor of customer churn.

-- Recommendation:
-- Since the difference in churn rates between genders is minimal, the company should focus its retention efforts on variables with stronger relationships to churn,
-- such as subscription plan, customer activity, or customer-service interactions.

-- Limitation:
-- This analysis identifies an association between gender and churn but does not establish a causal relationship.


select 
gender,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customer,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0  / count(*),2
	 ) as gender_churn_rate
from clean_customer_churn
group by gender
order by gender_churn_rate desc;



-- Region:

-- Finding:
--  Customers from the South had the highest churn rate (79%), while customers from the East had the lowest churn rate (72%).

-- Interpretation:
-- This may suggest that customer location is associated with customer retention, but it is unlikely to be the only factor influencing churn.

-- Recommendation:
-- The company should investigate why customers in the South have a higher churn rate by comparing customer characteristics, service quality, product usage, and customer feedback across regions.
-- If additional analysis identifies region-specific customer needs,
-- the company could develop targeted retention campaigns or tailor its marketing and service offerings for customers in the South.

-- Limitation:
-- This analysis identifies an association between Regions and churn but does not establish a causal relationship.

select 
region,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customer,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0  / count(*),2
	 ) as region_churn_rate
from clean_customer_churn
group by region
order by region_churn_rate desc;


-- Age:

-- Finding:
-- customers under 18 had the highest churn rate (76%), while customers aged 61 and above had the lowest churn rate (66%).

-- Interpretation:
-- This may suggest that age is associated with customer churn, 
-- although the differences may also reflect other factors such as customer behavior, purchasing habits, or product preferences.

-- Recommendation: 
-- The company should investigate why younger customers churn more frequently by comparing customer preferences, purchasing behavior, and product usage across age groups.
-- If younger customers have different needs or expectations, the company could develop targeted products, marketing campaigns, or retention strategies designed for this segment.

-- Limitation:
-- this analysis identifies an association between age and churn but does not establish a causal relationship.

with age_group as
(
	select *,
		CASE
			WHEN age IS NULL THEN 'Unknown'
			WHEN age < 18 THEN 'Under 18'
			WHEN age <= 25 THEN '18-25'
			WHEN age <= 40 THEN '26-40'
			WHEN age <= 60 THEN '41-60'
			ELSE '61+'
		END as groups_of_age
    from clean_customer_churn
)
, age_rate as
(
select 
groups_of_age,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customers,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*),2
	 ) as age_churn_rate
from age_group
group by groups_of_age
)
select * 
from age_rate
order by age_churn_rate desc;




-- =====================================================
-- 2. CUSTOMER ACCOUNT CHARACTERISTICS
-- =====================================================

-- Subscription Plan
-- Payment Method


-- Subscription Plan:

-- Finding:
--  Customers on the Basic subscription plan had the highest churn rate (80%), while customers on the Plus plan had the lowest churn rate (66%).

-- Interpretation:
-- This may suggest that Subscription_Plan is associated with customer retention, but it is unlikely to be the only factor influencing churn.

-- Recommendation:
-- The company should investigate why customers on the Basic plan churn more frequently by collecting customer feedback, analyzing feature usage,
-- and comparing customer characteristics across subscription plans.
-- If customers perceive insufficient value in the Basic plan, the company could consider enhancing its features or introducing targeted retention offers.

-- Limitation:
-- This analysis identifies an association between Subscription_Plan and churn but does not establish a causal relationship.


SELECT 
    Subscription_Plan,
    COUNT(*) total_customers,
    SUM(CASE
        WHEN churn = 1 THEN 1
        ELSE 0
    END) AS churned_customer,
    SUM(CASE
        WHEN churn = 0 THEN 1
        ELSE 0
    END) AS retained_customers,
    ROUND(SUM(CASE
                WHEN churn = 1 THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS subscription_plan_churn_rate
FROM
    clean_customer_churn
GROUP BY Subscription_Plan
ORDER BY subscription_plan_churn_rate DESC;



-- Payment Method:

-- Finding:
-- PayPal customers had the highest churn rate (77%), while customers paying by credit card had the lowest churn rate (74%).

-- Interpretation:
--  Although PayPal had the highest churn rate, the difference between payment methods was relatively small.
--  This may suggest that payment method is associated with customer retention, but it is unlikely to be the only factor influencing churn.

-- Recommendation:
-- The company should investigate the PayPal payment experience and compare customer characteristics across payment methods,
--  to determine whether additional factors contribute to the higher churn rate. 

-- Limitation:
-- This analysis identifies an association between payment method and churn but does not establish a causal relationship.


select 
Payment_Method,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customer,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0  / count(*),2
	 ) as payment_method_churn_rate
from clean_customer_churn
group by Payment_Method
order by payment_method_churn_rate desc;


-- =====================================================
-- 3. CUSTOMER BEHAVIOR
-- =====================================================

-- Activity Status
-- Customer Service Calls
-- Monthly Spending


-- Activity Status:

-- Finding:
-- Inactive Customers had the highest churn rate (86%), while Highly Active customers had the lowest churn rate (59%).

-- Interpretation:
-- This may suggest that customers who are more actively engaged with the service are less likely to churn, while inactive customers may be at a higher risk of leaving.

-- Recommendation:
-- The company should investigate the reasons behind customer inactivity by collecting customer feedback, and understanding why inactive customers stop using the service.
-- Based on these findings, the company could introduce personalized reminders, targeted promotions, or loyalty programs to encourage customers to become active again.
-- Given the large difference in churn rates, customer activity appears to be one of the strongest indicators of churn among the variables analyzed.

-- Limitation:
-- this analysis identifies an association between customer activity and churn and does not establish a causal relationship.

select 
round(avg(Days_Since_Last_Login), 2) AS average_Days_Since_Last_Login , churn
from clean_customer_churn
group by churn
order by churn;
 
with customers_activity as
(
	select *,
	CASE
		WHEN Days_Since_Last_Login IS NULL THEN 'Unknown'
		WHEN Days_Since_Last_Login <= 30 THEN 'Highly Active'
		WHEN Days_Since_Last_Login <= 90 THEN 'Moderately Active'
		ELSE 'Inactive'
	END as activity_status
    from clean_customer_churn
)
, activity_rate as
(
select 
activity_status,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customers,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*),2
	 ) as activity_churn_rate
from customers_activity
group by activity_status
)
select * 
from activity_rate
order by activity_churn_rate desc;


-- Customer Service Calls:

select Customer_Service_Calls
from clean_customer_churn
where Customer_Service_Calls > 5 ;

-- Finding:
-- Customers with a higher number of customer service calls had the highest churn rate (94%), while customers with fewer service calls had the lowest churn rate (72%).

-- Interpretation:
-- This may suggest that customers who repeatedly contact customer service are more likely to experience unresolved issues or dissatisfaction, 
-- which is associated with a higher likelihood of churn. 

-- Recommendation:
-- The company should investigate the reasons behind repeated customer service calls by collecting customer feedback,
-- identifying the most common service issues and complaints, and improving processes that reduce recurring support requests. 

-- Limitation:
-- this analysis identifies an association between customer service calls and churn and does not establish a causal relationship.



with customer_call_groups as
(
	select *,
		CASE
			WHEN Customer_Service_Calls IS NULL THEN 'Unknown'
			WHEN Customer_Service_Calls <= 2 THEN 'Low Service Calls'
			WHEN Customer_Service_Calls <= 5 THEN 'Medium Service Calls'
			ELSE 'High Service Calls'
		END as service_call_group
    from clean_customer_churn
)
, service_call_churn_rates as
(
select 
service_call_group,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customers,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*),2
	 ) as service_call_churn_rate
from customer_call_groups
group by service_call_group
)
select * 
from service_call_churn_rates
order by service_call_churn_rate desc;


-- Monthly Spending:

SELECT
    MIN(Monthly_Spend),
    MAX(Monthly_Spend),
    round(AVG(Monthly_Spend),2)
FROM clean_customer_churn;


-- Finding:
--  Customers with Zero Spending had the highest churn rate (83%), while customers with High Spending had the lowest churn rate (64%).

-- Interpretation:
-- This may suggest that Monthly Spending is associated with customer retention, but it is unlikely to be the only factor influencing churn.

-- Recommendation:
-- The company should investigate why customers with lower spending churn more frequently by collecting customer feedback,
-- analyzing why some customers spend little or nothing, and identifying the products, services, or features that encourage higher spending among retained customers.
-- If customers perceive that the value they receive does not justify the cost, the company could consider enhancing product features,
-- introducing personalized offers, or creating incentives that encourage greater engagement and spending.

-- Limitation:
-- This analysis identifies an association between Monthly_Spend and churn but does not establish a causal relationship.


with spendings as
(
	select *,
		CASE
			WHEN Monthly_Spend IS NULL THEN 'Unknown'
			WHEN Monthly_Spend = 0 THEN 'Zero Spending'
			WHEN Monthly_Spend <= 50 THEN 'Low Spending'
			WHEN Monthly_Spend <= 150 THEN 'Medium Spending'
			ELSE 'High Spending'
		END as spendings_groups
    from clean_customer_churn
)
, spending_rate as
(
select 
spendings_groups,
count(*) total_customers,
sum(case when churn = 1 then 1 else 0 end) as churned_customers,
sum(case when churn = 0 then 1 else 0 end) as retained_customers,
Round(
		sum(case when churn = 1 then 1 else 0 end) * 100.0 / count(*),2
	 )  as spending_churn_rate
from spendings
group by spendings_groups
)
select * 
from spending_rate
order by spending_churn_rate desc;




-- =====================================================
-- 4. RELATIONSHIP ANALYSIS
-- =====================================================


-- Subscription Plan vs Monthly Spending :

-- Finding:
 -- Subscription plan appears to be strongly associated with average monthly spending.
 -- Customers on the Plus plan had the highest average monthly spending ($159), while customers on the Basic plan had the lowest ($35).
 
 -- Interpretation:
 -- The average spending of Plus subscribers is more than four times higher than that of Basic subscribers,
 -- suggesting that higher-tier subscription plans are associated with greater customer spending.
 
 -- Recommendation:
 -- The company should investigate why customers on the Basic plan spend significantly less by analyzing customer behavior, feature usage, and upgrade patterns.
 -- If customers perceive limited value in lower-tier plans, the company could consider enhancing their features or introducing targeted upgrade incentives.

select
	Subscription_Plan,
    count(*) AS customers,
    round(AVG(Monthly_Spend), 2) as avg_monthly_spend
from clean_customer_churn
group by Subscription_Plan
order by avg_monthly_spend DESC ;


