CREATE MULTISET TABLE tutorial.employee
( empid INTEGER,
empname CHAR(30),
salary INTEGER);

CREATE MULTISET TABLE tutorial.employee_log
(
empid INTEGER,
empname CHAR(30),
salary INTEGER,
userid CHAR(30) DEFAULT USER,
loaddt DATE DEFAULT DATE,
loadtm  INTEGER DEFAULT TIME);


CREATE TRIGGER DetectNewEmployee
AFTER INSERT ON tutorial.employee
REFERENCING NEW_TABLE AS employeenew
/*With insert trigger event we cannot use OLD_TABLE AS clause*/
FOR EACH STATEMENT
( INSERT INTO tutorial.employee_log(empid,empname,salary) 
  SELECT empid,empname,salary FROM employeenew;)

/* Create an event*/
INSERT INTO tutorial.employee(empid,empname,salary)  VALUES (123,'Ludwika Paleta',32000);

/*Check what happened*/
SELECT * FROM tutorial.employee_log
