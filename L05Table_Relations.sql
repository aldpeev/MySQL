-- 1
create database soft_uni_people;
use soft_uni_people;

create table people (
person_id int,
first_name varchar(50),
salary float,
passport_id int
);

create table passports(
passport_id int,
passport_number varchar(50)
);

insert into people (person_id, first_name, salary, passport_id )
values 
(1, "Roberto", 43300.00, 102),
(2, "Tom", 56100.00, 103),
(3, "Yana", 60200.00, 101); 

 select * from people;
 
 insert into passports (passport_id, passport_number) 
 values
 (101, "N34FG21B"),
 (102, "K65LO4R7"),
 (103, "ZE657QP2");
 
 select * from passports;
 
 alter table people
 add constraint pk_person_id primary key (person_id);
 
 alter table passports
 add constraint pk_passport_id primary key (passport_id);
 
 alter table people
 add constraint fk_people_passports 
 foreign key (passport_id) references passports (passport_id);
 
 -- 2
 create database cars;
 use cars;

create table manufacturers (
manufacturer_id int primary key auto_increment not null,
name varchar (50) not null,
established_on date not null
 );

create table models (
model_id int primary key auto_increment,
name varchar (50) not null,
manufacturer_id int,
constraint fk_models_manufacturers foreign key (manufacturer_id) references manufacturers(manufacturer_id)
 );

insert into manufacturers (manufacturer_id, name, established_on )
values 
(1, "BMW", '1916-03-01'), 
(2, "Tesla", '2003-01-01'),
(3, "Lada",'1966-06-01');


insert into models (model_id,name, manufacturer_id) 
values 
(101,"X1",1),
(102,"i6",1),
(103,"Model S",2),
(104,"Model X",2),
(105,"Model 3",2),
(106,"Nova",3);

-- 3
create database soft_uni_people;
use soft_uni_people;

create table students(
student_id int primary key auto_increment,
name varchar(50) not null
);

create table exams (
exam_id int primary key auto_increment,
name varchar(50) not null
);

create table students_exams (
student_id int,
exam_id int,
constraint pk_studebnts_exams primary key (student_id, exam_id),
constraint fk_stundet_id_students foreign key (student_id) references students(student_id),
constraint fk_exam_id_exams foreign key (exam_id) references exams(exam_id)
 );
 
 insert into students (name) values 
 ("Mila"),
 ("Toni"),
 ("Ron");

insert into exams (exam_id, name) values
(101, "Spring MVC"),
(102, "Neo4j"),
(103, "Oracle 11g");

insert into students_exams values
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103);

select * from exams;

-- 5
create database task5;
use task5;

create table cities (
city_id int primary key auto_increment,
name varchar(50) not null
);

create table customers (
customer_id int primary key auto_increment,
name varchar(50) not null,
bithday date,
city_id int,
constraint fk_customers_cities foreign key (city_id) references cities(city_id)
);

create table orders (
order_id int primary key auto_increment,
customer_id int,
constraint fk_orders_customers foreign key (customer_id) references customers(customer_id)
);

create table item_types(
item_type_id int primary key auto_increment,
name varchar(50)
);

create table items(
item_id int primary key auto_increment,
name varchar(50) not null,
item_type_id int,
constraint fk_items_item_type foreign key (item_type_id) references item_types(item_type_id)
);

create table order_items(
order_id int,
item_id int,
constraint pk_order_id_item_id primary key (order_id, item_id),
constraint fk_order_items_orders foreign key (order_id) references orders(order_id),
constraint fk_order_items_items foreign key (item_id) references items(item_id)
);


 
 
 
 
 