
CREATE TRIGGER update_employee_count_after_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE departments
    SET employee_count = employee_count + 1
    WHERE department_id = NEW.department_id;
END;


CREATE TRIGGER update_employee_count_after_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments
    SET employee_count = employee_count - 1
    WHERE department_id = OLD.department_id;
END;
