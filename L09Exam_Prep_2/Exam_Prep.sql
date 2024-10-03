create database online_store;
use online_store;

-- 1
create table reviews (
id int primary key auto_increment,
content text,
rating decimal (10,2) not null,
picture_url varchar(80) not null,
published_at datetime not null
);

create table brands (
id int primary key auto_increment,
name varchar(40) not null unique
);

create table categories (
id int primary key auto_increment,
name varchar(40) not null unique
);

create table products (
id int primary key auto_increment,
name varchar(40) not null,
price decimal (19,2) not null,
quantity_in_stock int,
description text,
brand_id int not null,
category_id int not null,
review_id int,
constraint fk_products_brands foreign key (brand_id) references brands(id),
constraint fk_products_categories foreign key (category_id) references categories(id),
constraint fk_products_reviews foreign key (review_id) references reviews(id)
);

create table customers (
id int primary key auto_increment,
first_name varchar(20) not null,
last_name varchar(20) not null,
phone varchar(30) not null unique,
address varchar(60) not null,
discount_card bit(1) not null default 0
);

create table orders (
id int primary key auto_increment,
order_datetime datetime not null,
customer_id int not null,
constraint fk_orders_customers foreign key (customer_id) references customers(id)
);

create table orders_products (
order_id int, 
product_id int,
constraint fk_orders_products_orders foreign key (order_id) references orders(id),
constraint fk_orders_products_products foreign key (product_id) references products(id)
);

-- 2
insert into reviews (content, picture_url, published_at, rating)
(
select substring(description, 1, 15), reverse(name), '2010-10-10', price / 8
from products
where id >= 5
);

-- 3
UPDATE products
SET quantity_in_stock = quantity_in_stock - 5
WHERE quantity_in_stock >= 60 and quantity_in_stock <= 70;

-- 4
set sql_safe_updates = 0;
delete customers
from customers
left join orders on customers.id = orders.customer_id
where orders.customer_id is null;

-- 5
select id, name 
from categories
order by name desc;

-- 6
select id, brand_id, name, quantity_in_stock
from products
where price > 1000 and quantity_in_stock < 30
order by quantity_in_stock, id;

-- 7
select id, content, rating, picture_url, published_at
from reviews
where content LIKE 'My%' AND LENGTH(content) > 61
order by rating desc;

-- 8
select concat(first_name, ' ', last_name) as 'full_name', address, orders.order_datetime
from customers
join orders on orders.customer_id = customers.id
where order_datetime <= '2018-12-31'
order by full_name desc;

-- 9
select count(*) as 'items_count', categories.name, sum(products.quantity_in_stock) as 'total_quantity'
from categories
join products on products.category_id = categories.id
group by categories.name
order by items_count desc, total_quantity
limit 5;

-- 10
DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30)) 
RETURNS INT
DETERMINISTIC
BEGIN    
    RETURN (
        SELECT count(products.id)
        FROM customers
        JOIN orders ON customers.id = orders.customer_id
        JOIN orders_products ON orders_products.order_id = orders.id
        JOIN products ON products.id = orders_products.product_id
        where customers.first_name = name
    );
END $$
DELIMITER ;

-- 11
DELIMITER $$
CREATE PROCEDURE udp_reduce_price (IN category_name  VARCHAR(50))
BEGIN
    UPDATE products
    JOIN categories ON products.category_id = categories.id
    JOIN reviews ON products.review_id = reviews.id
    SET products.price = products.price * 0.7
    WHERE reviews.rating < 4 and categories.name = category_name;
END$$
DELIMITER ;





