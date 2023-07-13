##############################################################################################################################
#  CASE statements  Exercises                                                                                                #
#  Goal: Use CASE statements or IF() function to explore information in the employees database                               #    
##############################################################################################################################
SHOW DATABASES; -- displays a list of databases that exist in your MySQL server.
USE employees; -- sets the 'employees' database as the current active database for executing subsequent queries
SHOW tables; -- returns list of tables that exist within the 'employees' database


-- #1 Write a query that returns all employees, their department number, 
-- their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
            
SELECT
    emp.emp_no,
    dept.dept_no,
    emp.hire_date,
    de.to_date,
    CASE
        WHEN de.to_date > NOW() THEN 1
        ELSE 0
    END AS is_current_employee
FROM employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
JOIN departments dept ON de.dept_no = dept.dept_no;



-- #2 Write a query that returns all employee names (previous and current), and a new column 'alpha_group' 
-- that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.



SELECT
    CONCAT(first_name, ' ', last_name) AS employee_name,
    CASE
        WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
        WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
        ELSE 'R-Z'
    END AS alpha_group
FROM employees;


-- # 3 How many employees (current or previous) were born in each decade?

-- SELECT MIN(birth_date), MAX(birth_date)FROM employees;

SELECT count(*) AS count_per_decade,
	CASE
		WHEN birth_date LIKE '195%' THEN 'born_in_50s'
        ELSE 'born_in_60s'
	END AS birth_decade
FROM employees
GROUP BY birth_decade;

-- #4 What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(salary) AS average_salary,
        CASE 
            WHEN dept_name IN ('research', 'development') THEN 'R&D'
            WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
            WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
            WHEN dept_name IN ('Customer Service') THEN 'Customer Service' 
            WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
            ELSE dept_name
            END AS dept_group
FROM departments
    JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
    JOIN employees ON dept_emp.emp_no = employees.emp_no
    JOIN salaries ON employees.emp_no = salaries.emp_no
GROUP BY dept_name
ORDER BY average_salary DESC;



--  BONUS

-- Remove duplicate employees from exercise 1.
/*
Write a query that returns all employees, their department number, 
their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
Remove duplicate employees 
*/

SELECT 
    DISTINCT
    emp.emp_no,
    dept.dept_no,
    emp.hire_date,
    de.to_date,
    CASE
        WHEN de.to_date > NOW() THEN 1
        ELSE 0
    END AS is_current_employee
FROM employees emp
JOIN dept_emp de ON emp.emp_no = de.emp_no
JOIN departments dept ON de.dept_no = dept.dept_no;


