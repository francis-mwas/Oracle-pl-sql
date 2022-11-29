-- What is a sub-query? How does SQL process a statement containing sub-query?



/* Question 1: Find the employees who's salary is more than the average salary earned by all employees*/

select avg(salary) employe_salary from employees;
--AVG salary is 6461
select * from employees where salary > (select avg(salary) employe_salary from employees);

/* TYPES OF SUBQUERY */
/*
1. Scalar Subquery
2. Multiple row subquery
3. Correlated subquery
*/

-- Scalar Subquery -> returns one row and one column
--example below
select avg(salary) employe_salary from employees;

select * from employees e 
join (select avg(salary) sal from employees) avg_sal
 on e.salary > avg_sal.sal;
 
--Multiple row subquery - returns multiple rows and columns
  -- i).  subquery which returns multiple column and multiple rows
  -- ii). subquery which returns only one column and multiple rows
-- Question 2: Find the employees who earn the highest salary in each department


--CTE
with employee_with_max_sal as(
select department_name, max(salary) max_salary
 from employees emps join departments using(department_id) group by department_name;
)



select * from employees where (department_name, salary) 
in (select department_name, max(salary) max_salary
           from employees emps join departments using(department_id) group by department_name);


-- subquery which returns only one column and multiple rows
--Question 3: Find the department that do not have any employees
select distinct department_name from employees inner join departments using(department_id); --get all the departments
WITH DEPART_EMPS AS
(select distinct department_name from employees inner join departments using(department_id))



select * from employees emp where department_name not in DEPART_EMPS inner join
    departments on departments.department_id= emp.department_id;

--Correlated subquery - A subquery that is dependent on other queries -> its related to the outer query
-- Question 4: Find the employees in each department who earn more than the average salary in that department 



select * from departments d where not exists (select 1 from employees e where e.department_id = d.department_id);

select 1 from employees e where e.department_id = 90;

select * from departments where department_name='Payroll';

select * from employees where department_id=270;


--Nested subquery
--Question 5: Find stores who's sales better than the average sales accross all stores
/*
1. find the total sales for each store
2. find the average sales for all stores
3. compare 1 and 2
*/
select store_name, sum(price) as total_sales from sales order by store_name;


select * from (select store_name, sum(price) as total_sales 
    from sales
    group by store_name) sales
join (select avg(total_sales) as sales)
    from (select store_name, sum(price)as total_sales
    from sales
    group by store_name) x) avg_sales
    on sales.total_sales > avg_sales.sales;


--To avoid nested subqueries like above, lets utilize the use of WITH clause

WITH SALES AS 
(select store_name, sum(price) as total_sales 
    from sales
    group by store_name)
    
select * 
    from SALES
join (select avg(total_sales) as sales)
    from SALES x) avg_sales
    on sales.total_sales > avg_sales.sales



--SUBQUERY IN SELECT CLAUSE 
--Question 6: Fetch all the employee details and add remarks to those employee who earns more than the average pay
select *, (case when salary > (select avg(salary) from employees)
           then 'Higher than average pay'
        else null
       end ) as remarks
from employees;
-- Above alternative
select *, (case when salary > avg_salary.sal
           then 'Higher than average pay'
        else null
       end ) as remarks
from employees  cross join  (select avg(salary) sal from employees) avg_salary;



--INSERT WITH SUBQUERY
--Question 7: Insert data to employee_history.Make sure not insert duplicates records
insert into employee_history
select e.emp_id, e.emp_name,d.dept_name,e.salary,d.location
from employee e
join departments d on d.department_id = e.department_id
where not exists (select 1
                    from employee_history eh
                    where eh.employee_id);



--UPDATE 



