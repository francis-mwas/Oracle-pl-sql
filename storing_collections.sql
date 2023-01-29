/***************** Storing Varray Example *******************/
CREATE OR REPLACE TYPE t_phone_number AS OBJECT(p_type   VARCHAR2(10), 
                                                p_number VARCHAR2(50)
                                               );
/
CREATE OR REPLACE TYPE v_phone_numbers AS VARRAY(3) OF t_phone_number;
/
CREATE TABLE emps_with_phones(employee_id  NUMBER,
                              first_name   VARCHAR2(50),
                              last_name    VARCHAR2(50),
                              phone_number v_phone_numbers);
/
SELECT * FROM emps_with_phones;
/
INSERT INTO emps_with_phones
VALUES(10,'Alex','Brown',v_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                         t_phone_number('WORK','222.222.2222'),
                                         t_phone_number('MOBILE','333.333.3333'))
                                         );
INSERT INTO emps_with_phones
VALUES((11,'Bob','Green',v_phone_numbers(t_phone_number('HOME','000.000.000'),
                                         t_phone_number('WORK','444.444.4444'))
                                         );                                                                
/
 
/*************** Querying the Varray Example ****************/
SELECT e.first_name,
       last_name,
       p.p_type,
       p.p_number 
FROM emps_with_phones e, table(e.phone_number) p;
 
 
/****** The Code For the Storing Nested Table Example *******/
CREATE OR REPLACE TYPE n_phone_numbers AS TABLE OF t_phone_number;
/
CREATE TABLE emps_with_phones2(employee_id  NUMBER,
                               first_name   VARCHAR2(50),
                               last_name    VARCHAR2(50),
                               phone_number n_phone_numbers)
                               NESTED TABLE phone_number STORE AS phone_numbers_table;
/
SELECT * FROM emps_with_phones2;
/
INSERT INTO emps_with_phones2 
VALUES(10,'Alex','Brown',n_phone_numbers(t_phone_number('HOME','111.111.1111'),
                                         t_phone_number('WORK','222.222.2222'),
                                         t_phone_number('MOBILE','333.333.3333'))
                                         );
INSERT INTO emps_with_phones2
VALUES(11,'Bob','Green',n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                        t_phone_number('WORK','444.444.4444'))
                                        );      
/
SELECT e.first_name, last_name, p.p_type, p.p_number 
FROM emps_with_phones2 e, table(e.phone_number) p;
 
/***************** New Insert and Update ********************/
INSERT INTO emps_with_phones2 
VALUES(11,'Bob','Green',n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                        t_phone_number('WORK','444.444.4444'),
                                        t_phone_number('WORK2','444.444.4444'),
                                        t_phone_number('WORK3','444.444.4444'),
                                        t_phone_number('WORK4','444.444.4444'),
                                        t_phone_number('WORK5','444.444.4444'))
                                        );    
SELECT * FROM emps_with_phones2;
 
UPDATE emps_with_phones2 
SET phone_number = n_phone_numbers(t_phone_number('HOME','000.000.000'),
                                   t_phone_number('WORK','444.444.4444'),
                                   t_phone_number('WORK2','444.444.4444'),
                                   t_phone_number('WORK3','444.444.4444'),
                                   t_phone_number('WORK4','444.444.4444'),
                                   t_phone_number('WORK5','444.444.4444'))
WHERE employee_id = 11;
 
/**** Adding a New Value into a Nested Inside of a Table ****/
DECLARE
  p_num n_phone_numbers;
BEGIN
  SELECT phone_number 
  INTO   p_num 
  FROM   emps_with_phones2 
  WHERE  employee_id = 10;
  
  p_num.extend;
  p_num(5) := t_phone_number('FAX','999.99.9999');
  
  UPDATE emps_with_phones2 
  SET    phone_number = p_num
  WHERE  employee_id  = 10;
END;
/************************************************************/