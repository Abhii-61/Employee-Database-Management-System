-- =====================================================
-- Database and Table Creation
-- =====================================================

CREATE DATABASE employee_db;

USE employee_db;

-- Departments Table
CREATE TABLE departments(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL
);

-- Employees Table
CREATE TABLE employees(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2),
    hire_date DATE,
    dept_id INT,

    FOREIGN KEY(dept_id)
    REFERENCES departments(dept_id)
);

-- Salary Audit Table
CREATE TABLE salary_audit(
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);