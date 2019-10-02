REPLACE PROCEDURE BetterDynamicProcedure(IN my_column VARCHAR(20), IN my_table VARCHAR(20))
--We have to tell it here that we will be returning a result set
DYNAMIC RESULT SETS 1
BEGIN
    --One variable for the sql string
    DECLARE my_sql VARCHAR(500);

    --And another for the cursor that we will open for the result set
    DECLARE my_cursor CURSOR WITH RETURN ONLY FOR my_statement;
    SET my_sql = 'SELECT ' || my_column || ' FROM tutorial.'||my_table;
    --Now we "prepare" the "statement" from our string
    PREPARE my_statement FROM my_sql;
    --and we open the cursor. We don't close it because we want it returned.
    OPEN my_cursor;
END;

CALL BetterDynamicProcedure('productid','product');