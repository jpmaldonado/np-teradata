
/* First we need to create the table for our data*/

CREATE TABLE tutorial.testdata (
	customerid INTEGER, 
	country VARCHAR(2),
	totalspent FLOAT -- correct type for decimal numbers
)
PRIMARY INDEX(customerid);

/*1. Enter Import Mode in File | Import*/
/*2. Run query below and browse to your file*/
INSERT INTO tutorial.testdata VALUES (?,?,?);
/*3. Exit Import Mode again */
/*4. Finally, check that the data is indeed there.*/
SELECT * FROM tutorial.testdata;
