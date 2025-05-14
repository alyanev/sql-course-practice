-- Section 14: Window Functions 

--- --- Create Database and Table ---

-- Create a database called window_funcs:
CREATE DATABASE window_funcs;
USE DATABASE window_funcs;

-- Create a table named employees with emp_no, department, and salary:
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

-- Insert sample data into employees table:
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

--- --- Basic Aggregation with GROUP BY ---

-- Calculate average salary for each department:
SELECT department, AVG(salary) FROM employees
GROUP BY department;

--- --- OVER() Function ---

-- Calculate average salary over the entire table (without grouping):
SELECT department, AVG(salary) OVER() FROM employees;

-- Find the minimum and maximum salary for each employee, using GROUP BY:
SELECT emp_no, department, salary, MIN(salary), MAX(salary)
FROM employees
GROUP BY emp_no, department, salary;

-- Find the minimum and maximum salary for the entire table:
SELECT MIN(salary), MAX(salary)
FROM employees;

--- --- PARTITION BY ---

-- Calculate the average salary per department and overall company average:
SELECT
    emp_no,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;

-- Count the number of employees in each department:
SELECT emp_no, department, salary, COUNT(*) OVER(PARTITION BY department) as dept_count
FROM employees;

-- Calculate the total payroll for each department and the entire company:
SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
    SUM(salary) OVER() AS total_payroll
FROM employees;

--- --- ORDER BY inside OVER() ---

-- Calculate rolling department salary and total department salary using ORDER BY:
SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

-- Calculate rolling minimum salary for each department:
SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) as rolling_min
FROM employees;

--- --- RANK() Function ---

-- Rank employees within each department based on salary and overall salary rank:
SELECT 
    emp_no, 
    department, 
    salary, 
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank
FROM employees ORDER BY overall_salary_rank;

--- --- DENSE_RANK & ROW_NUMBER ---

-- Use ROW_NUMBER(), RANK(), and DENSE_RANK() to compare employee rankings:
SELECT 
    emp_no, 
    department, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) as dept_row_number,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_rank,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

--- --- NTILE QUARTILE ---

-- Distribute employees into salary quartiles (4 quartiles) within each department:
SELECT 
    emp_no, 
    department, 
    salary,
    NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
    NTILE(9) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees;

--- --- FIRST_VALUE ---

-- Retrieve the first employee (highest salary) in each department and overall:
SELECT 
    emp_no, 
    department, 
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall
FROM employees;

--- --- LAG Function ---

-- Find the difference in salary compared to the previous employee (by salary order):
SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;

-- Find the salary difference within each department compared to the previous employee:
SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_diff
FROM employees;
