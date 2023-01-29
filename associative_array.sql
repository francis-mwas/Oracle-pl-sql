/********************* The First Example ********************/
DECLARE
  TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
  emps e_list;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT first_name 
    INTO   emps(x) 
    FROM   employees 
    WHERE  employee_id = x ;
  END LOOP;
  FOR i IN emps.first()..emps.last() LOOP
    dbms_output.put_line(emps(i));
  END LOOP; 
END;
 
/********* Error Example for the SELECT INTO Clause *********/
DECLARE
  TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
  emps e_list;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT first_name 
    INTO   emps(x) 
    FROM   employees 
    WHERE  employee_id   = x 
    AND    department_id = 60;
  END LOOP;
  FOR i IN emps.first()..emps.last() LOOP
    dbms_output.put_line(i);
  END LOOP; 
END;
 
/******* Error Example about Reaching an Empty Index ********/
DECLARE
  TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
  emps e_list;
BEGIN
  emps(100) := 'Bob';
  emps(120) := 'Sue';
  FOR i IN emps.first()..emps.last() LOOP
    dbms_output.put_line(emps(i));
  END LOOP; 
END;
 
/*************************************************************
An Example of Iterating in Associative Arrays with WHILE LOOPs
*************************************************************/
DECLARE
  TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY PLS_INTEGER;
  emps e_list;
  idx  PLS_INTEGER;
BEGIN
  emps(100) := 'Bob';
  emps(120) := 'Sue';
  idx       := emps.first;
 
  WHILE idx IS NOT NULL LOOP 
    dbms_output.put_line(emps(idx));
    idx := emps.next(idx);
  END LOOP; 
END;
 
/*************************************************************
An Example of Using String-based Indexes with Associative Arrays
*************************************************************/
DECLARE
  TYPE e_list IS TABLE OF employees.first_name%TYPE INDEX BY employees.email%type;
  emps         e_list;
  idx          employees.email%TYPE;
  v_email      employees.email%TYPE;
  v_first_name employees.first_name%TYPE;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT first_name, email 
    INTO   v_first_name, v_email 
    FROM   employees
    WHERE  employee_id = x;
    emps(v_email) := v_first_name;
  END LOOP;
 
  idx := emps.first;
  WHILE idx IS NOT NULL LOOP 
    dbms_output.put_line('The email of '|| emps(idx) ||' is : '|| idx);
    idx := emps.next(idx);
  END LOOP; 
END;
 
/*** An Example of Using Associative Arrays with Records ****/
DECLARE
  TYPE e_list IS TABLE OF employees%rowtype INDEX BY employees.email%TYPE;
  emps e_list;
  idx  employees.email%type;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT * 
    INTO   emps(x) 
    FROM   employees
    WHERE  employee_id = x;
  END LOOP;
 
  idx := emps.first;
  
  WHILE idx IS NOT NULL LOOP 
    dbms_output.put_line('The email of '      || 
                         emps(idx).first_name || ' '     ||
                         emps(idx).last_name  || ' is : '|| emps(idx).email);
    idx := emps.next(idx);
  END LOOP; 
END;
 
/* An Example of Using Associative Arrays with Record Types */
DECLARE
  TYPE e_type IS RECORD (first_name employees.first_name%TYPE,
                         last_name  employees.last_name%TYPE,
                         email      employees.email%TYPE);
  TYPE e_list IS TABLE OF e_type INDEX BY employees.email%TYPE;
  emps e_list;
  idx  employees.email%type;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT first_name,last_name,email 
    INTO   emps(x) 
    FROM   employees
    WHERE  employee_id = x;
  END LOOP;
 
  idx := emps.first;
 
  WHILE idx IS NOT NULL LOOP
    dbms_output.put_line('The email of '       || 
                          emps(idx).first_name || ' ' ||
                          emps(idx).last_name  || ' is : ' || 
                          emps(idx).email);
    idx := emps.next(idx);
  END LOOP; 
END;
 
/**** An Example of Printing From the Last to the First *****/
DECLARE
  TYPE e_type IS RECORD (first_name employees.first_name%TYPE,
                         last_name  employees.last_name%TYPE,
                         email      employees.email%TYPE);
  TYPE e_list IS TABLE OF e_type INDEX BY employees.email%TYPE;
  emps e_list;
  idx  employees.email%type;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT first_name,last_name, email 
    INTO   emps(x) 
    FROM   employees
    WHERE  employee_id = x;
  END LOOP;
  
  --emps.delete(100,104);
  idx := emps.last;
  
  WHILE idx IS NOT NULL LOOP 
    dbms_output.put_line('The email of '       || 
                          emps(idx).first_name || ' '     ||
                          emps(idx).last_name  ||' is : ' || 
                          emps(idx).email);
    idx := emps.prior(idx);
  END LOOP; 
END;
 
/***** An Example of Inserting with Associative Arrays ******/
CREATE TABLE employees_salary_history 
AS SELECT * FROM employees WHERE 1=2;
 
ALTER TABLE employees_salary_history ADD insert_date DATE;
 
SELECT * FROM employees_salary_history;
/
DECLARE
  TYPE e_list IS TABLE OF employees_salary_history%rowtype INDEX BY PLS_INTEGER;
  emps e_list;
  idx  PLS_INTEGER;
BEGIN
  FOR x IN 100 .. 110 LOOP
    SELECT e.*,'01-JUN-20' 
    INTO   emps(x) 
    FROM   employees e
    WHERE  employee_id = x;
  END LOOP;
  
  idx := emps.first;
  
  WHILE idx IS NOT NULL LOOP 
    emps(idx).salary := emps(idx).salary + emps(idx).salary*0.2;
    INSERT INTO employees_salary_history VALUES emps(idx);
    dbms_output.put_line('The employee '       || emps(idx).first_name ||
                         ' is inserted to the history table');
    idx := emps.next(idx);
  END LOOP; 
END;
/
DROP TABLE employees_salary_history;
