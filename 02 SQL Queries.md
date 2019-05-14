# SQL in Teradata


---
## Many faces of SQL
Formally, SQL is actually *three* languages:
- **DDL:** Data definition language.
- **DML:** Data manipulation language.
- **DCL:** Data control language.

---
# DDL

---
## Table types

Teradata supports different types of tables. 
- **Permanent Table:** This is the default table and it contains data inserted by the user and stores the data permanently. 
 
- **Volatile Table:** The data inserted into a volatile table is retained only during the user session.
	- The table and data is dropped at the end of the session. 
	- These tables are mainly used to hold the intermediate data during data transformation. 

---
## Table types (cont.)
- **Global Temporary Table:** The definition of Global Temporary table are persistent but the data in the table is deleted at the end of user session. 
 
- **Derived Table:** Derived table holds the intermediate results in a query. Their lifetime is within the query in which they are created, used and dropped.

---
## `SET` vs `MULTISET`

- Teradata classifies the tables as `SET` or `MULTISET` tables based on how the duplicate records are handled.
- A table defined as `SET` table doesn’t store the duplicate records.
- A `MULTISET` table can store duplicate records. 

---
## `CREATE TABLE`

The syntax is:

```
CREATE <SET/MULTISET> TABLE <Tablename> 
< Table Options> 
<Column Definitions> 
<Index Definitions>; 
```

---
## Syntax decoded
- `<Table Options>` specifies the physical attributes of the table such as `JOURNAL` and `FALLBACK`. 
	- `JOURNAL`: Maintain data integrity in the event of component or process failure (restore to prescribed point in time).
	- `FALLBACK`: Storing a second copy of each row on a different AMP.
 
- `<Column Definitions>` specifies the list of columns, data types and their attributes. 
 
- `<Index Definitions>` additional indexing options such as Primary Index.
	
---
# Example
```
CREATE SET TABLE EMPLOYEE,FALLBACK 
( 
      EmployeeNo INTEGER, 
      FirstName VARCHAR(30) , 
      LastName VARCHAR(30) , 
      DOB DATE FORMAT 'YYYY-MM-DD', 
      JoinedDate DATE FORMAT 'YYYY-MM-DD', 
      DepartmentNo BYTEINT 
 ) 
UNIQUE PRIMARY INDEX ( EmployeeNo );
```

---
# `SHOW TABLE`

```
 SHOW TABLE Employee; 
 *** Text of DDL statement returned. 
 *** Total elapsed time was 1 second. 
----------------------------------------------------------  
CREATE SET TABLE EMPLOYEE ,FALLBACK , 
     NO BEFORE JOURNAL, 
     NO AFTER JOURNAL, 
     CHECKSUM = DEFAULT, 
     DEFAULT MERGEBLOCKRATIO 
     ( 
      EmployeeNo INTEGER, 
      FirstName VARCHAR(30), 
      LastName VARCHAR(30), 
      DOB DATE FORMAT 'YYYY-MM-DD', 
      JoinedDate DATE FORMAT 'YYYY-MM-DD', 
      DepartmentNo BYTEINT) 
UNIQUE PRIMARY INDEX ( EmployeeNo ); 
```


---
# `ALTER TABLE`

```
ALTER TABLE <tablename> 
ADD <columnname> <column attributes> 
DROP <columnname>; 
```
## Example:

```
ALTER TABLE employee 
ADD BirthDate DATE FORMAT 'YYYY-MM-DD', 
DROP DOB; 
```

---
# `DROP TABLE`


- `DROP TABLE <tablename>;`
- `DROP TABLE IF EXISTS <tablename>;` sadly not existant.

- From Teradata 13.10, you can use BTEQ syntax in SQLA:

```
SELECT 1 FROM dbc.TablesV 
WHERe databasename = <your db> 
AND TableName = '<table>';
.if activitycount = 0 then GoTo ok
DROP TABLE <table>;
.label ok
```

---
## In general:

- `ALTER`
- `CREATE`
- `DROP`
- `MODIFY`
- `RENAME`
- `REPLACE`
- `SET ROLE`, `SET SESSION`, `SET TIME ZONE`

---
# DML

---
##  `SELECT`, `INSERT` 
```
SELECT column1, column2 FROM table
```

```
INSERT INTO table (column1, column2)
VALUES ('value1','value 2')
```

```
INSERT INTO <tablename> 
(column1, column2, column3,…) 
SELECT 
column1, column2, column3… 
FROM  
<source table>; 
```

---
## `UPDATE`, `DELETE`


```
UPDATE table SET column2 = 'value 3' WHERE column1 = 'value1'
```

```
 DELETE <databasename>
 DELETE <username>
 DELETE FROM <TABLENAME>
``` 
 
 
---
# DCL

- `GIVE`
- `GRANT`
- `GRANT LOGON`
- `REVOKE`
- `REVOKE LOGON`


---
# Set Operators
- These operators combine results from multiple `SELECT` statements.
- **Trivia:** What is the difference with `JOIN`?

**Rules**
- The number of columns from each `SELECT` statement should be same. 
- The data types from each `SELECT` must be compatible. 
- `ORDER BY` should be included only in the final `SELECT` statement.