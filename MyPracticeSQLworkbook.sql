SHOW DATABASES;
SELECT * FROM mysql.help_topic;
SELECT first_name, last_name
FROM employees
ORDER BY last_name;
SELECT * FROM mysql.help_topic;

SELECT database(); -- shows current database
USE database_name; -- command to select a database


/*
SQL Lesson Function
*/

SELECT MAX(sales) FROM albums;
-- THIS WILL technically work on nonnumeric string values due to the nature of ASCII encoding but largely does not have a ton of meaning for us
SELECT MAX(sales) FROM albums;

SELECT name FROM albums_db
WHERE MAX(SALES) 
--  GOING TO RETURN A NUMBER .SO TO SOLVE the pblm stay tuned

 SELECT name, MAX(sales) -- WHOLE BUNCH OF THINGS so its a pblm
 
 AVG()
 MIN()
 SELECT MIN(sales), MAX(sales), AVG(sales) FROM albums;
 CONCAT()
 -- Two different files can be joined. can join any strings or field names
 SELECT CONCAT('ARTIST NAME',' - ','album name');
 SELECT
 CONCAT(artist, ' - ',name) AS full_name
 FROM albums;
 
 -- the scope of full_name is within that SELECT and not outside that SELECT
 
 SELECT * FROM fruits_db.fruits;
 '1','apple','3'
'2','banana','4'
'3','cantelope','16'
'4','dragonfruit','1'



-- indexing in SQL STARTS in 1 and fro python it starts at 0
-- h: 1
-- e: 2, l:3,l:4, o:5
SELECT SUBSTR('hello robinson!',5,8);
SELECT SUBSTR('hello robinson!',-1,8);
SELECT SUBSTR('hello robinson!',-4,8); -- son
-- inclusive

SELECT SUBSTR('hello robinson!',7); -- not setting a limit so strt at 7 and give me everything o/p robinson!
SELECT SUBSTR(name, 5, 4) FROM albums;  -- try
-- replacement
SELECT REPLACE('hello robinson!','hello', 'hey');
-- o/p hey robinson!
-- case sensitive inside usually not case sensitive for most
SELECT * FROM albums;
SELECT REPLACE(name,'dark','light')
FROM albums;
-- time: how do I compare to now?
SELECT NOW(); -- gives current time
SELECT CURDATE(); -- GIVES DATE PORTION -- gives date without time
SELECT UNIX_TIMESTAMP();-- RECORDS DATE AS AN INTEGER..NO: OF SECONDS FROM THE UNITS TIME STAMP..THERE'S AN OVERHAUL OF MANY DIFF ..EVENTUALY DATEMAP WILL BREAK
-- no:of seconds since epoch in 1978
-- if subject is a datetime
SELECT UNIX_TIMESTAMP();
-- Casting to get data type
SELECT sales FROM albums;
SELECT CONCAT('now this isnt a number:', sales) FROM albums;
USE CHIPOTLE;
select * from orders;
-- turn item price into a number
-- 1st step: hget rid of the dollar sign
SELECT REPLACE(item_price, '$', '') FROM orders;
SELECT SUBSTR(item_price, 2) FROM orders; -- TELLS TO TREAT IT AS A NUMBER FIELD
-- CAST 
CAST(subject ASA data_type)
SELECT CAST('hello' AS float);
SELECT CAST('45.7' AS float);
SELECT CAST(SUBSTR(item_price, 2) AS float) * 100 FROM orders;
SELECT CAST(SUBSTR(item_price, 2) AS float) * 100 AS calculated_price,item name FROM orders;


USE farmers_market;
SELECT distinct customer_firstname
FROM customer;

SELECT  customer_firstname
FROM customer
group by customer_firstname; -- same result as above query

SELECT  *
FROM customer
group by customer_purchases;

SELECT  customer_id,COUNT(*) AS n_purchases  -- its like distinct customer ids
FROM customer_purchases
group by customer_id;


SELECT  customer_id,COUNT(*) AS n_purchases  -- its like distinct customer ids
FROM customer_purchases
group by customer_id
HAVING n_purchases> 200;