SELECT * 
FROM dbc.tables 
WHERE tablekind='P' AND databasename='tutorialdb';

DATABASE tutorialdb;
SHOW PROCEDURE CompareValues; -- Will not show anything in SQL Assistant, need BTEQ

/* DYNAMIC RESULT SETS: Retrieving output from SP*/

REPLACE PROCEDURE ShowSamples() -- show top 5 of two different tables
DYNAMIC RESULT SETS 2
BEGIN 
	DECLARE cursor1 CURSOR WITH RETURN ONLY FOR 
		SELECT TOP 5 * FROM Product;
		
	DECLARE cursor2 CURSOR WITH RETURN ONLY FOR
		SELECT TOP 5 * FROM soldvia;
		
	-- Open the cursors to retrieve data
	OPEN cursor1;
	OPEN cursor2;
END;

CALL ShowSamples();

/* LOOPS */
CREATE VOLATILE MULTISET TABLE Logs(
	cntr INTEGER
) ON COMMIT PRESERVE ROWS;

REPLACE PROCEDURE InsertFiveRecords()
main: BEGIN -- Label: helps us track start/end of code blocks
	DECLARE cntr INTEGER DEFAULT 0; -- cntr = 0 
	myloop: LOOP
			SET cntr = cntr + 1;
			-- Exit condition
			IF 
				cntr > 5 THEN LEAVE myloop;
			END IF;
			INSERT INTO Logs VALUES (:cntr);
	END LOOP myloop;
END main; 

CALL InsertFiveRecords();

SELECT * FROM logs;

/* CONDITION HANDLERS: Either EXIT or CONTINUE the procedure*/

REPLACE PROCEDURE Division(IN a INTEGER, IN b INTEGER, OUT res FLOAT)
main: BEGIN 
	DECLARE exit HANDLER FOR SqlState '2618' --For ANY error on DB
		BEGIN
			SET res = -1;
		END;
	SET res = a/b; -- When error is raised here, the exit handler will be called
END main;

SELECT 1/0





