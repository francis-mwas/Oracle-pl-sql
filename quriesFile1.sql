select ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12, 0) from employees ORDER BY hire_date asc;

select TRUNC(months_between(sysdate, hire_date)/12) from employees  order by hire_date desc;

select add_months(SYSDATE, 7) from employees;

select emp.first_name, emp.email, emp.last_name,dep.department_name from employees emp inner join departments dep on emp.department_id=dep.department_id ORDER BY emp.first_name asc;

select emp.first_name, emp.email, emp.last_name,dep.department_name from employees emp left join departments dep on emp.department_id=dep.department_id where emp.department_id is null
ORDER BY emp.first_name asc;


SELECT * from employees inner join departments using(department_id) where departments.department_name='Shipping';

SELECT count(*) from employees  inner join departments on departments.department_id = employees.department_id
where departments.department_name='Shipping';


SELECT * from employees inner join departments using(department_id) where departments.department_name='Shipping' ORDER BY employees.hire_date desc;

SELECT count(*) from employees  inner join departments using(department_id)
where departments.department_name='Shipping' and job_id = 'ST_CLERK';

--joining three tables employees,jobs, and departments
select first_name  || ' ' || last_name fullName, salary,job_title,department_name, hire_date from employees inner join departments using(department_id) inner join
jobs on jobs.job_id = employees.job_id where jobs.job_title='Sales Representative' ORDER BY employees.hire_date desc ;

select emp.first_name  || ' ' || emp.last_name fullName, emp.salary, j.job_title,dep.department_name, emp.hire_date from employees emp inner join departments dep using(department_id) inner join
jobs j on j.job_id = emp.job_id where j.job_title='Sales Representative' and salary BETWEEN 4000 and 7000 ORDER BY emp.hire_date desc;


--creating employees views
CREATE VIEW employees_view AS
     select employee_id employeeId, first_name  || ' ' || last_name fullName, department_name, job_title,salary from employees left join departments on departments.department_id = employees.department_id
    
    left join jobs on jobs.job_id = employees.job_id and salary between 1000 and 10000;


--querying from the employees_view
select * from employees_view;

--create view with all employees  details
CREATE OR REPLACE VIEW  EMP_DETAILS_FROM_ALL_TABLES AS
SELECT
  e.employee_id, 
  e.job_id, 
  e.manager_id, 
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name FULLNAME,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title TITLE,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id;

----PL/SQL-----
--the sysntax of using SELECT in PL/SQL is:
-- SELECT COLUMN INTO MEMORY_VARIABLE FROM table_name [WHERE CONDITION and other clauses];

--syntax for more than one column 
-- SELECT COLUMN1,COLUMN2 INTO MEMORY_VARIABLE1,  MEMORY_VARIABLE1  FROM table_name [WHERE CONDITION and other clauses];

select * from EMP_DETAILS_FROM_ALL_TABLES;
--USING CASE
DECLARE
VSALARY1 VACHAR2(18);
BEGIN
SELECT INTO VSALARY1 FROM EMPLOYYES WHERE SALARY=4000 AND EMAIL='SBELL';

CASE VSALARY1
WHEN 4000 THEN
DBMS_OUTPUT.PUT_LINE('The employee earns 4000 only');
WHEN 5000 THEN
DBMS_OUTPUT.PUT_LINE('The employee earns 5000 only');
WHEN 6000 THEN 
DBMS_OUTPUT.PUT_LINE('The employee earns 6000 only');

ELSE
DBMS_OUTPUT.PUT_LINE('UNKNOWN VALUES!!');
END CASE
END;

DECLARE
name VARCHAR2(20) :='mwas';
age NUMBER not null :=23;
email CONSTANT VARCHAR2(20) :='mwas@gmail.com';

salary number(10):=45000;

ename varchar2(19) :='SID';

N1 number(10) :=45;
V1 VARCHAR2(10) :='HEY';

VSALARY NUMBER(10,2);
VDEPARTMENT NUMBER(4);


BEGIN
DBMS_OUTPUT.PUT_LINE(email);
DBMS_OUTPUT.PUT_LINE(TO_CHAR(salary));
DBMS_OUTPUT.PUT_LINE(name);

DBMS_OUTPUT.PUT_LINE('THE NAME IS ' || ename);

DBMS_OUTPUT.PUT_LINE(TO_CHAR(N1));
DBMS_OUTPUT.PUT_LINE(V1);

SELECT SALARY,DEPARTMENT_ID INTO VSALARY, VDEPARTMENT FROM employees where first_name='Lex';

DBMS_OUTPUT.PUT_LINE('The employee salary is: '  || TO_CHAR(vsalary) || 'AND DEPARTMENT ID IS: '|| TO_CHAR(vdepartment));
end;







-----------------------===================-----------------------
-----------------------DECLARING VARIABLES-----------------------
-----------------------===================-----------------------
SET SERVEROUTPUT ON;
DECLARE 
    v varchar2(20) := 2 + 25 * 3;
BEGIN
    dbms_output.put_line(v);
END;
-----------------------===================-----------------------
DECLARE 
    v_text varchar2(50) NOT NULL DEFAULT 'Hello';
    v_number1 number := 50;
    v_number2 number(2) := 50.42;
    v_number3 number(10,2) := 50.42;
    v_number4 PLS_INTEGER := 50;
    v_number5 BINARY_float := 50.42;
    v_DATE1 DATE := '22-NOV-18 12:01:32';
    v_DATE2 timestamp := systimestamp;
    v_DATE3 timestamp(9) WITH TIME ZONE := systimestamp;
    v_DATE4 interval day(4) to second (3) := '124 02:05:21.012 ';
    v_DATE5 interval year to month := '12-3';
BEGIN
    V_TEXT := 'PL/SQL' || 'Course';
    DBMS_OUTPUT.PUT_LINE(V_TEXT);
    DBMS_OUTPUT.PUT_LINE(v_number1);
    DBMS_OUTPUT.PUT_LINE(v_number2);
    DBMS_OUTPUT.PUT_LINE(v_number3);
    DBMS_OUTPUT.PUT_LINE(v_number4);
    DBMS_OUTPUT.PUT_LINE(v_number5);
    DBMS_OUTPUT.PUT_LINE(v_DATE1);
    DBMS_OUTPUT.PUT_LINE(v_DATE2);
    DBMS_OUTPUT.PUT_LINE(v_DATE3);
    DBMS_OUTPUT.PUT_LINE(v_DATE4);
    DBMS_OUTPUT.PUT_LINE(v_DATE5);
    END;
----------------==================================---------------
----------------USING BOOLEAN DATA TYPE in PL/SQL----------------
----------------==================================---------------
DECLARE
    v_boolean boolean := true;
BEGIN
    dbms_output.put_line(sys.diutil.bool_to_int(v_boolean));
END;
----------------==================================---------------