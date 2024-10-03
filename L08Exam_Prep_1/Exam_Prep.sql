create database restaurant_db;
use restaurant_db;

-- 1
create table products (
id int primary key auto_increment,
name varchar(30) not null unique, 
type varchar(30) not null, 
price decimal(10,2) not null
);

create table clients (
id int primary key auto_increment, 
first_name varchar(50) not null, 
last_name varchar(50) not null, 
birthdate date not null, 
card varchar(50), 
review text
);

create table tables (
id int primary key auto_increment,
floor int not null, 
reserved tinyint(1), 
capacity int not null
);

create table waiters(
id int primary key auto_increment,
first_name varchar(50) not null, 
last_name varchar(50) not null, 
email varchar(50) not null, 
phone varchar(50), 
salary decimal(10,2)
);

create table orders (
id int primary key auto_increment,
table_id int not null, 
waiter_id int not null, 
order_time time not null, 
payed_status tinyint(1),
constraint fk_orders_tables foreign key (table_id) references tables(id),
constraint fk_orders_waiters foreign key(waiter_id) references waiters(id)
);

create table orders_clients(
order_id int, 
client_id int,
constraint fk_orders_clients_orders foreign key (order_id) references orders(id),
constraint fk_orders_clients_clients foreign key (client_id) references clients(id)
);

create table orders_products(
order_id int, 
product_id int,
constraint fk_orders_products_orders foreign key (order_id) references orders(id),
constraint fk_orders_products_products foreign key (product_id) references products(id)
);

-- 2
insert into products (name, type, price)
(
select concat(last_name, ' specialty'), 'Cocktail', ceiling(salary * 0.01)
from waiters
where id > 6
);

-- 3
UPDATE orders
SET table_id = table_id - 1
WHERE id BETWEEN 12 AND 23;

-- 4
SET SQL_SAFE_UPDATES = 0;
DELETE waiters
FROM waiters
LEFT JOIN orders ON waiters.id = orders.waiter_id
WHERE orders.waiter_id IS NULL;

-- 5
select id, first_name, last_name, birthdate, card, review 
from clients
order by birthdate desc, id desc;

-- 6
select first_name, last_name, birthdate, review 
from clients
where card is null and birthdate BETWEEN '1978-01-01' AND '1993-12-31'
order by last_name desc, id
limit 5;

-- 7
select concat(last_name, first_name, CHAR_LENGTH(first_name),'Restaurant') as 'username',  REVERSE(SUBSTRING(email, 2, 12)) as 'password' from waiters 
where salary is not null
order by password desc;

-- 8 по-големи или равно на 5. Без равно дава 0 точки
select id, name, count(orders_products.product_id) as 'count'
from products
join orders_products on products.id = orders_products.product_id
group by products.id
having count >= 5
order by count desc, name;

-- 9
SELECT  tables.id AS table_id, tables.capacity, COUNT(orders.table_id) AS count_clients,
    CASE
        WHEN COUNT(orders.table_id) < tables.capacity THEN 'Free seats'
        WHEN COUNT(orders.table_id) = tables.capacity THEN 'Full'
        ELSE 'Extra seats'
    END AS availability
FROM tables
JOIN orders ON orders.table_id = tables.id
join orders_clients on orders_clients.order_id = orders.id
WHERE tables.floor = 1
GROUP BY tables.id
order by table_id desc;

-- 10
DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
    DECLARE first_name VARCHAR(50);
    DECLARE last_name VARCHAR(50);
    
    SET first_name = SUBSTRING_INDEX(full_name, ' ', 1);
    SET last_name = SUBSTRING_INDEX(full_name, ' ', -1);
    
    RETURN (
        SELECT SUM(products.price)
        FROM clients
        JOIN orders_clients ON clients.id = orders_clients.client_id
        JOIN orders ON orders_clients.order_id = orders.id
        JOIN orders_products ON orders.id = orders_products.order_id
        JOIN products ON orders_products.product_id = products.id
        WHERE clients.first_name = first_name
        AND clients.last_name = last_name
    );
END $$
DELIMITER ;

-- testing with example given in the document
SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';

-- 11
DELIMITER $$
CREATE PROCEDURE udp_happy_hour (IN type_input VARCHAR(50))
BEGIN
    -- Update the prices of products that meet the criteria
    UPDATE products
    SET price = price * 0.8
    WHERE type = type_input AND price >= 10.00;
END$$
DELIMITER ;

























