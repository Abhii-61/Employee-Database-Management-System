-- =====================================================
-- Employee Database Management System
-- Technologies: SQL, MySQL
-- =====================================================

-- =====================================================
-- STEP 1: Create Database
-- =====================================================

CREATE DATABASE employee_db;

-- Select the database for further operations
USE employee_db;


-- =====================================================
-- STEP 2: Create Departments Table
-- Stores department information
-- =====================================================

CREATE TABLE departments(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);

-- View table structure
DESC departments;


-- =====================================================
-- STEP 3: Create Employees Table
-- Stores employee details and department mapping
-- =====================================================

CREATE TABLE employees(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2),
    hire_date DATE,
    dept_id INT,

    -- Foreign Key Relationship
    FOREIGN KEY(dept_id)
    REFERENCES departments(dept_id)
);

-- View table structure
DESC employees;


-- =====================================================
-- STEP 4: Create Salary Audit Table
-- Used for tracking salary changes through trigger
-- =====================================================

CREATE TABLE salary_audit(
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- View table structure
DESC salary_audit;


-- =====================================================
-- STEP 5: Insert Department Records
-- =====================================================

INSERT INTO departments(dept_name)
VALUES
('HR'),
('IT'),
('Finance'),
('Marketing');

-- Verify inserted department records
SELECT * FROM departments;


-- =====================================================
-- STEP 6: Insert Employee Records
-- =====================================================

INSERT INTO employees
(emp_name,email,salary,hire_date,dept_id)
VALUES
('Rahul Sharma','rahul@gmail.com',50000,'2024-01-15',2),
('Priya Singh','priya@gmail.com',45000,'2024-02-10',1),
('Amit Kumar','amit@gmail.com',60000,'2024-03-20',3),
('Sneha Gupta','sneha@gmail.com',55000,'2024-04-05',2);

-- Verify inserted employee records
SELECT * FROM employees;


-- =====================================================
-- STEP 7: INNER JOIN
-- Display employee details along with department name
-- =====================================================

SELECT
e.emp_id,
e.emp_name,
d.dept_name,
e.salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id;


-- =====================================================
-- STEP 8: GROUP BY Query
-- Count employees department-wise
-- =====================================================

SELECT
d.dept_name,
COUNT(*) AS total_employees
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;


-- =====================================================
-- STEP 9: Highest Paid Employee
-- =====================================================

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;


-- =====================================================
-- STEP 10: Create View
-- Simplified employee reporting view
-- =====================================================

CREATE VIEW employee_details AS

SELECT
e.emp_id,
e.emp_name,
d.dept_name,
e.salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id;

-- View data from created view
SELECT * FROM employee_details;


-- =====================================================
-- STEP 11: Stored Procedure
-- Procedure to add a new employee
-- =====================================================

DELIMITER $$

CREATE PROCEDURE add_employee(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_salary DECIMAL(10,2),
    IN p_hire_date DATE,
    IN p_dept_id INT
)
BEGIN

    INSERT INTO employees(
        emp_name,
        email,
        salary,
        hire_date,
        dept_id
    )
    VALUES(
        p_name,
        p_email,
        p_salary,
        p_hire_date,
        p_dept_id
    );

END $$

DELIMITER ;

-- Verify procedure creation
SHOW PROCEDURE STATUS
WHERE Db='employee_db';


-- =====================================================
-- STEP 12: Execute Stored Procedure
-- =====================================================

CALL add_employee(
    'Rohit Verma',
    'rohit@gmail.com',
    65000,
    '2025-01-10',
    2
);

-- Verify inserted employee
SELECT * FROM employees;


-- =====================================================
-- STEP 13: User Defined Function
-- Calculate annual salary from monthly salary
-- =====================================================

DELIMITER $$

CREATE FUNCTION annual_salary(
    monthly_salary DECIMAL(10,2)
)
RETURNS DECIMAL(12,2)

DETERMINISTIC

BEGIN

    RETURN monthly_salary * 12;

END $$

DELIMITER ;


-- Test function output
SELECT
    emp_name,
    salary,
    annual_salary(salary) AS annual_salary
FROM employees;


-- =====================================================
-- STEP 14: Trigger
-- Automatically log salary changes
-- =====================================================

DELIMITER $$

CREATE TRIGGER salary_update_log

AFTER UPDATE

ON employees

FOR EACH ROW

BEGIN

    IF OLD.salary <> NEW.salary THEN

        INSERT INTO salary_audit(
            emp_id,
            old_salary,
            new_salary
        )
        VALUES(
            OLD.emp_id,
            OLD.salary,
            NEW.salary
        );

    END IF;

END $$

DELIMITER ;

-- Verify trigger creation
SHOW TRIGGERS;


-- =====================================================
-- STEP 15: Test Trigger
-- Update salary and generate audit log
-- =====================================================

UPDATE employees
SET salary = 70000
WHERE emp_id = 1;

-- Check audit records
SELECT * FROM salary_audit;


-- =====================================================
-- STEP 16: Department Wise Average Salary
-- =====================================================

SELECT
    d.dept_name,
    ROUND(AVG(e.salary),2) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;


-- =====================================================
-- STEP 17: Highest Salary By Department
-- =====================================================

SELECT
    d.dept_name,
    MAX(e.salary) AS highest_salary
FROM employees e
JOIN departments d
ON e.dept_id=d.dept_id
GROUP BY d.dept_name;


-- =====================================================
-- STEP 18: Subquery
-- Employees earning above average salary
-- =====================================================

SELECT
    emp_name,
    salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
);


-- =====================================================
-- END OF PROJECT
-- Concepts Covered:
-- ✔ Database Design
-- ✔ Primary Key
-- ✔ Foreign Key
-- ✔ Constraints
-- ✔ Joins
-- ✔ Group By
-- ✔ Views
-- ✔ Stored Procedures
-- ✔ Functions
-- ✔ Triggers
-- ✔ Subqueries
-- ✔ Aggregate Functions
-- =====================================================