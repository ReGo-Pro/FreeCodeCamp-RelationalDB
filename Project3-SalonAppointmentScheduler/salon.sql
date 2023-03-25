create database salon;

create table customers (
	customer_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	phone VARCHAR(255) UNIQUE NOT NULL
);
