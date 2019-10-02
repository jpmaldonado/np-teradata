REPLACE PROCEDURE FavoriteProducts(IN variable VARCHAR(100))
BEGIN
   BEGIN
      -- simply try dropping the table and ignore the "table doesn't exist error"
      DECLARE exit HANDLER FOR SqlException
      BEGIN  -- 3807 = table doesn't exist
         IF SqlCode <> 3807 THEN RESIGNAL; END IF;
      END;

      DROP TABLE tutorial.someprods;
   END;

   CREATE TABLE tutorial.someprods AS(

   SELECT
   p.productname, Sum(s.noofitems) AS total
   FROM tutorial.Product p
   JOIN tutorial.soldvia s
   ON p.productid = s.productid
   WHERE p.productname = :variable
   GROUP BY 1 ) WITH DATA
   PRIMARY INDEX (productname);
END;
/*Running the code above gives you a warning that the table does not exist. Ignore it :) */
/* Calling our stored procedure*/

-- 'Simple Sandal', 'Cosy Sock'
CALL FavoriteProducts('Tiny Tent')

SELECT * FROM tutorial.someprods;