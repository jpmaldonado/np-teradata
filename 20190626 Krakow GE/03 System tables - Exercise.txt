/* Find number of tables in database */
SELECT  COUNT(*) AS Tables
FROM    DBC.TablesV
WHERE   TableKind = 'T'
AND     DatabaseName = 'Sales';

/*Find tables with specific column name */
SELECT  TablesV.DatabaseName,
        TablesV.TableName
FROM    DBC.TablesV
INNER JOIN DBC.ColumnsV ON TablesV.DatabaseName = ColumnsV.DatabaseName
        AND TablesV.TableName = ColumnsV.TableName
WHERE   ColumnsV.ColumnName = 'code'
AND     TablesV.TableKind = 'T'
ORDER BY    TablesV.DatabaseName,
            TablesV.TableName;


/*List all columns in specific table */
SELECT  ColumnName
FROM    DBC.ColumnsV
WHERE   DatabaseName = 'Sales'
AND     TableName = 'Product'
ORDER BY    ColumnID;


/* Find a table by the name in Teradata database */
SELECT  DatabaseName,
        TableName
FROM    DBC.TablesV
WHERE   TableKind = 'T'
AND     TableName = 'Countries'
ORDER BY    DatabaseName;



/* Find tables with specific word in name */
SELECT  DatabaseName,
        TableName
FROM    DBC.TablesV
WHERE   TableKind = 'T'
AND     TableName LIKE '%Customer%'
ORDER BY    TableName;
