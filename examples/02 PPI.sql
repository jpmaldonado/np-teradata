/* EXAMPLE: Partitioned Primary Index*/ 

CREATE VOLATILE TABLE salary_non_ppi
(
id INT, 
salary INT,
start_date DATE
) PRIMARY INDEX(id)
ON COMMIT PRESERVE ROWS; /* To store some values*/

INSERT INTO salary_non_ppi VALUES (101, 2000, '2016-01-21');
INSERT INTO salary_non_ppi VALUES (102, 2000, '2016-11-21');
INSERT INTO salary_non_ppi VALUES (103, 2000, '2017-01-21');
INSERT INTO salary_non_ppi VALUES (101, 2000, '2019-01-21');

SELECT * FROM salary_non_ppi WHERE start_date <= '2017-12-31'

CREATE VOLATILE TABLE salary_ppi
(
id INT, 
salary INT,
start_date DATE
) PRIMARY INDEX(id)
PARTITION BY Range_N (start_date BETWEEN DATE '2016-01-01'
AND DATE '2020-01-01' EACH INTERVAL '1' DAY)
ON COMMIT PRESERVE ROWS; /* To store some values*/

INSERT INTO salary_ppi VALUES (101, 2000, '2016-01-21');
INSERT INTO salary_ppi VALUES (102, 2000, '2016-11-21');
INSERT INTO salary_ppi VALUES (103, 2000, '2017-01-21');
INSERT INTO salary_ppi VALUES (101, 2000, '2019-01-21');

SELECT * FROM salary_ppi WHERE start_date <= '2017-12-31'



CREATE VOLATILE TABLE salary_ppi2
(
id INT, 
salary INT,
start_date DATE
) PRIMARY INDEX(id)
PARTITION BY Case_N (id IN ('101','102'))
ON COMMIT PRESERVE ROWS; /* To store some values*/
