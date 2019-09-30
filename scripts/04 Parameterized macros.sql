DATABASE tutorial;

CREATE MACRO TableSpace(dbname VARCHAR(30), tablename VARCHAR(30)) AS
(
	SELECT Sum(currentperm) AS usedspace FROM dbc.tablesize
	WHERE databasename = :dbname
	AND tablename = :tablename;
);

EXEC tablespace('tutorial','product');

/* The database where the view is stored needs select rights with grant option on the source table (or DB).
So the statement above will fail!
*/

GRANT SELECT ON dbc TO tutorial WITH GRANT OPTION; /* This provides the access needed*/


SELECT *
FROM DBC.TABLES
WHERE TABLEKIND = 'M'
AND databasename='tutorial';