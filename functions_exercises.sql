-- 2
-- Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

SHOW DATABASES;
SELECT DATABASE();
USE employees;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
  FROM employees
  WHERE last_name LIKE 'E%e';        
       
       -- FROM: EMPLOYEES from employees schema
       -- where under the condition: last name starts and end with
       -- select concat make a new field alter
       -- as FULL NAME ALIAS THT NEW FIELD
       -- WE WANT UPPER OF THE CONCATENATION THt we get
       -- UPPER(CONCAT()
SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'E%e';
 
 /*
 SELECT COUNT(*) AS employee_count,
       (SELECT CONCAT(first_name, ' ', last_name)
        FROM employees
        WHERE last_name LIKE 'E%e'
        ORDER BY hire_date DESC
        LIMIT 1) AS Newest_employee,
       (SELECT CONCAT(first_name, ' ', last_name)
        FROM employees
        WHERE last_name LIKE 'E%e'
        ORDER BY hire_date ASC
        LIMIT 1) AS Oldest_employee
FROM employees
WHERE last_name LIKE 'E%e';
*/

        
        
  -- 3 Convert the names produced in your last query to all uppercase.
  SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
  FROM employees
  WHERE last_name LIKE 'E%e';
  
  -- 4
  /*
  Find all employees hired in the 90s and born on Christmas.
  Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
  */
  -- ALL EMPLOYEES NO FIELD SPECIFIED
  -- TIME WORKED AT COMPANY IN DAYS
  -- CONDITION (WHERE) BORN ON 12-25 HIRED IN 90'S
  
  SELECT DATEDIFF(year, '1990-01-01', '1999-12-31') AS DateDiff
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND MONTH(birth_date) = 12
    AND DAY(birth_date) = 25;
   -- ORDER BY hire_date DESC;
  -- SELECT CURDATE()
  -- SELECT DATEDIFF(year, '2017/08/25', '2011/08/25') AS DateDiff;
  -- HIRE_DATE 'LIKE '199%'
  -- AND BIRTH_date LIKE '%12-25';
  -- DATEDIFF(NCURDATE(),HIRE_DATE) /365 AS DAYS_EMPLOYED
  -- MAX(SALARY). RETURNS A SINGLE VALUE
  
SELECT CONCAT(first_name, ' ', last_name) AS full_name, DATEDIFF(NOW(), hire_date) AS days_worked
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
  AND MONTH(birth_date) = 12
  AND DAY(birth_date) = 25;
  
  
  -- 5
  -- Find the smallest and largest current salary from the salaries table
  SHOW TABLES;
  -- salaries
  /*  SELECT *
             FROM employees.salaries; */

SELECT MIN(salary) AS smallest_salary, MAX(salary) AS largest_salary
FROM employees.salaries;
  -- '38623','158220'

-- 6

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, 
-- and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
/*

+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
10 rows in set (0.05 sec)
  
*/

  
  SELECT CONCAT(
    LOWER(SUBSTRING(first_name, 1, 1)),
    SUBSTRING(last_name, 1, 4),
    '_',
    MONTH(birth_date),
    RIGHT(YEAR(birth_date), 2)
  ) AS username,
  first_name,
  last_name,
  birth_date
FROM employees;
-- OUTPUT : flast_mmyy

--  SELECT LEFT(first_name,1) FROM employees LIMIT 5;
-- Check the date format SELECT * FROM employees LIMIT 1; --- STRING METRIC CALL
-- SELECT MONTH(BIRTH_DATE) FROM employees;
/* Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, 
-- and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, 
-- the month the employee was born, and the last two digits of the year that they were */
-- SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name
-- SUBSTR(string, start_index, length)
-- SUBSTR(first_name, 1, 1)
-- SUBSTR(last_name, 1, 4)
-- SELECT LOWER(CONCAT(first_name, ' ', last_name)) AS full_name
-- SUBSTR(birth_date,3,2) -- year
-- SUBSTR(birth_date,6,2) -- month
-- SUBSTR(birth_date,1,4)--last_name
-- SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), ' ', SUBSTR(last_name, 1, 4))) AS full_name
  -- SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1)), SUBSTR(last_name, 1, 4),'_',MONTH(birth_date),RIGHT(YEAR(birth_date),2)) AS username , first_name,last_name,birth_date;
 
-- SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), SUBSTR(last_name, 1, 4),'_',MONTH(birth_date), RIGHT(YEAR(birth_date),2)) AS username, first_name,last_name,birth_date FROM employees;
 SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), SUBSTR(last_name, 1, 4),'_',MONTH(birth_date), RIGHT(YEAR(birth_date),2)) AS username, first_name,last_name,birth_date FROM employees;
 SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), SUBSTR(last_name, 1, 4),'_',MONTH(birth_date), RIGHT(YEAR(birth_date),2)) AS username, first_name,last_name,birth_date FROM employees;