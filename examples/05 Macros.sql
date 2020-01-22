/* MACROS */

/* 
- Repetitive queries (get parameters).
- Execution plan gets cached in the PE, so that the query is run the same way every time.	
- INSERT, DELETE, UPDATE, SELECT
- Preferred to stored procedures (SP) because they leverage parallelization
- No IF/ELSE, FOR/WHILE (unlike SP).
*/

/* EXAMPLE: Get Manager from employee table */
CREATE MACRO GetDataByJobTitle(job VARCHAR(20)) AS (
	SELECT * 
	FROM employee
	WHERE job_title = :job;
);

EXEC GetDataByJobTitle('MANAGER');

DATABASE tutorialdb;

REPLACE MACRO TableSize(tablename VARCHAR(30)) AS (
	SELECT Max(currentperm) AS total_max_space 
	FROM dbc.tablesize
	WHERE tablename = :tablename;
);

/* 
NOTE: The user that runs the macro needs permission for objects
inside of the macro.
*/
GRANT SELECT ON dbc TO tutorialdb WITH GRANT OPTION;
EXEC TableSize('soldvia')

REPLACE MACRO NewMacro AS (
	SELECT * FROM tutorialdb.Product;
);

EXEC NewMacro;

/* Check macro date creation*/
SELECT * 
FROM dbc.tables 
WHERE tablekind='M' AND databasename = 'tutorialdb';

/* More than 1 parameter */
REPLACE MACRO TableSize(dbname VARCHAR(30), tablename VARCHAR(30)) AS (
	SELECT Max(currentperm) AS total_max_space 
	FROM dbc.tablesize
	WHERE databasename = :dbname AND tablename = :tablename;
);

EXEC tablesize('tutorialdb', 'product')

SHOW MACRO tablesize

DROP MACRO newmacro

