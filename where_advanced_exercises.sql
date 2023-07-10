SHOW DATABASES;
USE employees;
DESCRIBE employees;
-- # 1
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya'
--  using IN. What is the employee number of the top three results?


SELECT emp_no,
first_name,
last_name
FROM employees
WHERE first_name IN ('Irena','Vidya', 'Maya')
LIMIT 3 ;

-- ANSWER: 10200
-- 10397
-- 10610
-- # 2
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya',
-- as in Q2, but use OR instead of IN. 
-- What is the employee number of the top three results? Does it match the previous question?

-- DESCRIBE employees;
 SELECT emp_no,
 first_name,
last_name
 FROM employees
 WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya'
 LIMIT 3 ;
 
 -- ANSWER: 10200
-- 10397
-- 10610
-- Yes it matches the previous
DESCRIBE employees;
-- # 3
 SELECT emp_no,
 first_name,
 last_name,
 gender
 FROM employees
 WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya')
 AND gender = 'M'
 LIMIT 3 ;
-- ANSWER: 10200
-- 10397
-- 10821

-- #4  Find all unique last names that start with 'E'.

SELECT DISTINCT
 last_name
 FROM employees
 WHERE last_name LIKE 'E%';
 
 

-- #5  Find all unique last names that start or end with 'E'.

SELECT DISTINCT
 last_name
 FROM employees
 WHERE last_name LIKE 'E%'
 OR last_name LIKE '%E';
 
-- Find all unique last names that start with 'E'.
SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'E%';
 
 -- #6  Find all unique last names that end with 'E',but does not start with e.
SELECT DISTINCT
 last_name
 FROM employees
 WHERE last_name LIKE '%e'
 AND last_name NOT LIKE 'E%';
 
 SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'E%'
 OR last_name LIKE 'E%e';
 
 
 SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'E%'
 AND last_name LIKE 'E%e';
 
 -- # 7
 SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'E%e';
 
 -- Find all current or previous employees hired in the 90s. 
 -- Enter a comment with top three employee numbers.
 
DESCRIBE employees;
 
SELECT emp_no,
first_name,
last_name
FROM employees
WHERE first_name IN ('Irena','Vidya', 'Maya')
LIMIT 3 ;

-- ANSWER: 10200
-- 10397
-- 10610
-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya',
-- as in Q2, but use OR instead of IN. 
-- What is the employee number of the top three results? Does it match the previous question?

-- DESCRIBE employees;
 SELECT emp_no,
 first_name,
last_name
 FROM employees
 WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name ='Maya'
 LIMIT 3 ;
 
-- # 8
 SELECT emp_no
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
LIMIT 3;

DESCRIBE employees;

SELECT emp_no,
first_name,
last_name,
birth_date
FROM employees
WHERE
(hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND 
(MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25)
LIMIT 3;

-- #9

SELECT emp_no,
first_name,
last_name,
birth_date
FROM employees
WHERE MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25
LIMIT 3;


-- SELECT emp_no,
-- first_name,
-- last_name,
-- birth_date
-- FROM employees
-- WHERE MONTH(birth_date) LIKE '99%' AND DAYOFMONTH(birth_date) = 25
-- LIMIT 3;

SELECT DISTINCT
 first_name,
 last_name
 FROM employees
 WHERE last_name LIKE 'Q%';
 
 -- SELECT DISTINCT
-- first_name,
 -- last_name
 -- FROM employees
 -- WHERE last_name LIKE 'Q%') 
 -- AND ;
 
 SELECT DISTINCT
 emp_no,
 first_name,
last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- USE albums_db;
SELECT emp_no,
first_name,
last_name,
birth_date
FROM employees
WHERE
(hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND 
(MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25)
LIMIT 3;

SHOW DATABASES;
USE employees;

SELECT emp_no,
first_name,
last_name,
birth_date,
hire_date
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
  AND MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25;


SHOW DATABASES;


SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE hire_date >= '1990-01-01'
    AND hire_date <= '1999-12-31'
    AND DATE_FORMAT(birth_date, '%m-%d') = '12-25'
LIMIT 3;

-- output:-
-- '10261','Mang','Erie','1959-12-25'
-- '10438','Evgueni','Srimani','1961-12-25'
-- '10681','Florina','Garnier','1964-12-25'


-- #10

SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND MONTH(birth_date) = 12
    AND DAY(birth_date) = 25
LIMIT 3;
DESCRIBE employees;

/*
SELECT DISTINCT
 emp_no,
 first_name,
last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
*/

-- # 11
SELECT DISTINCT
last_name
FROM employees
WHERE last_name LIKE '%q%';

-- # 12
SELECT DISTINCT
last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';