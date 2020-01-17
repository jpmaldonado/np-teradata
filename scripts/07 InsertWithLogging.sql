GRANT CREATE PROCEDURE ON TUTORIAL TO DBC;

/* Create error logging table*/
CREATE TABLE tutorial.runtime_error (
	   		session_nr INTEGER,
	        procedure_name VARCHAR(1000),
	        proc_step_txt VARCHAR(50),
	        error_cd INTEGER
	   );


REPLACE PROCEDURE tutorial.InsertWithLogging(OUT return_code VARCHAR(20))
BEGIN 
  /* Variable declaration */
   DECLARE lv_proc_step VARCHAR(1000);
   DECLARE lv_proc_name VARCHAR(50) DEFAULT 'sample_procedure';
   
      /* Continue Handler for Table does not exist */
   DECLARE CONTINUE HANDLER FOR SqlState '42000'  
   BEGIN 
     /* Even if Drop table fails,continue to the next step*/
   END; 
   
  /* Exit Handler for any SQL exception */
   DECLARE EXIT HANDLER FOR SqlException
   BEGIN
        ROLLBACK;
        SET return_code = 'ERROR';
        INSERT INTO tutorial.runtime_error
        ( session_nr,
          procedure_name,
          proc_step_txt,
          error_cd
        )
        VALUES
        (
          SESSION,
          lv_proc_name,
          lv_proc_step,
          SqlCode
        );

   END;

 SET return_code='Running';
   SET lv_proc_step='Dropping table';
   DROP TABLE tutorial.department;

   SET lv_proc_step='Creating table';
   CREATE MULTISET TABLE tutorial.department
   (
     dept_no INTEGER,
     department_name VARCHAR(30),
     loc_name  VARCHAR(30)
   )
   PRIMARY INDEX(dept_no);


   SET lv_proc_step='Inserting data into table';
   INSERT INTO tutorial.department VALUES(100, 'Accounts', 'Krakow');
   INSERT INTO tutorial.department VALUES(200, 'R & D', 'Warsaw');
   INSERT INTO tutorial.department VALUES(300, 'Sales', 'New York');
   INSERT INTO tutorial.department VALUES(400, 'IT', 'Bucarest');
 SET return_code='Success';

END; 


/* Calling and testing procedure */
CALL InsertWithLogging(msg)
SELECT * FROM tutorial.department

SELECT * FROM tutorial.runtime_error