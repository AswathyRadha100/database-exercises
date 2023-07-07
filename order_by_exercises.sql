SELECT first_name, last_name
FROM employees
ORDER BY last_name;
--
SHOW DATABASES;
USE employees;

SELECT emp_no,
first_name,
last_name
FROM employees
WHERE first_name IN ('Irena','Vidya', 'Maya')
ORDER BY first_name
 ;
 
 -- first row '10397','Irena','Reutenauer'
 -- last row  '497788','Vidya','Simmen'
/*
SELECT emp_no,
first_name,
last_name
FROM employees
WHERE first_name IN ('Irena','Vidya', 'Maya')
ORDER BY ((first_name) 
AND (last_name));
 -- '499750','Maya','Melter'
*/

-- 3
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
-- 'Vidya','Zweizig'

-- 4
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- 'Irena','Acton'
-- 'Maya','Zyda'


-- 5
SELECT emp_no, first_name, last_name
FROM employees
WHERE
last_name LIKE 'E%e'
ORDER BY emp_no;

-- '10021','Ramzi','Erde'
-- '499648','Tadahiro','Erde'


-- 6
/*
 SELECT COUNT(*) AS employee_count,
       MAX(CONCAT(first_name, ' ', last_name)) AS Newest_employee,
       MIN(CONCAT(first_name, ' ', last_name)) AS Oldest_employee
    --   MAX(first_name,last_name) AS Newest_employee,
     --  MIN(first_name,last_name) AS Oldest_employee
FROM employees
WHERE
last_name LIKE 'E%e'
ORDER BY hire_date DESC;
*/
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
/* OUTPUT
'899','Teiji Eldridge','Sergi Erde'
*/

SELECT COUNT(*) AS employee_count,
       CONCAT_WS(' ', MAX(first_name), MAX(last_name)) AS Newest_employee,
       CONCAT_WS(' ', MIN(first_name), MIN(last_name)) AS Oldest_employee
FROM employees
WHERE last_name LIKE 'E%e';
/* OUTPUT
'899','Zvonko Etalle','Aamod Eldridge'

*/

/*
 -- SELECT emp_no,hire_date, first_name, last_name
SELECT COUNT(*) AS employee_count,
       MAX(first_name AND last_name) AS Newest_employee,
       MIN(first_name AND last_name) AS Oldest_employee
FROM employees
WHERE
last_name LIKE 'E%e'
ORDER BY hire_date DESC;
-- Newest employee '233488','1985-02-02','Sergi','Erde'

-- Oldest employee  '67892','1999-11-27','Teiji','Eldridge'

SELECT emp_no,hire_date, first_name, last_name
FROM employees
WHERE
last_name LIKE 'E%e'
ORDER BY hire_date DESC;

-- Newest employee  '67892','1999-11-27','Teiji','Eldridge'
-- Oldest employee '233488','1985-02-02','Sergi','Erde'

*/
-- 7
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
    AND MONTH(birth_date) = 12
    AND DAY(birth_date) = 25
    ORDER BY hire_date DESC;
    /* Output
    first line '33936','1952-12-25','Khun','Bernini','M','1999-08-31'
    last line '243297','1962-12-25','Alselm','Cappello','F','1990-01-01'
    Employees Returned is 13
    */

SELECT emp_no,
first_name,
last_name,
birth_date,
hire_date
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
  AND MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25
  ORDER BY hire_date DESC;
  
  -- Employees returned is 10
  -- the oldest employee who was hired last is the first
  -- '33936','Khun','Bernini','1952-12-25','1999-08-31'
  -- the youngest employee who was hired first
  -- HIREDATE AND THEN BIRTH DATE

SELECT emp_no,
first_name,
last_name,
birth_date,
hire_date
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
  AND MONTH(birth_date) = 12 AND DAYOFMONTH(birth_date) = 25
  ORDER BY hire_date; -- FOR GETTING ASCENDING values
/*

SELECT COUNT(*) AS employee_count,
       MAX(last_name) AS oldest_employee_last_name_hired_last,
       MIN(last_name) AS youngest_employee_last_name_hired_first
FROM employees
WHERE YEAR(hire_date) BETWEEN 1990 AND 1999
  AND MONTH(birth_date) = 12
ORDER BY hire_date DESC;
-- '11339','Zykh','Aamodt'

*/
 -- 3
 SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC;