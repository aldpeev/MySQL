-- 1
select first_name, last_name from employees where first_name like  'Sa%';

select first_name, last_name from employees where substr(first_name, 1, 2) = "Sa" order by employee_id;

-- 2
select first_name, last_name from employees where lower(last_name) like "%ei%";

-- 3
select first_name from employees where department_id in (3,10) and hire_date between '1995-01-01' AND '2005-12-31' order by employee_id;

-- 4
select first_name, last_name from employees where job_title not like "%engineer%" order by employee_id;

-- 5
select name from towns where length(name) = 5 or length(name) = 6 order by name;

-- 6
select town_id, name from towns where substr(lower(name), 1, 1) in ('m', 'k', 'b', 'e') order by name; 

-- 7
select town_id, name from towns where substr(lower(name), 1, 1) not in ('r', 'b', 'd') order by name; 

-- 8
create view v_employees_hired_after_2000 as
select first_name, last_name from employees where hire_date > "2000-12-31";

-- 9
select first_name, last_name from employees where length(last_name) = 5;

-- 10
SELECT country_name, iso_code
FROM countries
WHERE LENGTH(LOWER(country_name)) - LENGTH(REPLACE(LOWER(country_name), 'a', '')) >= 3
ORDER BY iso_code;




