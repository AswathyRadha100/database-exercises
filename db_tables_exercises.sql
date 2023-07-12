
###############################
# DB Table exercises          #
#                             #
###############################
SHOW DATABASES;
USE albums_db;
SHOW CREATE DATABASE albums_db;
SHOW TABLES;
USE employees;
SHOW TABLES;


-- Explore the employees table
DESCRIBE employees;
-- or
SHOW COLUMNS FROM employees;
/*
### Fields in the "employees" table:- 
emp_no,birth_date,first_name,last_name,gender,hire_date.


### data types in the "employees" table:-
Integer Data Types:
INT or INTEGER: Used for storing whole numbers.
Character Data Types:
VARCHAR: Used for storing variable-length strings.
Date and Time Data Types:
DATE: Used for storing dates in the format 'YYYY-MM-DD'.
Boolean Data Type:
The enumeration data type enum('M','F')is used to represent a column that can have only two specific values: 'M' or 'F'

*/
 
 
-- Which table(s) do you think contain a numeric type column?
/*
employees table: The emp_no column is a numeric type column, integer (INT).
salaries table: The salary column is a numeric type column, a floating-point number (FLOAT) or a decimal (DECIMAL) represents the employee's salary.
dept_manager table: The emp_no column, is a numeric type column.
*/



-- Which table(s) do you think contain a string type column?
/*
employees table: The first_name and last_name columns are string type columns, such as VARCHAR, storing the employees' names.
departments table: The dept_name column is a string type column, representing the names of the departments.
titles table: The title column is a string type column, storing the job titles of the employees.
*/



-- Which table(s) do you think contain a date type column?
/*
employees table: The birth_date and hire_date columns are date type columns, storing the birth date and hire date of the employees.
salaries table: The from_date and to_date columns are date type columns, indicating the start and end dates of salary periods.
dept_manager table: The from_date and to_date columns in the dept_manager table are date type columns, indicating the start and end dates of department manager.

*/



-- What is the relationship between the employees and the departments tables? 
/*
The relationship between these tables is likely a one-to-many relationship, where one department can have multiple employees, but each employee belongs to only one department.
The primary key of the "departments" table, which uniquely identifies each department, is referenced as a foreign key in the "employees" table. 
This foreign key establishes the relationship between the two tables.

Departments Table:-
dept_id (Primary Key)
dept_name
other_department_columns
Employees Table:-
emp_id (Primary Key)
emp_name
emp_dept_id (Foreign Key referencing dept_id in Departments table)
other_employee_columns
*/



-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;

-- To retrieve all rows and columns from the dept_manager table
SELECT * FROM dept_manager;