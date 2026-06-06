USE employee_db;

-- Employee Reporting View

CREATE VIEW employee_details AS

SELECT
e.emp_id,
e.emp_name,
d.dept_name,
e.salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id;