/*********************** Nested Loops ***********************/
DECLARE
 v_inner NUMBER := 1;
BEGIN
 FOR v_outer IN 1..5 LOOP
  dbms_output.put_line('My outer value is : ' || v_outer );
    v_inner := 1;
    LOOP
      v_inner := v_inner+1;
      dbms_output.put_line('  My inner value is : ' || v_inner );
      EXIT WHEN v_inner * v_outer >= 15;
    END LOOP;
 END LOOP;
END;
/************************************************************/
 
/**************** Nested Loops with Labels ******************/
DECLARE
 v_inner NUMBER := 1;
BEGIN
<<outer_loop>> --labels
 FOR v_outer IN 1..5 LOOP
  dbms_output.put_line('My outer value is : ' || v_outer );
    v_inner := 1;
    <<inner_loop>> --labels
    LOOP
      v_inner := v_inner+1;
      dbms_output.put_line('  My inner value is : ' || v_inner );
      EXIT outer_loop WHEN v_inner * v_outer >= 16;
      EXIT WHEN v_inner * v_outer >= 15;
    END LOOP inner_loop;
 END LOOP outer_loop;
END;
/************************************************************/