-- 1
DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
    SELECT first_name, last_name 
    FROM employees 
    WHERE salary > 35000 
    ORDER BY first_name, last_name, employee_id;
END $$

DELIMITER ;
DROP PROCEDURE IF EXISTS usp_get_employees_salary_above_35000;

call usp_get_employees_salary_above_35000();

-- 2
DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above(IN salary_limit DECIMAL(10, 4))
begin 
    SELECT first_name, last_name 
    FROM employees 
    WHERE salary >= salary_limit 
    ORDER BY first_name, last_name, employee_id;
END $$

DELIMITER ;
-- 3
DELIMITER $$

CREATE PROCEDURE usp_get_towns_starting_with(IN starting_buchstabe VARCHAR(255))
BEGIN
    SELECT name 
    FROM towns
    WHERE name LIKE CONCAT(starting_buchstabe, '%')
    ORDER BY name;
END$$

DELIMITER ;

-- 5
DELIMITER $$
create function ufn_get_salary_level (salary_employee decimal(19,4))
returns varchar (20)
return(
case
when salary_employee < 30000 then 'Low'
when salary_employee <= 50000 then 'Average'
else 'High'
END
)$$

DELIMITER ;

-- 6
DELIMITER $$

CREATE PROCEDURE usp_get_employees_by_salary_level(level_salary VARCHAR(50))
BEGIN
    IF level_salary = 'Low' THEN
        SELECT first_name, last_name
        FROM employees
        WHERE salary < 30000
        ORDER BY first_name DESC, last_name DESC;
    ELSEIF level_salary = 'Medium' THEN
        SELECT first_name, last_name
        FROM employees
        WHERE salary BETWEEN 30000 AND 50000
        ORDER BY first_name DESC, last_name DESC;
    ELSEIF level_salary = 'High' THEN
        SELECT first_name, last_name
        FROM employees
        WHERE salary > 50000
        ORDER BY first_name DESC, last_name DESC;
    END IF;
END $$

DELIMITER ;


