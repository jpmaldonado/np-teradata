REPLACE PROCEDURE tutorial.DynamicProcedure(IN optionv VARCHAR(20))
DYNAMIC RESULT SETS 1

BEGIN
/* Declaring dynamic cursor to get output as resultset  */
    DECLARE select_1 CURSOR WITH RETURN ONLY TO CLIENT FOR
    SELECT customername FROM tutorial.customer;
    
    DECLARE select_2 CURSOR WITH RETURN ONLY TO CLIENT FOR
    SELECT customerzip FROM tutorial.customer;
    
    DECLARE select_3 CURSOR WITH RETURN ONLY TO CLIENT FOR
    SELECT productname FROM tutorial.Product;
    
    DECLARE select_4 CURSOR WITH RETURN ONLY TO CLIENT FOR
    SELECT * FROM tutorial.Product;
    
/* Opening dynamic cursor using passed parameter */
    CASE optionv --Argument given by user
    WHEN 'cust' THEN OPEN select_1;
    WHEN 'zip' THEN OPEN select_2;
    WHEN 'prod' THEN OPEN select_3;
    ELSE OPEN select_4;
    END CASE;
END;