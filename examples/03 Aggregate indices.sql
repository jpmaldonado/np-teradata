SELECT productprice 
FROM Product 
WHERE productname = 'Mega Camera';

/* SINGLE COLUMN JOIN INDEX */
CREATE JOIN INDEX Product_JI 
AS 
SELECT productname, productprice
FROM Product
PRIMARY INDEX(productname)

/* Example: A JOIN query*/

SELECT p.productname, c.categoryname
FROM Product p
LEFT JOIN category c
ON p.categoryid = c.categoryid
WHERE productname = 'Mega Camera';


CREATE JOIN INDEX ProductCategory_JI
AS 
SELECT p.*, c.categoryname
FROM Product p
LEFT JOIN category c
ON p.categoryid = c.categoryid
PRIMARY INDEX(productname);


/* AGGREGATE JOIN INDEX*/
/* JOIN query + some aggregation */
/* Example: Find customers with more than 3 transactions  */

WITH agg AS (
	SELECT c.customername, Count(s.tid) AS total_tx
	FROM salestransaction s
	JOIN customer c
	ON s.customerid = c.customerid
	GROUP BY customername
)
SELECT * FROM agg 
WHERE total_tx >= 3



/* Aggregate JOIN index */
CREATE JOIN INDEX CustomerSales_AJI
AS 
	SELECT c.customername, Count(s.tid) AS total_tx
	FROM salestransaction s
	JOIN customer c
	ON (s.customerid = c.customerid)
	GROUP BY c.customername
PRIMARY INDEX(customername);