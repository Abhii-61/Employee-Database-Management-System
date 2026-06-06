USE employee_db;

-- Insert Departments

INSERT INTO departments(dept_name)
VALUES
('HR'),
('IT'),
('Finance'),
('Marketing');

-- Insert Employees

INSERT INTO employees
(emp_name,email,salary,hire_date,dept_id)
VALUES
('Rahul Sharma','rahul@gmail.com',50000,'2024-01-15',2),
('Priya Singh','priya@gmail.com',45000,'2024-02-10',1),
('Amit Kumar','amit@gmail.com',60000,'2024-03-20',3),
('Sneha Gupta','sneha@gmail.com',55000,'2024-04-05',2);