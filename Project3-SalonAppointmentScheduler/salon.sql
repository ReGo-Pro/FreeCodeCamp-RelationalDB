create database salon;

create table customers (
	customer_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	phone VARCHAR(255) UNIQUE NOT NULL
);

create table appointments (
	appointment_id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	service_id INt NOT NULL,
	time VARCHAR(255),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (service_id) REFERENCES services(service_id)
);
