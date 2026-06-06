USE employee_db;

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