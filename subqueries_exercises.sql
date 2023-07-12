##############################################################################################################################################################
# Subquery - Exercise Goals                                                                                                                                             #
#                                                                                                                                                            #
# Use subqueries to find information in the employees database                                                                                               #
#                                                                                                                                                            #
##############################################################################################################################################################
SHOW DATABASES; -- display a list of databases that exist in your MySQL server.
USE employees; -- sets the 'employees' database as the current active database for executing subsequent queries
SHOW tables; -- returns list of tables that exist within the 'employees' database
DESCRIBE employees; -- describes structure of employees table

-- #1 Find all the current employees with the same hire date as employee 101010 using a subquery.

SELECT 
	*
FROM 
    employees e
JOIN
	dept_emp de
	ON de.emp_no = e.emp_no
	AND de.to_date > NOW()
WHERE
	hire_date = (
		SELECT 
			 hire_date
		FROM 
			employees
		WHERE 
			emp_no = 101010
            )
;

 -- Output:
 /*
'12439','1958-10-24','Shigeo','Kaiserswerth','M','1990-10-22','12439','d009','1990-10-22','9999-01-01'
'13782','1961-03-17','Akemi','Iwayama','M','1990-10-22','13782','d001','1992-04-15','9999-01-01'
'21052','1963-01-27','Emran','Laventhal','M','1990-10-22','21052','d006','1990-10-22','9999-01-01'
'25364','1955-04-26','Wayne','Schoegge','F','1990-10-22','25364','d004','1999-05-30','9999-01-01'
'28013','1961-10-23','Zeljko','Baik','F','1990-10-22','28013','d005','1990-10-22','9999-01-01'

...
*/
 


-- #2 Find all the titles ever held by all current employees with the first name Aamod.

SELECT 
	title,
    COUNT(*) AS employee_count
FROM 
	titles
WHERE 
	emp_no IN (
		SELECT 
			e.emp_no
		FROM
			employees e
		JOIN dept_emp de
			ON de.emp_no = e.emp_no
			AND de.to_date > NOW()
		WHERE first_name = 'Aamod'
    )
GROUP BY title;

-- Output:
/*
'Senior Staff','60'
'Staff','64'
'Engineer','62'
'Technique Leader','9'
'Senior Engineer','51'
'Assistant Engineer','5'

*/

-- #3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.


SELECT 
	COUNT(*) AS Resigned
FROM employees AS e
WHERE e.emp_no IN (
	SELECT emp_no
	FROM dept_emp AS d
	GROUP BY d.emp_no
	HAVING MAX(to_date) < NOW()
);
-- Output:
-- The no:of employees no longer working for the company '59900'

-- #4 Find all the current department managers that are female. List their names in a comment in your code.
--
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no FROM dept_manager
    WHERE to_date > NOW()
)
  AND gender = 'F';
  
  -- Output:
  /*
  'Isamu','Legleitner'
'Karsten','Sigstam'
'Leon','DasSarma'
'Hilary','Kambil'

  */
 
-- #5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT
	COUNT(*)
FROM 
	employees e
JOIN dept_emp de
	USING (emp_no)
JOIN salaries s
	USING (emp_no)
WHERE
	de.to_date > NOW()
    AND
    s.to_date > NOW()
	AND
    salary > 
    (
		SELECT 
		AVG(salary)
		FROM salaries
	);
    
    -- Output:-
    -- '154543'


-- #6 How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

 SELECT count(salary) AS number_of_salaries
FROM salaries 
WHERE to_date > now()
AND salary >= 
    (SELECT max(salary) - stddev(salary)
    FROM salaries
    where to_date>curdate());
    
    -- Output:-
    -- Number_of_salaries: 83
    
 --  to find the percentage of all salaries
 SELECT 
(SELECT count(salary) 
FROM salaries 
WHERE to_date > now()
AND salary >= 
    (SELECT max(salary) - stddev(salary)
    FROM salaries
    WHERE to_date>curdate()))
    /
(SELECT count(salary)
    FROM salaries 
    WHERE to_date > now()
    ) * 100 AS percent_of_salaries;
 
 
 -- Output:
 -- percent_of_salaries is 0.0346
 

##############################################################################################################################################################
# BONUS:                                                                                                                                                     #
##############################################################################################################################################################


# 1 Find all the department names that currently have female managers.

SELECT dept_name 
FROM departments d
JOIN dept_manager dm ON dm.dept_no = d.dept_no
WHERE emp_no IN 
(SELECT emp_no 
FROM employees
WHERE gender = 'F')
AND to_date > now();


-- OUTPUT:-
/*
'Finance'
'Human Resources'
'Development'
'Research'
*/
-- # 2 Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN ( 
SELECT emp_no
FROM salaries
WHERE salary >= (SELECT max(salary)
FROM salaries));

-- or 

SELECT first_name, last_name FROM employees
WHERE emp_no = (
    SELECT emp_no FROM salaries
    WHERE salary = (
        SELECT MAX(salary) FROM salaries
    )
);

-- Output:-
/*
'Tokuyasu','Pesch'
*/
-- # 3 Find the department name that the employee with the highest salary works in.
SELECT dept_name 
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
WHERE de.emp_no IN ( 
SELECT emp_no
FROM salaries
WHERE salary >= (SELECT max(salary)
FROM salaries));

-- Output:-
-- Sales is the department where the employee with the highest salary works .

-- # 4 Who is the highest paid employee within each department.


WITH dept_names AS
	(
	SELECT 
		d.dept_name,
		d.dept_no,
		MAX(s.salary) AS maxsal
	FROM salaries s
	JOIN dept_emp de
		ON de.emp_no = s.emp_no
		AND s.to_date > NOW()
		AND de.to_date > NOW()
	JOIN departments d
		USING (dept_no)
	GROUP BY dept_name
	),
emp_info AS (
	SELECT 
		e.first_name, 
		e.last_name,
		de.dept_no,
		s.salary
	FROM 
		employees e
	JOIN dept_emp de
		USING(emp_no)
	JOIN salaries s
		USING(emp_no)
	WHERE 
		de.to_date > NOW()
	AND
		s.to_date > NOW()
)
SELECT 
	emp_info.first_name,
    emp_info.last_name,
    dept_names.dept_name
FROM 
	dept_names
LEFT JOIN emp_info
ON emp_info.salary = dept_names.maxsal
AND emp_info.dept_no = dept_names.dept_no;


-- Output:-
/*
'Khosrow','Sgarro','Development'
'Tokuyasu','Pesch','Sales'
'Youjian','Cronau','Production'
'Yinlin','Flowers','Human Resources'
'Ramachenga','Soicher','Research'
'Shin','Luck','Quality Management'
'Akemi','Warwick','Marketing'
'Vidya','Hanabata','Customer Service'
'Lunjin','Swick','Finance'
*/

#####################


