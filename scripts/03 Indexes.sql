/*	FIRST EXAMPLE: PPI VS NON-PPI*/

CREATE volatile TABLE salary_non_ppi
(
id INT,
Sal INT,
dob DATE,
bonus INT
) primary index( id)
on commit preserve rows;


INSERT into salary_non_ppi VALUES (1001,2500,'2017-09-01',890);
INSERT into salary_non_ppi VALUES (1002,5500,'2017-09-10',890);
INSERT into salary_non_ppi VALUES (1003,500,'2017-09-02',890);
INSERT into salary_non_ppi VALUES (1004,54500,'2017-09-05',890);
INSERT into salary_non_ppi VALUES (1005,900,'2017-09-23',890);
INSERT into salary_non_ppi VALUES (1006,8900,'2017-08-03',890);
INSERT into salary_non_ppi VALUES (1007,8200,'2017-08-21',890);
INSERT into salary_non_ppi VALUES (1008,6200,'2017-08-06',890);
INSERT into salary_non_ppi VALUES (1009,2300,'2017-08-12',890);
INSERT into salary_non_ppi VALUES (1010,9200,'2017-08-15',890); 

SELECT * from salary_non_ppi where dob <= '2017-09-01';

/*Partition table*/

CREATE volatile TABLE salary_ppi
(
id INT,
Sal int,
dob date,
bonus int
) primary index( id)
PARTITION BY RANGE_N (dob BETWEEN DATE '2017-01-01'
AND DATE '2017-12-01' EACH INTERVAL '1' DAY)
on commit preserve rows;

INSERT into salary_ppi VALUES (1001,2500,'2017-09-01',890);
INSERT into salary_ppi VALUES (1002,5500,'2017-09-10',890);
INSERT into salary_ppi VALUES (1003,500,'2017-09-02',890);
INSERT into salary_ppi VALUES (1004,54500,'2017-09-05',890);
INSERT into salary_ppi VALUES (1005,900,'2017-09-23',890);
INSERT into salary_ppi VALUES (1006,8900,'2017-08-03',890);
INSERT into salary_ppi VALUES (1007,8200,'2017-08-21',890);
INSERT into salary_ppi VALUES (1008,6200,'2017-08-06',890);
INSERT into salary_ppi VALUES (1009,2300,'2017-08-12',890);
INSERT into salary_ppi VALUES (1010,9200,'2017-08-15',890);

SELECT * from salary_ppi where dob <= '2017-09-01';