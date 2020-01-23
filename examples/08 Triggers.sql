DATABASE tutorialdb;
/* Example: Data import in a table.
- Table with (employeeid, employeename, salary)
- Trigger: Detect when a new employee is added, and put him on a separate log table
*/

/* Table on which we will be detecting changes*/
CREATE MULTISET TABLE tutorialdb.employee2 (
	empid INTEGER, 
	empname CHAR(30),
	salary INTEGER	
);

INSERT INTO employee2 VALUES (101, 'Pablo', 100);

/* Table to log changes*/
CREATE MULTISET TABLE employee_log (
	empid INTEGER, 
	empname CHAR(30),
	salary INTEGER,
	userid CHAR(30) DEFAULT USER,
	loaddt DATE DEFAULT DATE,
	loadtm INTEGER DEFAULT TIME
);

/* Create Trigger*/
REPLACE TRIGGER DetectNewEmployee
AFTER INSERT ON employee2
REFERENCING NEW_TABLE AS employeenew --alias for diff table after INSERT
FOR EACH STATEMENT (
	INSERT INTO employee_log(empid, empname, salary)
		SELECT empid, empname, salary FROM employeenew;
)

SELECT * FROM employee_log;
SELECT * FROM employee2;

/* Create an event*/
INSERT INTO employee2(empid, empname, salary) VALUES(13,'Agnieszka', 5000);

SELECT * FROM dbc.dbqlogtbl

