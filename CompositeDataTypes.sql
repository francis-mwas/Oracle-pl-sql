/*
All the variables are stored in PGA in a database untill their scope finishes
PGA -> A Program Global Area (PGA) is a memory region that contains data and control information for a server process. 
Composite datatypes are used to hold multiple data/records
we have two composite data types i.e records, and collections
*/


-- Using record type to hold table row

DECLARE
    r_emp employees%rowtype; --you can access all columns of a table from this row
BEGIN
    SELECT
        *
    INTO r_emp
    FROM
        employees
    WHERE
        employee_id = 205;

    dbms_output.put_line(r_emp.first_name
                         || ' '
                         || r_emp.last_name);
END;

/* Creating our own type */

DECLARE
 --r_emp employees%rowtype;
 --creating a custom type called t_emp
    TYPE t_emp IS RECORD (
        first_name   VARCHAR2(50),
        last_name    employees.last_name%TYPE,
        salary       employees.salary%TYPE,
        hire_date    employees.hire_date%TYPE
    );
    r_emp t_emp; --using our custom record type
BEGIN
    SELECT
        first_name,
        last_name,
        salary,
        hire_date
    INTO r_emp
    FROM
        employees
    WHERE
        employee_id =205;

    dbms_output.put_line(r_emp.first_name
                         || ' '
                         || r_emp.last_name);
END;