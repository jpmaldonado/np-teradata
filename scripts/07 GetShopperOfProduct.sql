/*
1. Filter results from a query into another table. 
Example: For a given productname, I want to copy the customers 
that purchased it into a table.
*/
CREATE TABLE tutorial.productlog (
	productname VARCHAR(100), 
	customername VARCHAR(100)
);

REPLACE PROCEDURE GetShopperOfProduct(IN my_product VARCHAR(100))
BEGIN
	INSERT INTO tutorial.productlog
		SELECT p.productname, c.customername
		FROM tutorial.Product p
		JOIN tutorial.soldvia s
		ON p.productid=s.productid AND p.productname=:my_product
		JOIN tutorial.salestransaction st
		ON st.tid = s.tid
		JOIN tutorial.customer c
		ON st.customerid = c.customerid;
END;

CALL GetShopperOfProduct('Tiny Tent')
SELECT * FROM tutorial.productlog


