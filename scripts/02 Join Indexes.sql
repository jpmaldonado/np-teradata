DATABASE tutorial;
SELECT TOP 10 * FROM Product

/* SINGLE-COLUMN JOIN INDEX */
SELECT productprice FROM Product WHERE productname = 'Mega Camera';

/* Create Index */
CREATE JOIN INDEX Product_JI
AS 
SELECT productname, productprice
FROM Product
PRIMARY INDEX(productname)

/*MULTI-TABLE JOIN INDEX*/
SELECT p.Productname, c.categoryname
FROM Product p
LEFT JOIN category c
ON p.categoryid = c.categoryid
WHERE productname = 'Mega Camera'
;

/* Create join index */ 
CREATE JOIN INDEX ProductCategory_JI
AS 
SELECT p.*, c.categoryname
FROM Product p
LEFT JOIN category c
ON p.categoryid = c.categoryid
PRIMARY INDEX(productname)
;


/*AGGREGATE JOIN INDEX*/ 
/* WHERE clause + JOIN + Aggregation*/
/* Example: Find customers (by name) that have more than three transactions*/

SELECT c.customername, Count(s.tid) AS totaltransactions
FROM salestransaction s 
LEFT JOIN customer c
ON s.customerid = c.customerid
GROUP BY c.customername
WHERE c.customername = 'Tina'

/* AGGREGATE JOIN INDEX*/

CREATE JOIN INDEX CustomerSales_AJI2
AS 
WITH agg AS (
	SELECT c.customername, Count(s.tid) AS totaltransactions
	FROM salestransaction s 
	LEFT JOIN customer c
	ON (s.customerid = c.customerid)
	GROUP BY c.customername
	)
SELECT * FROM agg	
PRIMARY INDEX(c.customername);