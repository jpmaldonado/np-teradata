.LOGON 192.168.180.128/dbc,dbc
.IMPORT VARTEXT ',' FILE=test.txt

CREATE TABLE tutorial.customerorigin (
	custname varchar(100),
	country varchar(50)
);


.REPEAT *
USING (IN_CustName varchar(100), IN_CustCountry varchar(50)) 
INSERT INTO tutorial.customerorigin VALUES (:IN_CustName, :IN_CustCountry);
	
.LOGOFF
