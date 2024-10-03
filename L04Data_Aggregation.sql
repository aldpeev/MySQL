-- 1
select count(*) as "count" from wizzard_deposits;

-- 2
select max(magic_wand_size) as 'longest_magic_wand' from wizzard_deposits;

-- 3
select deposit_group, max(magic_wand_size) as 'longest_magic_wand'
from wizzard_deposits
group by deposit_group
order by magic_wand_size desc, deposit_group asc;

-- 4
select deposit_group
from wizzard_deposits
group by deposit_group
order by avg(magic_wand_size) limit 1;

-- 5
select deposit_group, sum(deposit_amount) as 'total_sum'
from wizzard_deposits
group by deposit_group
order by total_sum;

-- 6
select deposit_group, sum(deposit_amount) as 'total_sum'
from wizzard_deposits
where magic_wand_creator = "Ollivander family"
group by deposit_group
order by deposit_group;

-- 7
select deposit_group, sum(deposit_amount) as 'total_sum' 
from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having total_sum < 150000
order by total_sum desc;

-- 8
select deposit_group, magic_wand_creator, min(deposit_charge) as "min_deposit_charge"
from wizzard_deposits
group by deposit_group, magic_wand_creator
order by magic_wand_creator, deposit_group;

-- 9
select case
when age between 0 and 10 then '[0-10]'
when age between 11 and 20 then '[11-20]'
when age between 21 and 30 then '[21-30]'
when age between 31 and 40 then '[31-40]'
when age between 41 and 50 then '[41-50]'
when age between 51 and 60 then '[51-60]'
else '[61+]'
end as "age_group", count(first_name) as 'wizzard_count'
from wizzard_deposits
group by age_group;

-- 10
select substring(first_name,1,1) as "first_letter"
from wizzard_deposits
where deposit_group = "Troll Chest"
group by first_letter
order by first_letter;






