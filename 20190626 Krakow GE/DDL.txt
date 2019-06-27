CREATE MULTISET TABLE TUTORIAL.calendar_summary ,FALLBACK ,
     NO BEFORE JOURNAL,
     NO AFTER JOURNAL,
     CHECKSUM = DEFAULT,
     DEFAULT MERGEBLOCKRATIO,
     MAP = TD_MAP1
     (
      listing_id INTEGER,
      posted_date DATE FORMAT 'YY/MM/DD',
      available CHAR(1) CHARACTER SET LATIN CASESPECIFIC,
      price FLOAT)
PRIMARY INDEX ( listing_id );


 create table listings (
 id integer not null primary key,
 listing_name varchar(200),
 host_id integer,
 host_name varchar(30),
 neighbourhood_group varchar(30),
 neighbourhood varchar(30),
 latitude float,
 longitude float,
 room_type varchar(10),                 
 price integer,
 minimum_nights integer,                 
 number_of_reviews integer,             
last_review date,
reviews_per_month float,          
calculated_host_listings_count integer, 
availability_365 integer  
 )
 