/* Check it works*/
.LOGON 192.168.47.12 test,test

DATABASE tutorial;

/* Join two tables */
SELECT ProductName, CategoryName
FROM Product p
LEFT JOIN category c
ON p.CategoryId = c.CategoryId;

/* In Powershell, you need to run cat 02.sql | bteq > log.txt 
In Windows prompt you can use bteq < 02.sql > log.txt
*/
