-- 0
create database minions;
use minions;

-- 1
create table minions (
id int primary key auto_increment,
 name varchar(50),
 age int
 );
 
 create table towns(
 town_id int primary key auto_increment,
 name varchar(50)
 );
 
 -- 2
alter table minions add town_id int;
alter table minions add constraint fk_minions_towns
foreign key minions(town_id) references towns(town_id);

-- 3 
insert into towns (town_id,name)
values
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');

insert into minions (id, name, age, town_id)
values 
(1,'Kevin', 22, 1),
(2,'Bob', 15, 3),
(3,'Steward', null, 2);

-- 4
truncate table minions;

-- 5 
drop table minions;
drop table towns;

-- 6 
create table people(
id int auto_increment primary key,
 name varchar(200) not null,
 picture blob,
 height double (10,2),
 weight double (10,2),
 gender char(1) not null,
 birthdate date not null,
 biography text
 );
 
 insert into people(id, name, gender, birthdate) values 
 (1, 'test1', 'm', '1985-02-07'),
 (2, 'test2', 'm', '1985-02-07'),
 (3, 'test3', 'm', '1985-02-07'),
 (4, 'test4', 'm', '1985-02-07'),
 (5, 'test5', 'm', '1985-02-07');
 
-- 7
create table users (
id int primary key auto_increment,
 username varchar(30) unique not null,
 password varchar(26) not null,
 profile_picture blob,
 last_login_time date,
 is_deleted boolean
 );
 
 insert into users (id, username, password) values 
(1, 'test1', '12345'),
(2, 'test2', '12345'),
(3, 'test3', '12345'),
(4, 'test4', '12345'),
(5, 'test5', '12345');

-- 8
alter table users
drop primary key,
add constraint pk_users2
primary key users(id, username);

-- 9
alter table users
change column last_login_time last_login_time datetime default now();
















