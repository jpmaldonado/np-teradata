GRANT CREATE PROCEDURE ON tutorialdb TO dbc;
REPLACE PROCEDURE CompareValues(IN val1 INT, IN val2 INT, OUT msg CHAR(20))
BEGIN
	CASE WHEN val1=val2 THEN SET msg='Equal values';
		 WHEN val1>val2 THEN SET msg='First is bigger';
	ELSE SET msg='Second is bigger';
	END CASE;
END;

CALL CompareValues(5,2, msg) /* Values get stored into msg, but not retrieved TODO... */

/* Example: A procedure that generates SQL "dynamically" 
Input: Name of a table
Output: Top 10 * from that table
*/

REPLACE PROCEDURE TablePreviewer(IN my_table VARCHAR(20))
DYNAMIC RESULT SETS 1
BEGIN 
	-- Create a SQL statement that concatenates a template query + my_table
	DECLARE sql_statement VARCHAR(500); -- Our future SQL statement
	DECLARE my_cursor CURSOR WITH RETURN ONLY FOR result_set; -- prepares a cursor
	
	SET sql_statement = 'SELECT TOP 10 * from tutorialdb.'||my_table||';';
	
	PREPARE result_set FROM sql_statement; --sql_statement is run on the DB, tabled is copied in result_set
	OPEN my_cursor;
END;
CALL TablePreviewer('product')







