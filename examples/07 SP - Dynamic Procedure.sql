/* DYNAMIC PROCEDURE EXAMPLE 
- Get an option from the user and execute a different query 
- Option 1: Runs a query from customer table
- Option 2: Runs a query from the sales table
*/
DATABASE tutorialdb;

REPLACE PROCEDURE ChooseQuery(IN optionv CHAR(20))
DYNAMIC RESULT SETS 1
BEGIN 
	/*If optionv == 'cust' then select * from customer */
	/* if optionv === 'sales' then select * from salestransaction */
	/* select -1 if none/something else */
	DECLARE cur1 CURSOR WITH RETURN ONLY TO client FOR SELECT * FROM customer;
	DECLARE cur2 CURSOR WITH RETURN ONLY TO client FOR SELECT * FROM salestransaction;
	DECLARE cur3 CURSOR WITH RETURN ONLY TO client FOR SELECT -1;
	
	CASE optionv 
		WHEN 'cust' THEN OPEN cur1; 
		WHEN 'sales' THEN OPEN cur2; 
		ELSE OPEN cur3; 
	END CASE;
	
	-- TODO: Check for which cursor was opened, then close it
	
END;

CALL ChooseQuery('cust');


/* Example: Create a lot of tables with the same schema, just different names */
REPLACE PROCEDURE spCreateSalesTable(
										IN tName VARCHAR(30)
										, IN dbName VARCHAR(30)
										, OUT sql_query VARCHAR(256))
BEGIN 
	DECLARE cols VARCHAR(128) DEFAULT '(item INT, price DECIMAL(8,2), sold INTEGER);';
	SET sql_query = 'CREATE TABLE '|| dbName ||'.'||tName||cols;
--	CALL dbc.SysExecSQL(sql_query);
END;

CALL spCreateSalesTable('salesWAW','tutorialdb',q);
SELECT * FROM salesWAW;

SHOW PROCEDURE CompareValues
