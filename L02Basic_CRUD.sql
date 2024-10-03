-- 1
select * from departments order by department_id;

-- 2
select name from departments order by department_id;

-- 3
select first_name, last_name, salary from employees order by employee_id;

-- 4
select first_name, middle_name, last_name from employees order by employee_id;

-- 5 
select  concat (first_name, '.', last_name, '@softuni.bg') as full_email_address from employees;

-- 6
select distinct salary as Salary from employees;

-- 7 
select * from employees where job_title = 'Sales Representative' order by employee_id;

-- 8 
select first_name, last_name, job_title from employees where salary between 20000 and 30000 order by employee_id;

-- 9 
select concat_ws(' ', first_name, middle_name, last_name) as 'Full name' from employees where salary = 25000 or salary = 14000 or salary = 12500 or salary = 23600;

-- 10
select first_name, last_name from employees where manager_id is null;

-- 11
select first_name, last_name, salary from employees where salary > 50000 order by salary desc;

-- 12
select first_name, last_name from employees order by salary desc limit 5;

-- 13
select first_name, last_name from employees where department_id != 4;

-- 14
select * from employees order by salary desc, first_name, last_name desc, middle_name, employee_id;

-- 15
create view v_employees_salaries as select first_name, last_name, salary from employees;

-- 16
drop view v_employees_job_titles;
CREATE VIEW v_employees_job_titles AS SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name, job_title FROM employees;

-- 17
select distinct job_title from employees order by job_title;

-- 18 
select * from projects order by start_date, name, project_id limit 10;

-- 19
select first_name, last_name, hire_date from employees order by hire_date desc limit 7;
