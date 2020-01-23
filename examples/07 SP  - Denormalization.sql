/* EXAMPLE: Generate a table with Productname and Categoryname, for a given category */
DATABASE tutorialdb;
DROP TABLE test;
CREATE VOLATILE TABLE test ( 
	prodname CHAR(30),
	categoryname CHAR(30)
) ON COMMIT PRESERVE ROWS;

REPLACE PROCEDURE ProdCategory(IN cat CHAR(30))
main: BEGIN
	-- Declarations
	DECLARE my_prod VARCHAR(30); 
	DECLARE my_cat VARCHAR(30); -- placeholders for fetch and insert results
	
	DECLARE cur CURSOR FOR
		SELECT p.productname, c.categoryname
		FROM Product p
		JOIN category c
		ON c.categoryid = p.categoryid;
	
	-- Condition handlers (Not now)
	-- Main logic
	OPEN cur;
	
	copy: WHILE (SqlState = 0)
		DO
			FETCH cur INTO my_prod, my_cat;
			CASE WHEN my_cat = cat THEN-- check that my_cat matches the input parameter
				INSERT INTO test VALUES (:my_prod, :my_cat);
			ELSE 
				BEGIN  --It must be there to give an altertative to CASE
				END;
			END CASE;
	END while copy;
	--CLOSE cur;	
END main;

CALL ProdCategory('Camping');
SELECT * FROM test;