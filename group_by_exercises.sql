-- 1. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

SHOW DATABASES;
USE employees;
-- SELECT DATABASE();

SHOW TABLES;

-- titles
/*
SELECT DISTINCT
 first_name,
 last_name
 FROM employees.titles
 WHERE last_name LIKE 'E%e'
 -- FROM employees.titles;
 
 SELECT * FROM employees;
 
 */
 -- SELECT sales FROM albums;
 SELECT DISTINCT title
FROM employees.titles;


-- 3
-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%'
    AND last_name LIKE '%E'
GROUP BY last_name;
-- 4
-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%'
    AND last_name LIKE '%E'
GROUP BY first_name, last_name;
-- 5
-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%';
    
    -- 6
    -- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
    -- Add a COUNT() to above query to find the number of employees with the same last name.
    
    SELECT last_name, COUNT(*) AS employee_count
FROM employees
WHERE last_name LIKE '%q%'
    AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- 7
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.

SELECT first_name, gender, COUNT(*) AS employee_count
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;
/*
'Vidya','M','151'
'Irena','M','144'
'Irena','F','97'
'Maya','F','90'
'Vidya','F','81'
'Maya','M','146'
*/

-- 8
-- Using your query that generates a username for all employees, generate a count of employees with each unique username.

SELECT username, COUNT(*) AS employee_count
FROM (
    SELECT CONCAT(SUBSTRING(first_name, 1, 1), last_name) AS username
    FROM employees
) AS derived_table
GROUP BY username;

-- 9
-- From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
-- write a query to figure out from the above query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there? 
SELECT username, COUNT(*) AS employee_count
FROM (
    SELECT CONCAT(SUBSTRING(first_name, 1, 1), last_name) AS username
    FROM employees
) AS derived_table
GROUP BY username
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;