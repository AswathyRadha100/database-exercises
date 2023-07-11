##############################################################################################################
-- Indexes (Indices)
##############################################################################################################
-- #1 Explore the indexes in the employees database
USE employees;
SELECT database();
SHOW TABLES;
SHOW INDEX FROM employees;
-- employees table
-- Key_name Primary
-- Column_name emp_no
-- table nonunique, keyname,seq_in_index,column_name,collation,sub_part,packed,null,index_type,comment,index_comment,visible,expression
-- 'employees','0','PRIMARY','1','emp_no','A','298980',NULL,NULL,'','BTREE','','','YES',NULL


/*
Table: Name of the table on which the index is defined.
Non_unique: Indicates whether the index allows duplicate values (0 for unique indexes, 1 for non-unique indexes).
Key_name: Name of the index.
Seq_in_index: The sequence number of the column within the index.
Column_name: Name of the column included in the index.
Collation: Collation used for the column in the index.
Cardinality: The approximate number of unique values in the index.
Index_type: The type of index (e.g., BTREE, HASH).
Comment: Additional comments or information about the index.
*/


-- #2 DESCRIBE each table and inspect the keys and see which columns have indexes and keys.
-- To inspect the keys and indexes for each table in the "employees" database, you can use the DESCRIBE statement for each table. 
-- Employees Table:
SHOW tables;
-- Tables in employees:
DESCRIBE employees;
-- emp_no,int,pri
DESCRIBE departments;
-- dept_no, char(4),PRI
-- dept_name, varchar(40),UNI
DESCRIBE salaries;
-- emp_no,PRI
-- from_date,PRI
DESCRIBE titles;
/*
'emp_no','int','NO','PRI',NULL,''
'title','varchar(50)','NO','PRI',NULL,''
'from_date','date','NO','PRI',NULL,''
'to_date','date','YES','',NULL,''
*/
DESCRIBE dept_emp;
/* 'emp_no','int','NO','PRI',NULL,''
'dept_no','char(4)','NO','PRI',NULL,''
'from_date','date','NO','',NULL,''
'to_date','date','NO','',NULL,''
*/
DESCRIBE dept_manager;

/* 'emp_no','int','NO','PRI',NULL,''
'dept_no','char(4)','NO','PRI',NULL,''
'from_date','date','NO','',NULL,''
'to_date','date','NO','',NULL,''
*/
#############################################################################################################
-- Join Example Database --
-- #1 Use the join_example_db. Select all the records from both the users and roles tables.
SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

-- # 2 Use join, left join, and right join 
-- to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;


SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- #3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name AS role_name, COUNT(users.id) AS user_count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.id, roles.name;
#############################################################################################################
-- Employees Database --
#############################################################################################################
-- #1 Use the employees database.
 USE employees;
 SELECT * FROM departments LIMIT 5;
 SELECT * FROM dept_emp LIMIT 5;
 SELECT * FROM dept_manager LIMIT 5;
  SELECT * FROM employees LIMIT 5;
  
  
 -- #2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along
 -- with the name of the current manager for that department.
/* Example 
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;
*/
/*
  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
  
  */
  
SELECT d.dept_name AS "Department Name", CONCAT(m.first_name, ' ', m.last_name) AS "Department Manager"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS m ON dm.emp_no = m.emp_no
WHERE dm.to_date = '9999-01-01'
ORDER BY dept_name;


-- # 3
/* Find the name of all departments currently managed by women.


Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil
*/
/*
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;
*/

SELECT d.dept_name AS "Department Name", CONCAT(m.first_name, ' ', m.last_name) AS "Manager Name" -- , m.gender AS Gender
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS m ON dm.emp_no = m.emp_no
WHERE dm.to_date = '9999-01-01'
AND m.gender = 'F'
ORDER BY dept_name;
  
  -- #4
  /*Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241
*/
/*
SELECT t.title AS "Title", COUNT(*) AS "Count" 
FROM employees AS e
JOIN titles AS t ON e.emp_no = t.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
WHERE dm.to_date = '9999-01-01'
  AND m.gender = 'F';

*/
-- SELECT * FROM departments;

SELECT t.title AS "Title", COUNT(*) AS "Count"
FROM employees AS e
JOIN titles AS t ON e.emp_no = t.emp_no
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
  AND d.dept_name = 'Customer Service'
GROUP BY t.title
ORDER BY Title; 


-- # 5 Find the current salary of all current managers.
/*

Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987

*/
-- salary value: salaries table, emp no
-- managers emp_nos are in dept_manager table

SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Name", s.salary AS "Salary"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01'
  AND s.to_date = '9999-01-01'
ORDER BY dept_name;

----------
/*
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Name", s.salary AS "Salary"
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01'
  AND s.to_date = '9999-01-01';
  */
  --------------------


-- #6 Find the number of current employees in each department.
/*

+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+
*/



SELECT 
	d.dept_no,
    d.dept_name,
    COUNT(*) AS "num_employees"
FROM
    departments AS d
JOIN 
    dept_emp AS de ON d.dept_no = de.dept_no
WHERE 
    de.to_date = '9999-01-01'
GROUP BY 
    d.dept_no, d.dept_name
ORDER BY 
    dept_no;

/*
SELECT 
	d.dept_no,
    d.dept_name,
    COUNT(*) AS "num_employees"
FROM
    departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY d.dept_no, d.dept_name;

*/

-- # 7 Which department has the highest average salary? Hint: Use current not historic information.

/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
*/


SELECT 
    d.dept_name, AVG(s.salary) AS "average_salary"
FROM 
    departments AS d
JOIN
    dept_emp AS de ON d.dept_no = de.dept_no
JOIN
    salaries AS s ON de.emp_no = s.emp_no
WHERE 
    de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY 
    d.dept_name
ORDER BY 
    AVG(s.salary) DESC
LIMIT 1;

/*
SELECT d.dept_name, AVG(s.salary) AS "average_salary"
FROM departments AS d
JOIN dept_emp AS de USING( d.dept_no) = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;
*/

-- #8 
-- Who is the highest paid employee in the Marketing department?

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
*/

SELECT 
    e.first_name,
    e.last_name
FROM 
	employees AS e
JOIN 
    dept_emp AS de ON e.emp_no = de.emp_no
JOIN 
   departments AS d ON de.dept_no = d.dept_no
JOIN 
   salaries AS s ON e.emp_no = s.emp_no
WHERE 
   de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;
/*
SELECT 
    e.first_name,
    e.last_name
FROM 
	employees AS e
JOIN 
dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;
*/
-- #9. 
/*
Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
*/


/*
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;
*/

SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC
LIMIT 1;


-- # 10 Determine the average salary for each department. Use all salary information and round your results.
/*

+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+

*/-- the average salary for each department. Use all salary information and round your results.


SELECT d.dept_name, ROUND(AVG(s.salary)) AS "average_salary"
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;


/*
SELECT d.dept_name, ROUND(AVG(s.salary)) AS "average_salary"
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;
*/
/*
 SELECT d.dept_name, ROUND( AVG(s.salary)) AS "Average_salary"
 FROM departments AS d
 JOIN dept_emp AS de ON d.dept_no = de.dept_no
 JOIN salaries AS s ON de.emp_no = s.emp_no
 WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
 ORDER BY AVG(s.salary) DESC;
 
 
SELECT d.dept_name, ROUND(AVG(s.salary)) AS "average_salary"
FROM departments AS d
JOIN dept_emp AS de ON d.dept_no = de.dept_no
JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;

*/
-- Use function call ROUND



-- #11. Find the names of all current employees, their department name, and their current manager's name.

/*
240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
 */
-- SELECT * FROM dept_emp;
-- SELECT * FROM departments;
-- SELECT * FROM employees;
 
 SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Employee Name",
       d.dept_name AS "Department Name",
       CONCAT_WS(' ', m.first_name, m.last_name) AS "Manager Name"
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no AND e.emp_no = dm.emp_no
JOIN employees AS m ON dm.emp_no = m.emp_no
WHERE de.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'
GROUP BY e.emp_no, d.dept_name;

 

/*

SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Name", s.salary AS "Salary"
FROM departments AS d
LEFT JOIN dept_manager AS dm ON d.dept_no = dm.dept_no AND dm.to_date = '9999-01-01'
LEFT JOIN employees AS e ON dm.emp_no = e.emp_no
LEFT JOIN salaries AS s ON e.emp_no = s.emp_no AND s.to_date = '9999-01-01';
*/

##############################################################################################################
