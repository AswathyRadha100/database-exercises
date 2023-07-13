##############################################################################################################################
#  Temporary Tables  Exercises                                                                                               #
#  Goal:In this lesson we will learn about temporary tables.                                                                 #    
##############################################################################################################################

/*
Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with 
that department. Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
Update the table so that the full_name column contains the correct data.
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?
*/

CREATE TEMPORARY TABLE new_fake_table; -- Can't create, as access denied .The query was trying to write a new table to a database that has only read access.
SELECT DATABASE();
-- employees
SHOW DATABASES;
 USE robinson_2287; -- sets the 'robinson_2287' database as the current active database for executing subsequent queries. 
 SELECT DATABASE();
 -- 'robinson_2287'
SHOW TABLES; -- No tables exists within 'robinson_2287' database

#########
#+++++++++++++


    
USE robinson_2287;
CREATE TEMPORARY TABLE employees_with_departments (
        first_name VARCHAR(25) NOT NULL,
        last_name VARCHAR(25) NOT NULL,
        dept_name VARCHAR(25) NOT NULL,
        full_name VARCHAR(25) NOT NULL);
        
  -- a table named  employees_with_departments is created in  robinson_2287 db
  
DESCRIBE employees_with_departments;

-- DROP is a structural change
DROP TABLE IF EXISTS employees_with_departments;

DESCRIBE employees_with_departments;

CREATE TEMPORARY TABLE employees_with_departments (
        first_name VARCHAR(25) NOT NULL,
        last_name VARCHAR(25) NOT NULL,
        dept_name VARCHAR(25) NOT NULL,
        full_name VARCHAR(50) NOT NULL);
        
        DESCRIBE employees_with_departments;
        
        -- Update the table so that the full_name column contains the correct data.
        -- Syntax
        /*
          INSERT INTO my_nums(n, name) 
          VALUES (1, 'class'), (2, 'robinson');
         */ 
         
  INSERT INTO employees_with_departments 
  VALUES ('Rob', 'Davidson', 'Development','Rob Davidson' ),('Maya', 'Das', 'Sales','Maya Das' ),('Albert', 'Robertson', 'Human Resources','Albert Robertson' );
  
  SELECT * FROM employees_with_departments;
  /*
  Output:-
  
'Rob','Davidson','Development','Rob Davidson'
'Maya','Das','Sales','Maya Das'
'Albert','Robertson','Human Resources','Albert Robertson'

  
  */
  
  -- Remove the first_name and last_name columns from the table.
  -- Syntax
  /*
  ALTER TABLE my_nums
DROP name;
  */
  
  ALTER TABLE employees_with_departments
  DROP first_name;
  
   DESCRIBE employees_with_departments;
   -- first name column deleted from the table.
   /*Field,TYPE,NULL,KEY,DEFAULT,EXTRA
   'last_name','varchar(25)','NO','',NULL,'NULL'
   'dept_name','varchar(25)','NO','',NULL,'NULL'
   'full_name','varchar(50)','NO','',NULL,'NULL'

   */
    ALTER TABLE employees_with_departments
  DROP last_name;    
        
DESCRIBE employees_with_departments;
-- last name column deleted from the table.
/*
'dept_name','varchar(25)','NO','',NULL,'NULL'
'full_name','varchar(50)','NO','',NULL,'NULL'

*/


/*
Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
*/

SHOW DATABASES;
 USE robinson_2287; -- sets the 'robinson_2287' database as the current active database for executing subsequent queries. 
 SELECT DATABASE();



CREATE TEMPORARY TABLE employees_with_departments
       (
         first_name VARCHAR(25) NOT NULL,
         last_name VARCHAR(25) NOT NULL,
         dept_name VARCHAR(25) NOT NULL
        );
        
        DESCRIBE employees_with_departments;
/*
'first_name','varchar(25)','NO','',NULL,'NULL'
'last_name','varchar(25)','NO','',NULL,'NULL'
'dept_name','varchar(25)','NO','',NULL,'NULL'

*/
-- Adding a column full_name to the employees_with_departments table
-- full_name VARCHAR(25(first_name) + 25(last_name))

ALTER table employees_with_departments
ADD full_name VARCHAR(50);

-- Check the output
DESCRIBE employees_with_departments;
/*
Output:-

'first_name','varchar(25)','NO','',NULL,'NULL'
'last_name','varchar(25)','NO','',NULL,'NULL'
'dept_name','varchar(25)','NO','',NULL,'NULL'
'full_name','varchar(50)','YES','',NULL,'NULL'

*/





    ##############
    
    #2
--  Create a temporary table based on the payment table from the sakila database.

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
    
    
    /*
    CREATE TEMPORARY TABLE new_fake_table
    AS (SELECT * FROM employees.employees LIMIT 5);

    */
    USE robinson_2287;
    CREATE TEMPORARY TABLE payment_cents
    AS (SELECT * FROM sakila.payment );
    
    DESCRIBE payment_cents;
    /*
    'payment_id','smallint unsigned','NO','','0','NULL'
    'customer_id','smallint unsigned','NO','',NULL,'NULL'
    'staff_id','tinyint unsigned','NO','',NULL,'NULL'
	'rental_id','int','YES','',NULL,'NULL'
	'amount','decimal(5,2)','NO','',NULL,'NULL'
    'payment_date','datetime','NO','',NULL,'NULL'
    'last_update','timestamp','NO','','CURRENT_TIMESTAMP','on update CURRENT_TIMESTAMP'

    */
    
    
    
-- Alter the "payment" table to add a new column "amount_cents"
ALTER TABLE payment_cents
ADD amount_cents INT;

DESCRIBE payment_cents;


/*
'payment_id','smallint unsigned','NO','','0','NULL'
'customer_id','smallint unsigned','NO','',NULL,'NULL'
'staff_id','tinyint unsigned','NO','',NULL,'NULL'
'rental_id','int','YES','',NULL,'NULL'
'amount','decimal(5,2)','NO','',NULL,'NULL'
'payment_date','datetime','NO','',NULL,'NULL'
'last_update','timestamp','NO','','CURRENT_TIMESTAMP','on update CURRENT_TIMESTAMP'
'amount_cents','int','YES','',NULL,'NULL'

*/

-- Update the "amount_cents" column with the transformed values
UPDATE payment_cents
SET amount_cents = ROUND(amount * 100); -- this will not work as there is a limitation with decimal(5,2)

-- Hence
ALTER TABLE payment_cents
MODIFY amount_cents DECIMAL(10,2);

DESCRIBE payment_cents;
/*
'payment_id','smallint unsigned','NO','','0','NULL'
'customer_id','smallint unsigned','NO','',NULL,'NULL'
'staff_id','tinyint unsigned','NO','',NULL,'NULL'
'rental_id','int','YES','',NULL,'NULL'
'amount','decimal(5,2)','NO','',NULL,'NULL'
'payment_date','datetime','NO','',NULL,'NULL'
'last_update','timestamp','NO','','CURRENT_TIMESTAMP','on update CURRENT_TIMESTAMP'
'amount_cents','decimal(10,2)','YES','',NULL,'NULL'

*/

-- The error "1175
-- disable the safe update mode by executing 
SET SQL_SAFE_UPDATES = 0;

UPDATE payment_cents
SET amount_cents = amount_cents * 100;

-- round the value from amount
UPDATE payment_cents
SET amount_cents = ROUND(amount_cents);

-- change it to an int now
ALTER TABLE payment_cents
MODIFY amount_cents INT UNSIGNED;

DESCRIBE payment_cents;

/*
'payment_id','smallint unsigned','NO','','0','NULL'
'customer_id','smallint unsigned','NO','',NULL,'NULL'
'staff_id','tinyint unsigned','NO','',NULL,'NULL'
'rental_id','int','YES','',NULL,'NULL'
'amount','decimal(5,2)','NO','',NULL,'NULL'
'payment_date','datetime','NO','',NULL,'NULL'
'last_update','timestamp','NO','','CURRENT_TIMESTAMP','on update CURRENT_TIMESTAMP'
'amount_cents','int unsigned','YES','',NULL,'NULL'

*/
SELECT amount_cents FROM payment_cents LIMIT 2;

 ##############
    
    #3
    /*
    Go back to the employees database. Find out how the current average pay in each department compares to the overall current pay 
    --for everyone at the company. For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department 
    -- right now to work for? The worst?
    */
    
    -- Calculate the mean and standard deviation for all salaries
-- 1. departments and their average salary
-- 2. the average and stdev of all salaries
-- 1: build a query that gets dept names and avg sals
SELECT 
    dept_name,
    AVG(salary) AS dept_avg
FROM 
	employees.departments d
JOIN employees.dept_emp de
	-- link dept_no to dept_emp
	USING(dept_no)
JOIN employees.salaries s
	-- link emp_no to salaries
	USING(emp_no)
WHERE 
	-- current employees salaries in active departments
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
-- aggregate based on department
GROUP BY dept_name;

CREATE TEMPORARY TABLE dept_avgs (
SELECT 
	dept_name,
    AVG(salary) AS dept_avg
FROM 
	employees.departments d
JOIN employees.dept_emp de
	USING(dept_no)
JOIN employees.salaries s
	USING(emp_no)
WHERE 
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
GROUP BY dept_name);

--  2:
-- get the metrics that I want to compare these vals with
-- avg overall salary
-- stddev overall salary

DROP TABLE IF EXISTS metrics;


-- build the query that gets those things:
CREATE TEMPORARY TABLE metrics (
SELECT
	AVG(salary) AS overall,
    STDDEV(salary) AS stdv
FROM 
	employees.salaries s
WHERE to_date > NOW());

-- add new fields into our department
--  average table

-- adding new fields, thats a strutural change
-- which means that we want to use an alter

-- mean values:
ALTER TABLE dept_avgs
ADD overall_avg FLOAT;

-- stdev values
ALTER TABLE dept_avgs
ADD overall_std FLOAT;

-- z values
ALTER TABLE dept_avgs
ADD zscore FLOAT;

SELECT * FROM dept_avgs;

-- put values in cells that are already there

UPDATE dept_avgs
SET overall_avg = 
	(
    SELECT overall FROM metrics
    );
    
SELECT * FROM dept_avgs;

UPDATE dept_avgs
SET overall_std = 
	(
    SELECT stdv FROM metrics
    );

SELECT * FROM dept_avgs;

UPDATE dept_avgs
SET zscore = 
(dept_avg - overall_avg) / overall_std;

SELECT dept_name, zscore FROM dept_avgs
ORDER BY zscore DESC;


-- Output:-
/*dept_name,dept_avg,z_score
'Customer Service','67285.2302','-0.27308011332998483'
'Development','67657.9196','-0.25154976812475716'
'Finance','78559.9370','0.3782620753443599'
'Human Resources','63921.8998','-0.46738041956685833'
'Marketing','80058.8488','0.4648545260182702'
'Production','67843.3020','-0.24084018779600722'
'Quality Management','65441.9934','-0.37956429184157997'
'Research','67913.3750','-0.2367920558138099'
'Sales','88852.9695','0.9728927327594301'


*/

-- or
-- Not using temp tables:

WITH depts AS (
	SELECT 
		dept_name,
		AVG(salary) AS dept_avg
	FROM 
		employees.departments d
	JOIN employees.dept_emp de
		USING(dept_no)
	JOIN employees.salaries s
		USING(emp_no)
	WHERE 
		de.to_date > NOW()
		AND 
		s.to_date > NOW()
	GROUP BY dept_name)
SELECT 
	dept_name,
    dept_avg,
    -- x - mu / o 
    (dept_avg - (
		SELECT AVG(salary) 
        FROM employees.salaries s
        WHERE s.to_date > NOW()))
        /
        (SELECT STDDEV(salary) 
        FROM employees.salaries s
        WHERE s.to_date > NOW()) 
        AS z_score
FROM depts;