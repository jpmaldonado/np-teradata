# Performance Tuning
---


PERFORMANCE TUNING
Performance Tuning

204. Highlight the need for Performance Tuning.

Performance tuning in Teradata is basically done to identify all the bottlenecks and then resolve them.

205. Comment whether bottleneck is an error or not.

Technically, bottleneck is not a form of error, but it certainly causes a certain amount of delay in the system.

 206.How can bottlenecks be identified?

There are basically four ways of identifying a bottleneck. These are: –

    Teradata Visual Explain
    Explain Request Modifier
    Teradata Manager
    Performance Monitor

207.What are the Performance improvement techniques available in Teradata?

Performance tuning and optimization of a query involves

    First of all use EXPLAIN plan to see how the query is performing.
    Keywords like Product joins, low confidence are measures of poor performance.
    Make Sure, STATS are collected on the columns used in WHERE Clause and JOIN columns.
    If STATS are collected , explain plan will show HIGH CONFIDENCE This tells the optimizer about the number of rows in that table which will help the optimizer to choose the redistribution/duplication of smaller tables.
    Check the joining columns & WHERE Clause whether PI, SI or PPI are used.
    Check whether proper alias names are used in the joining conditions.
    Split the queries into smaller subsets in case of poor performance.
    collecting statistics on join columns
    avoiding cross product join
    selection of appropriate primary index (to avoid skewness in storage)
    and using secondary index.
    Avoiding NUSI is advisable
     Check for the recommendations of stats to be collected for the columns.
     Try to avoid casting in join conditions
     Use secondary index appropriately.
    Use join index if necessary
    choose the Primary Index to avoid skew,
    avoid using CAST, SUBSTR, CASE, POSITION, as these functions consumes a lot of resource.
    If two huge tables are joined almost regularly, create Joined Index.
    Avoid Redistribution when possible
    Use sub-selects instead of big “IN” lists
    Use derived tables
    Use GROUP BY instead of DISTINCT ( GROUP BY sorts the data locally on the VPROC. DISTINCT sorts the data after it is redistributed)
    Use Compression on large tables

Optimization of queries improves performance of TD and helps the PE to generate the most efficient execution plan.To Optimize a query

208.Below Steps are useful for performance tuning

    A) Explain the EXPLAIN: Check for EXPLAIN plan to see how exactly Teradata will be executing the query. Try to understand basic keywords in Explain Plan like confidence level, join strategy used, re-distribution happening or not.
    B) Collect STATS: The stats of the columns used join conditions should updated. Secondary Indexes without proper STATS can be of little or no help. Check for STATS status of the table.
    C) Use Proper PI: If the Primary index is not properly defined in any one or all of the tables in the query. Check if the PI of target table loaded is unique.
    D) Use PPI: If there is Partition Primary Index created on a table, try to use it. If you are not using it in filter condition, it will degrade the performance.
    E) No FUNCTIONS in Conditions: Try to avoid using function in join conditions. Ex Applying COALESCE or TRIM etc causes high CPU consumption.
    F) Use PPI: If Partition Primary Index is defined in tables try to use it. If you are not using it in filter condition, it will degrade the performance.
    G) Same column DATA TYPES: Define same data type for the joining columns.
    H) Avoid IN clause in filter conditions: When there can be huge number of values in where conditions, better option can be to insert such values in a volatile table and use volatile table with INNER JOIN in the main query.
    I) Use Same PI in Source & Target: PI columns also can help in saving the data into disk .If the Source and Target have the same PI, data dump can happen very efficiently form source to target.
    J) Collect STATS on VOLATILE table: Collect stats on volatile tables where required can save AMPCPU. Remove stats if already present where it is not getting used. If the volatile table contains UNIQUE PI, then go for sample stats rather than full stats.
    K) DROPPING volatile tables explicitly: Once volatile tables is no more required you can drop those. Donít wait for complete procedure to be over. This will free some spool space immediately and could prove to be very helpful in avoiding No More Spool Space error.
    L) NO LOG for volatile tables: Create volatile tables with NO LOG option.
    M) Check DBQL Stats: Keep your performance stats accessible. Target the most AMPCPU consuming query first.
    N) UPDATE clause: Do not write UPDATE clause with just SET condition and no WHERE condition. Even if the Target/Source has just one row, add WHERE clause for PI column.
    O) DELETE & INSERT: Sometimes replacing UPDATE with DELETE & INSERT can save good number of AMPCPU. Check if this holds good for your query.
    P) Query SPLITS: Split queries into several smaller queries logically and use volatile tables with proper PI.
    Q) Try MSR: If same target table is loaded multiple times, try MSR for several sections. This will speed the final MERGE step into target table and you may see good CPU gain.
    R) Try OLAP Functions: Check if replacing co-related sub query with OLAP function may result in AMPCPU saving.
    S) Avoid DUPLICATE data: If the join columns in the tables involved in the query have duplicates. Use Distinct or Group by, load into a volatile table, collect stats and use the volatile table.
    T) Use Proper JOINS: If joins used, donít use right outer, left or full joins where inner joins is sufficient.
    U) User proper ALIAS: Check the aliases in the joins. Small mistake could lead to a product join.
    V) Avoid CAST: Avoid unnecessary casting for DATE columns. Once defined as DATE, you can compare date columns against each other even when they are in different format. Internally, DATE is stored as INTEGER. CAST is required mainly when you have to compare VARCHAR value as DATE.
    W) Avoid UDF: Most of the functions are available in Teradata for data manipulations. So avoid User Defined Functions
    X) Avoid FULL TABLE SCAN: Try to avoid FTS scenarios like SI should be defined on the columns which are used as part of joins or Alternate access path. Collect stats on SI columns else there are chances where optimizer might go for FTS even when SI is defined on that particular column
    Y) Avoid using IN/NOT IN: For large list of values, avoid using IN /NOT IN in SQLs. Write large list values to a temporary table and use this table in the query
    Z) Use CONSTANTS: Use constants to specify index column contents whenever possible, instead of specifying the constant once, and joining the tables. This may provide a small savings on performance.

Sql Tuning:

    Use Top N option and column names to see sample data in a table. If there is a just select and  *  then the optimizer has to replace * with all columns from that table Example: Lock Row For Access Select Top 5 Empno, Ename From Employee;
    Use “Create AS Table” if there is a need to create a table from existing  table. It operates on an efficient block-by-block basis that bypasses journaling. You can create only structure or structure & data or structure,data and stats. Example: CREATE TABLE  NEW_Table AS OLD_TABLE WITH DATA and STAT
    Use Insert/Select if there is a need to copy data from one table to another empty table. INSERT/SELECT operates on an efficient block-by-block basis that bypasses journaling. Insert/Select will handle conversions also. Example: INSERT into Summary_Table SELECT store, region, sum (sales), count (sale_item) FROM Region_1 GROUP BY 1,2
    Use Nowait option if you dont want your request to wait in the queue. Example: Locking Emp For Read Nowait SELECT * FROM Emp
    Nesting view could add a substantial time to parser.Try to reduce nesting views creation.
    If values are nearly unique values then Distinct clause may outperform Group By. When there are many duplicate value then Group By performs better than Distinct.
     Make sure that the join columns have always same data type. Otherwise one of the table rows would have to undergo translation and does full table scan even though there are stats on the join column.
     If you are doing a lot of deletes on rows from a table, consider the use of MultiLoad instead of BTEQ / SQL Assistant to do the deletes. MultiLoad completely avoids use of the TJ and is restartable.Another approach is, do Insert/Select into an empty table then drop the original table and then rename the new table to original table.
     Check the data distribution of primary index. Example: Select HashAmp (HashBucket (HashRow (Last_Name, Fisrt_name))) , Count (*) From Emp Group By 1 Order By 2 Desc
     If possible try to avoid using any functions on join columns or on where columns. For example if substr or coalesce.. Etc. functions used on where column then the optimizer is not going use stats even though if there are stats on the column.
    If there is sql with an outer join then make sure that the inner table filter condition should be present in on condition then no extra data is loaded into spool file from inner table for further processing. Filter condition for outer table should be present in where condition.

Example: Select A.Empno , A.Ename , B.Dname From Emp A left outer join Dept B On (A.Deptno = B.Deptno And B.Deptno=10 ) Here Emp table called as Outer Table and Dept  table called as Inner table.

     You can re-write correlated or minus queries with left outer join. Correlated query has to be executed for every row returned by the outer query. Correlated queries are expensive for the optimizer.

Example:  Get all departments that have no employees.

Select A.Deptno , A.Dname , A.Location From Dept A Where Not Exists (Select 1 ;            From Emp B & nbsp;           Where B.DeptNo = A.Deptno )

Above query can be re-written like below and gives better performance than above.

Select A.Deptno , A.Dname , A.Location From Dept A Left Outer Join Emp B On (A.DeptNo =B.Deptno ) Where B.Deptno Is Null

     Avoid use of large list of values in IN/NOT IN clauses. Store them in some temporary  table and use that table in the query.
    If intermediate tables are used for processing then make sure that it has same PI of source and target tables. Collect the stats on intermediate table NUPI after loading.
      If like used in a where clause, it is better to try to use one or more leading character in the clause, if at all possible otherwise the optimizer is going to full table scan even though if there is a index on this column.
      Use Not Null for columns, which are declared as Nullable in table definition so the tables skew can be avoided in joins.
     Always check the plan and run the below command to see if optimizer has recommended any stats for better execution. Collect the stats only if the optimizer is recommending high confidence.Avoid the stats if the columns have low cardinality and multi column stats (more than three).Diagnostic help stats on for the session
    Create join index when the table is consistently joined with other tables other than primary index and retrieval benefits are greater than setting up and maintenance.

