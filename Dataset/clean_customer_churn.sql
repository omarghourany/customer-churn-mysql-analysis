select *
from customer_churn;

DROP TABLE IF EXISTS clean_customer_churn;
DROP TABLE IF EXISTS customer_churn_no_duplicates;

-- create new table that take the customer_churn data

create table clean_customer_churn
select *
from customer_churn;

-- check if the clean_customer_churn take the exact number of rows of customer_churn
select count(*)
from customer_churn;

select count(*)
from clean_customer_churn;

-- remove duplicates

select *
from clean_customer_churn;

-- Check for repeated Customer_ID values

SELECT Customer_ID, COUNT(*) AS occurrences
FROM clean_customer_churn
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- check if the duplicate rows are identical or not by trying some Customer_ID

select *
from clean_customer_churn
where  Customer_ID= 10188 or Customer_ID= 10198 or Customer_ID=10200 ;

-- creating a new table that does not take the duplicates from clean_customer_churn 

CREATE TABLE customer_churn_no_duplicates AS
SELECT DISTINCT *
FROM clean_customer_churn;

 -- check if there any another duplicates 
 
with duplicate_customer as(
	select *,
    row_number() over(partition by
    Customer_ID ,Gender ,Region,Subscription_Plan,Payment_Method,age,Days_Since_Last_Login,Customer_Service_Calls,Monthly_Spend,churn) as row_num
	from customer_churn_no_duplicates 
)
select *
from duplicate_customer
where row_num > 1;

-- dropping the old duplicates clean_customer_churn table , then rename table customer_churn_no_duplicates to clean_customer_churn;

drop table clean_customer_churn;
rename table customer_churn_no_duplicates to clean_customer_churn;

-- Recheck that duplicate rows were removed

select *
from clean_customer_churn
where  Customer_ID= 10198;

-- standardize data

-- 1_fix messy data

select *
from clean_customer_churn;


-- Standardize inconsistent capitalization in Region and Subscription_Plan

select distinct region
from clean_customer_churn
;

update clean_customer_churn
set region = concat(upper(left(region,1)) , lower(substring(region,2)));


select Subscription_Plan
from clean_customer_churn
;

update clean_customer_churn
set Subscription_Plan = concat(upper(left(Subscription_Plan,1)) , lower(substring(Subscription_Plan,2)));

-- Replace impossible ages with NULL.
-- NULL is preferred because we cannot infer the customer's real age.

UPDATE clean_customer_churn
SET Age = NULL
WHERE Age = ''
   OR Age <= 0
   OR Age > 100;
   
-- change the age column data type from text to integer
alter table clean_customer_churn
modify column Age int;

-- Check for negative Days_Since_Last_Login values

SELECT Customer_ID,Days_Since_Last_Login
FROM clean_customer_churn
WHERE Days_Since_Last_Login < 0;



-- NULL is preferred in Customer_Service_Calls because we cannot infer if the Customer_Service_Calls it a data entry mistake.
-- Negative Monthly_Spend values are treated as invalid because this
-- column represents customer spending, and the dataset provides no
-- indication that negative values represent refunds or account credits.
-- They are changed to NULL because the true values cannot be inferred.

select Customer_ID,Customer_Service_Calls
from clean_customer_churn
where Customer_Service_Calls < 0;

update clean_customer_churn
set Customer_Service_Calls = null
where Customer_Service_Calls < 0
;
  
select Customer_ID,monthly_spend
from clean_customer_churn
where Monthly_Spend < 0;

update clean_customer_churn
set Monthly_Spend  = null
where Monthly_Spend < 0;

-- Monthly_Spend contained 11 records with a value of 99999.99.
-- This value was considered invalid because it was significantly higher
-- than all other observations (maximum valid value: 311.39).
-- These values were replaced with NULL to represent missing data.

SELECT DISTINCT Monthly_Spend
FROM clean_customer_churn
ORDER BY Monthly_Spend DESC
LIMIT 10;

UPDATE clean_customer_churn
SET Monthly_Spend = NULL
WHERE Monthly_Spend = 99999.99;
-- handle nulls and blank values
 
select  Payment_Method
from clean_customer_churn;

update clean_customer_churn
set Payment_Method = null
where Payment_Method = '';

select *
from clean_customer_churn;
