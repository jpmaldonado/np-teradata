# Data Protection
---

---
## In this lecture
- Data protection in Teradata.
- User management.

---
## Transient Journal
- Teradata uses transient journal to protect data from transaction failures.
- Whenever any transactions are run, transient journal keeps a copy of the before images of the affected rows until the transaction is successful or rolled back successfully. 
- Then, the before images are discarded. 
- Transient journal is kept in each AMPs. 
- It is an automatic process and cannot be disabled.

---
## Fallback

- Fallback protects the table data by storing the second copy of rows of a table on another AMP called as Fallback AMP. 
- If one AMP fails, then the fallback rows are accessed. 
- With this, even if one AMP fails, data is still available through fallback AMP. 
- Fallback option can be used at table creation or after table creation. 
- Fallback ensures that the second copy of the rows of the table is always stored in another AMP to protect the data from AMP failure.
- However, fallback occupies twice the storage and I/O for Insert/Delete/Update.

---
## Down AMP Recovery Journal
- The Down AMP recovery journal is activated when the AMP fails and the table is fallback protected.
- This journal keeps track of all the changes to the data of the failed AMP. The journal is activated on the remaining AMPs in the cluster. 
- It is an automatic process and cannot be disabled. 
- Once the failed AMP is live then the data from the Down AMP recovery journal is synchronized with the AMP. 
- Once this is done, the journal is discarded.


---
## Cliques
- **Clique** is a mechanism used by Teradata to protect data from Node failures. - A clique is nothing but a set of Teradata nodes that share a common set of Disk Arrays. 
- When a node fails, then the vprocs from the failed node will migrate to other nodes in the clique and continue to access their disk arrays.

---
## Hot Standby Node
- **Hot Standby Node** is a node that does not participate in the production environment.
- If a node fails then the vprocs from the failed nodes will migrate to the hot standby node. 
- Once the failed node is recovered it becomes the hot standby node.
- Hot Standby nodes are used to maintain the performance in case of node failures.

---
## RAID
- Redundant Array of Independent Disks (RAID) is a mechanism used to protect data from Disk Failures.
- Disk Array consists of a set of disks which are grouped as a logical unit. - This unit may look like a single unit to the user but they may be spread across several disks.
- RAID 1 is commonly used in Teradata. In RAID 1, each disk is associated with a mirror disk.
- Any changes to the data in primary disk is reflected in mirror copy also. - If the primary disk fails, then the data from mirror disk can be accessed.



---
# User Management

---
## Users
- A user is created using `CREATE USER` command.
- In Teradata, a user is also similar to a database.
- They both can be assigned space and contain database objects except that the user is assigned a password.

```
CREATE USER username
AS
[PERMANENT|PERM] = n BYTES
PASSWORD=password
TEMPORARY=n BYTES
SPOOL=n BYTES;
```
- For creating a user, the values for user name, Permanent space and Password are mandatory. Other fields are optional.

## User Creation

```
CREATE USER tutorial_user AS 
   PASSWORD=tutorial_user 
   PERM = 100000000   -- 100 MB
   SPOOL= 10000000    -- 10 MB
   ; 
```

---
## Database Creation

```
CREATE DATABASE tutorial_db
   FROM DBC  
   AS
   PERM = 1000000000  -- 1000 MB
;
```

---
## Grant
- Grant on Database: Providing complete access(creation/dropping/modifying objects) on tutorial_db to tutorial_user.

`GRANT ALL ON tutorial_db TO tutorial_user;`


- Access to DBC Tables: Providing select access to tutorial_user on DBC data dictionary tables.

`GRANT SELECT ON dbc TO tutorial_user;`

---
## Grant Privileges
- `GRANT` command is used to assign one or more privileges on the database objects to the user or database. 

- `GRANT privileges ON objectname TO username;` Privileges can be `ALL`,`INSERT`, `SELECT`, `UPDATE`, `REFERENCES`.


---
## Revoke Privileges
- `REVOKE` command removes the privileges from the users or databases.
- Syntax: `REVOKE [ALL|privileges] ON objectname FROM username;`
- **Example**
`REVOKE INSERT,SELECT ON Employee FROM TD01;`



---
## MODIFY
- Change Password: 
`MODIFY USER tutorial_user AS PASSWORD= "NewPassword";`
- Default Database:
`MODIFY USER tutorial_user AS DEFAULT DATABASE=tutorial_db;`
- Access to specific object creation:
	- Procedure Creation Access:
`GRANT CREATE PROCEDURE ON tutorial_db TO tutorial_user;`
	- Function Creation Access:
```
GRANT CREATE FUNCTION ON tutorial_db to tutorial_user;
GRANT DROP FUNCTION ON tutorial_db to tutorial_user;
GRANT EXECUTE FUNCTION ON tutorial_db to tutorial_user;
```

---
## Accounts
- While creating a new user, the user may be assigned to an account.
- `ACCOUNT` option in `CREATE USER` is used to assign the account.
- A user may be assigned to multiple accounts.
```
CREATE USER username
PERM=n BYTES
PASSWORD=password
ACCOUNT=accountid
```
---
## Specify Account Id

- The user can specify the account id while logging into Teradata system or after being logged into the system using the `SET SESSION` command.

```
.LOGON username, passowrd,accountid
OR
SET SESSION ACCOUNT=accountid
```



---
# Data dictionary

---
## Teradata Data Dictionary
- Teradata data dictionary tables are metadata tables present in the DBC database. 
- It can be used for variety of things such as checking table size, query bottleneck and database size etc. 
- https://dbmstutorials.com/teradata/teradata_data_dictionary_queries.html
