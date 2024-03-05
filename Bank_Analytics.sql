create database bank_loan;
use bank_loan;
select*from finance_1;
select*from finance_2;
select count(*) from finance_1;
select count(*) from finance_2;
-----------------------------------------------------------------------------------------------------

# KPI 1 Year wise loan amount Stats

SELECT 
    Year(issue_d) AS issue_years,
    SUM(loan_amnt) AS total_amount
FROM
    finance_1
GROUP BY issue_years
ORDER BY total_amount;

------------------------------------------------------------------------------------------------

#KPI 2 Grade and sub grade wise revol_bal
Select f1.grade, f1.sub_grade, sum(f2.revol_bal) as revolving_bal
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
group by f1.grade, f1.sub_grade
order by f1.grade;

-- -------------------------------------------------------------------------------------------------------

#KPI 3 Total Payment for Verified Status Vs Total Payment for Non Verified Status
SELECT f1.verification_status,
CONCAT(ROUND(SUM(f2.total_pymnt) / 1000000, 2) , ' millions') as total_payment
FROM finance_1 f1
LEFT JOIN finance_2 f2 ON f1.id = f2.id
GROUP BY f1.verification_status
HAVING f1.verification_status IN ('verified', 'not verified');

 ----------------------------------------------------------------------------------------------------------------------------    
# KPI 4 State wise and last_credit_pull_d wise loan status    
SELECT fn1.addr_state,fn2.last_credit_pull_d,fn1.loan_status
FROM finance_1 fn1
LEFT JOIN finance_2 fn2
ON fn1.id=fn2.id
GROUP BY fn1.addr_state, fn2.last_credit_pull_d, fn1.loan_status
ORDER BY fn1.addr_state, fn2.last_credit_pull_d, fn1.loan_status;    
------------------------------------------------------------------------------------------------------------

# KPI 5 Home ownership Vs last payment date stats
SELECT home_ownership, last_pymnt_d
FROM finance_1 fn1
LEFT JOIN finance_2 fn2
ON fn1.id=fn2.id
GROUP BY home_ownership, last_pymnt_d;
