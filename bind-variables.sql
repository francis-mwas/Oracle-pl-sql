--------------------------BIND VARIABLES--------------------------
set serveroutput on;
set autoprint on; --enable autoprint
/
variable var_text varchar2(30);
/
variable var_number NUMBER;
/
variable var_date DATE; --bind variable
/
declare
v_text varchar2(30);
begin
:var_text := 'Hello SQL'; --initializing a bind variable
:var_number := 20;
v_text := :var_text;
--dbms_output.put_line(v_text);
--dbms_output.put_line(:var_text);
end;
/
print var_text;
/
variable var_sql number;
/
begin 
  :var_sql := 100;
end;
/
select * from employees where employee_id = :var_sql;
/*------------------------BIND VARIABLES--------------------------
NOTE: When you run a bind variable creation and SELECT statement 
together, SQL Developer may return an error but when you execute 
them separately, there will be no problem.
----------------------------------------------------------------*/