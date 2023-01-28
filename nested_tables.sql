
/*************** Simple nested tables example *****************/

DECLARE
    TYPE employeesT_list IS
        TABLE OF VARCHAR2(50);
    employeesT employeesT_list;
BEGIN
    employeesT := employeesT_list('John', 'Doe', 'Jane', 'Morgan');
    FOR i IN 1..employeesT.count() LOOP dbms_output.put_line(employeesT(i));
    END LOOP;

END;
 
/************************************************************
Adding a New Value to a Nested Table After the Initialization
*************************************************************/
DECLARE
  TYPE employeesT_list IS TABLE OF VARCHAR2(50);
  employeesT employeesT_list;
BEGIN
  employeesT := employeesT_list('Alex','Bruce','John');
  employeesT.extend; --using exend function
  employeesT(4) := 'Bob';
  FOR i IN 1..employeesT.count() LOOP
    dbms_output.put_line(employeesT(i));
  END LOOP;
END;
 

/*************** Adding Values From a Table *****************/
DECLARE
  TYPE employeesT_list IS TABLE OF employeesT.first_name%type;
  employeesT employeesT_list := employeesT_list();
  idx  PLS_INTEGER:= 1;
BEGIN
  FOR x IN 100 .. 110 LOOP
    dbms_output.put_line("The emp Id is: "|| idx);
    employeesT.extend;
    SELECT first_name INTO employeesT(idx) 
    FROM   employeesT 
    WHERE  employee_id = x;
    idx := idx + 1;
  END LOOP;
  FOR i IN 1..employeesT.count() LOOP
    dbms_output.put_line(employeesT(i));
  END LOOP;
END;
 
/********************* Delete Example ***********************/
DECLARE
  TYPE employeesT_list IS TABLE OF employeesT.first_name%type;
  employeesT employeesT_list := employeesT_list();
  idx  PLS_INTEGER := 1;
BEGIN
  FOR x IN 100 .. 110 LOOP
    employeesT.extend;
    SELECT first_name INTO employeesT(idx) 
    FROM   employees 
    WHERE  employee_id = x;
    idx := idx + 1;
  END LOOP;
  employeesT.delete(3);
  FOR i IN 1..employeesT.count() LOOP
    IF employeesT.exists(i) THEN 
       dbms_output.put_line(employeesT(i));
    END IF;
  END LOOP;
END;