--Get the number of employees who joined the company in 2006
-- First of all let extract the year like i.e '2006' from hire_date
-- Since the hire date is like '21-SEP-05 00:00:00', we need to get the correct year format 
-- To make our query easier, in that case we introduce SQL CTE so as we can store the 
-- Results of our query then use to get the total count of employees in a particular year
WITH UNIQUE_YEAR 
AS (SELECT EXTRACT(YEAR FROM HIRE_DATE) AS YEAR FROM employees)
SELECT COUNT(*) FROM UNIQUE_YEAR WHERE YEAR='2006';

--empolyees reporeted in 2008: 11
--empolyees reporeted in 2005: 29
--empolyees reporeted in 2003: 6
--empolyees reporeted in 2002: 7
--empolyees reporeted in 2004: 10
--empolyees reporeted in 2007: 19
--empolyees reporeted in 2006: 24
--empolyees reporeted in 2001: 1

--total number of employees is 11+29+6+7+10+19+24+1=107
