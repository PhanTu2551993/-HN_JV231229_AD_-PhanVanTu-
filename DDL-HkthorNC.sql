create database if not exists QUANLYBANHANG;
use QUANLYBANHANG;

create table if not exists customers (
                           customer_id varchar(4) primary key,
                           name varchar(100) not null,
                           email varchar(100) unique not null,
                           phone varchar(25) unique not null,
                           address varchar(255) not null
);

create table if not exists products (
                          product_id varchar(4) primary key,
                          name varchar(255) not null,
                          description text,
                          price double,
                          status bit default 1
);
create table if not exists orders (
                        order_id varchar(4) primary key,
                        customer_id varchar(4),
                        order_date date,
                        total_amount double
);

create table if not exists orders_details (
                                order_id varchar(4),
                                product_id varchar(4),
                                quantity int(1),
                                price double,
                                primary key (order_id, product_id)
);


alter table orders
add foreign key (customer_id) references customers(customer_id);

alter table orders_details
add   foreign key (order_id) references orders(order_id),
add   foreign key (product_id) references products(product_id);
