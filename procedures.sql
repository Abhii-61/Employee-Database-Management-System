USE employee_db;

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