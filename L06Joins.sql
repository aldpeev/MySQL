-- 1
use soft_uni;
select employee_id, job_title, addresses.address_id, addresses.address_text
from employees
join addresses on employees.address_id = addresses.address_id
order by addresses.address_id
limit 5;

-- 2
select first_name, last_name, towns.name as 'town',  addresses.address_text
from employees
join addresses on employees.address_id = addresses.address_id
join towns on addresses.town_id = towns.town_id
order by first_name, last_name
limit 5;

-- 3
select employee_id, first_name, last_name, departments.name as 'department_name'
from employees
join departments on employees.department_id = departments.department_id
where departments.name = 'Sales'
order by employee_id desc
limit 5;

-- 4
select employee_id, first_name, salary, departments.name as 'department_name'
from employees
join departments on employees.department_id = departments.department_id
where salary > 15000
order by departments.department_id desc
limit 5;

-- 5
select e.employee_id, e.first_name
from employees as e
left join employees_projects as ep on e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;

-- 6
select e.first_name, e.last_name, e.hire_date, d.name as 'dept_name'
from employees as e
join departments as d on e.department_id = d.department_id
where e.hire_date > '1999-01-01' and d.name in ('Sales', 'Finance')
order by e.hire_date;

-- 7
select e.employee_id, e.first_name, p.name as 'project_name'
from employees as e
join employees_projects as ep on e.employee_id = ep.employee_id
join projects as p on ep.project_id = p.project_id
where date(p.start_date) > '2002-08-13' and end_date is null
order by e.first_name,p.name
limit 5;

-- 8
select e.employee_id, e.first_name, if(year(p.start_date) >= 2005, null, p.name) as 'project_name'
from employees as e
join employees_projects as ep on e.employee_id = ep.employee_id
join projects as p on ep.project_id = p.project_id
where e.employee_id = 24
order by p.name;



