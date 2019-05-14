<!-- $theme: gaia -->

# Writing SQL queries
---

## Objects in a database
There are nine types of objects which may be found in a Teradata database/user.
- **Tables**: rows and columns of data.
- **Views**: predefined subsets of existing tables.
- **Macros**: predefined, stored SQL statements.
- **Triggers**: SQL statements associated with a table.
- **Stored Procedures**: program stored within Teradata.
- **User-Defined Function (UDF)**: function (C program) to provide additional SQL functionality
- **Join and Hash Indexes**: separate index structures stored as objects within a database Permanent Journals – table used to store before and/or after images for recovery.

---
## Create a database
Attributes that may be specified for a database:
- **Perm Space** : max amount of space available for tables, stored procedures, and UDFs.
- **Spool Space**: max amount of work space available for requests.
- **Temp Space**: max amount of temporary table space.

**Example:**
`CREATE DATABASE mydb FROM dbc AS PERMANENT=20e9, SPOOL=500e6;`


---
## Users
- A Teradata user is a database with an assigned password.
- A Teradata user may logon to Teradata and access objects within itself or other databases for which it has access rights.
- Perm space, spool and temp space may be specified for a user.

---
## Getting data in and out
- `BTEQ`: It supports `SELECT`, `INSERT`, `UPDATE`, and `DELETE`. `BTEQ` also supports
- `IMPORT`/`EXPORT` protocols.
- Utilities: `FastLoad`, `Multiload`, and `TPump` transfer data from the host to Teradata.
- Export: `FastExport` performs high volume SELECTs to export data from Teradata to the host.
- In Teradata Studio, GUI wizards.

---
# Demo: Impor

