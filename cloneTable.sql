CREATE TABLE employees_copy
    AS
        SELECT
            *
        FROM
            employees;

SELECT
    *
FROM
    employees_copy;




/* INSERT DATA INTO A CLONED TABLE */

DECLARE
    v_salary_increase NUMBER := 400;
BEGIN
    FOR i IN 207..216 LOOP
    INSERT INTO employees_copy
   (employee_id, first_name, last_name, email, hire_date, job_id, salary)
    VALUES
   (i,'employeed_id#'||i, 'temp_emp','abc123@gmail.com', sysdate, 'Web_dev', 2500);
    END LOOP;
END;


/*UPDATE DATABASE TABLE IN PL/SQL*/

DECLARE
    v_salary_increase NUMBER := 400;
BEGIN
    FOR i IN 207..216 LOOP
        UPDATE employees_copy
        SET
            salary = v_salary_increase + salary
        WHERE
            employee_id = i;

    END LOOP;
END;


/* DELETE DATA WITH PLSQL */
begin
 for i in 207..216 loop
 DELETE FROM employees_copy
WHERE
    employee_id = i;
 end loop;
end;