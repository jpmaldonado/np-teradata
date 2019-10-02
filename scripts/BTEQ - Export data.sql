/* Check it works*/
.LOGON 192.168.180.128/dbc,dbc
.EXPORT FILE=out.txt

DATABASE tutorial;

/* Join two tables */
SELECT ProductName, CategoryName
FROM Product p
LEFT JOIN category c
ON p.CategoryId = c.CategoryId;

.LOGOFF

/* In Powershell, you need to run cat 02.sql | bteq > log.txt 
In Windows prompt you can use bteq < 02.sql > log.txt
*/
