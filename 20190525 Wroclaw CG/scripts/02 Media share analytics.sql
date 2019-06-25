CREATE VOLATILE TABLE media(id INTEGER, url VARCHAR(100),  shares INTEGER) PRIMARY INDEX(id)
ON COMMIT PRESERVE ROWS;

INSERT INTO media(d, url,shares) VALUES(?, ?, ?); /* Set up correctly the import options in Tools | Options! */ 

SELECT TOP 10 *  FROM media; /* Don't forget to "turn down" the iport mode */

SELECT TOP 10 Substr(url, 21,10) AS article_date FROM media /* extract date */

SELECT TOP 10 Substr(url, 31, 60) FROM media /* extract article title */ 

/* Fancier parsing */
WITH tmp AS (
SELECT Substr(url, 21,10) AS article_date FROM media
)
SELECT Extract( MONTH From Cast(article_date AS DATE)) FROM tmp