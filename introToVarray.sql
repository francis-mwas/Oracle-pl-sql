

--Working with Varray

DECLARE
    TYPE e_list is varray(5) of VARCHAR2(50);
    employees e_list;
BEGIN
 employees :=e_list('Mwas','Fram','Hohn','Doe','Jane');
 for i in 1..5 loop
    dbms_output.put_line(employees(i));
 end loop;
end;
