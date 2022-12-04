/*
    Creating and using sequnces in oracle database
*/

DROP TABLE employees_copy;

CREATE TABLE employees_copy
    AS
        SELECT
            *
        FROM
            employees;
--How touse a sequence in oracle database
CREATE SEQUENCE employee_id_seq START WITH 207 INCREMENT BY 1;

SELECT
    *
FROM
    employees_copy;

BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO employees_copy (
            employee_id,
            first_name,
            last_name,
            email,
            hire_date,
            job_id,
            salary
        ) VALUES (
            employee_id_seq.NEXTVAL,
            'employee#' || employee_id_seq.NEXTVAL,
            'temp_emp',
            'abc@gmail.com',
            SYSDATE,
            'web_dev',
            1000
        );

    END LOOP;
END;

/* Working with sequences in our table */
DECLARE
    v_seq_num NUMBER;
BEGIN
    --select employee_id_seq.nextval into v_seq_num from dual;
    SELECT
        employee_id_seq.NEXTVAL
    INTO v_seq_num
    FROM
        employees_copy
    WHERE
        ROWNUM = 1;

    dbms_output.put_line(v_seq_num);
END;

/* We can also work with dual table */
DECLARE
    v_seq_num NUMBER;
BEGIN
    select employee_id_seq.nextval into v_seq_num from dual;
    dbms_output.put_line(v_seq_num);
END;