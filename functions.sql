USE employee_db;

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