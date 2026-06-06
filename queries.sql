USE employee_db;

-- Employee Details with Department

SELECT
e.emp_id,
e.emp_name,
d.dept_name,
e.salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id;

-- Department Wise Employee Count

SELECT
d.dept_name,
COUNT(*) AS total_employees
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;

-- Highest Paid Employee

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Department Wise Average Salary

SELECT
d.dept_name,
ROUND(AVG(e.salary),2) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;

-- Highest Salary By Department

SELECT
d.dept_name,
MAX(e.salary) AS highest_salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;

-- Employees Earning Above Average Salary

SELECT
emp_name,
salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);

-- Test Stored Procedure

CALL add_employee(
    'Rohit Verma',
    'rohit@gmail.com',
    65000,
    '2025-01-10',
    2
);

-- Test Function

SELECT
emp_name,
salary,
annual_salary(salary) AS annual_salary
FROM employees;

-- Test Trigger

UPDATE employees
SET salary = 70000
WHERE emp_id = 1;

SELECT * FROM salary_audit;

SELECT * FROM employee_details;