/* EXAMPLE: Generating dynamic SQL. 
Input: Name of table.
Output: select top 10 * from that table
*/

REPLACE PROCEDURE TablePreviewer(IN my_table VARCHAR(20))
DYNAMIC RESULT SETS 1
BEGIN
	-- Create the SQL statement through concatenation of template + argument.
	-- Open a cursor to the database, push this statement and get it back to user
	DECLARE sql_statement VARCHAR(500); -- Our future SQL statement
	DECLARE my_cursor CURSOR WITH RETURN ONLY FOR result_set;
	
	SET sql_statement = 'SELECT top 10 * FROM tutorial.'||my_table||';';
	
	PREPARE result_set FROM sql_statement; --Gets ready to get the data
	OPEN my_cursor;
		
END;

CALL TablePreviewer('salestransaction')

/* Homework: Extend GetShopperOfProduct to many products. Hint: Use this code + previous code + below*/
--my_prods = ('Tiny Tent','Mega Camera')
--'select * from product where productname in'||'''||my_prods||'''


