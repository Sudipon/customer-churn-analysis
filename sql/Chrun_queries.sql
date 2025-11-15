create database capstone_ptoject;

use capstone_ptoject;
rename table `customer-churn-records` to customer_churn_records;
select * from customer_churn_records;

select count(Customerid) as Total_customers from customer_churn_records;

select Exited,count(*) as Total_customers from customer_churn_records group by Exited;

select avg(CreditScore) as Average_Creditscore from  customer_churn_records;

select Geography,count(CustomerId) as Total_customers from customer_churn_records group by Geography;

select Gender,count(CustomerId) as Total_customers from customer_churn_records group by Gender;

select Balance,count(CustomerId) as Total_customers from customer_churn_records where Balance = 0;

select avg(Balance) as Average_Balance_Chruned_Customer from customer_churn_records where Exited = 1;

select * from customer_churn_records; 

select Geography,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS Churn_Rate
from customer_churn_records group by Geography order by Churn_Rate DESC;

select avg(Tenure) as Average_Tenure_NonChruned_Customer from customer_churn_records where Exited = 0;

select Surname, CustomerId, EstimatedSalary from customer_churn_records where Exited = 1 order by EstimatedSalary desc limit 5;

select count(*) as Active_Members_More_Than_2_Products from customer_churn_records where IsActiveMember = 1 and NumOfProducts > 2;

select IsActiveMember, avg(Balance) as Average_Balance from customer_churn_records group by IsActiveMember;

select Gender, avg(EstimatedSalary) as Average_EstimatedSalary from customer_churn_records group by Gender;

select Tenure, count(*) as Total_Chruned_Customer from customer_churn_records where Exited = 1 group by Tenure order by Tenure;

select NumOfProducts,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*), 
        2
    ) AS Churn_Rate from customer_churn_records group by NumOfProducts order by NumOfProducts;
    
select 
    case 
        when Age between 18 and 30 then '18–30'
        when Age between 31 and 45 then '31–45'
        when Age between 46 and 60 then '46–60'
        when Age > 60 then '60+'
        else 'Below 18'
    end as AgeGroup,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) as Churn_Rate from customer_churn_records group by AgeGroup order by AgeGroup;
    
select Geography, Gender, 
	ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) as Churn_Rate from customer_churn_records group by Geography, Gender order by Churn_Rate desc; 
    
select Geography,avg(CreditScore) as Average_CreditScore, avg(Balance) as Average_Balance 
	from customer_churn_records
    where Exited = 1
    group by Geography;

select ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) as Churn_Rate from customer_churn_records where HasCrCard = 0;
    
select CustomerID, SurName, Balance from customer_churn_records
	where Balance > (
		select avg(Balance)
		from customer_churn_records
		where Exited = 1
)
order by Balance;

SELECT Geography AS Country,
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS CountryChurnRate FROM customer_churn_records GROUP BY Geography
HAVING 
    ROUND(
        100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) > (
        SELECT 
            ROUND(
                100.0 * SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) / COUNT(*),
                2
            ) FROM customer_churn_records
    ) ORDER BY CountryChurnRate DESC;
