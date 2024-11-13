drop database if exists inventory_management;
create database inventory_management;
use inventory_management;

CREATE TABLE Store (
	name VARCHAR(64) NOT NULL,
    street VARCHAR(64) NOT NULL,
    city VARCHAR(64) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zipcode INT NOT NULL,
    
    PRIMARY KEY (name, street, city, state, zipcode)
);

CREATE TABLE Employee (
	employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    role VARCHAR(64) NOT NULL,
    
    store_name VARCHAR(64),
	store_street VARCHAR(64),
	store_city VARCHAR(64),
	store_state VARCHAR(2),
	store_zipcode INT, 
    
    FOREIGN KEY (store_name, store_street, store_city, store_state, store_zipcode)
		REFERENCES Store (name, street, city, state, zipcode)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Customer (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
	street VARCHAR(64) NOT NULL,
    city VARCHAR(64) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zipcode INT NOT NULL
);

CREATE TABLE Transaction (
	transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    total_amount FLOAT NOT NULL,
    date DATE NOT NULL,
    payment_method ENUM('credit', 'debit', 'cash', 'check', 'ebt'),
    
    customer_id INT,
    
     FOREIGN KEY (customer_id)
		REFERENCES Customer (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Product (
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(64) NOT NULL,
    description VARCHAR(128) NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE CustomerStore (
	customer_id INT NOT NULL,
    store_name VARCHAR(64) NOT NULL,
	store_street VARCHAR(64) NOT NULL,
	store_city VARCHAR(64) NOT NULL,
	store_state VARCHAR(2) NOT NULL,
	store_zipcode INT NOT NULL, 
    
    PRIMARY KEY (customer_id, store_name, store_street, store_state, store_zipcode),
    
    FOREIGN KEY (store_name, store_street, store_city, store_state, store_zipcode)
		REFERENCES Store (name, street, city, state, zipcode)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
	 FOREIGN KEY (customer_id)
		REFERENCES Customer (customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE TransactionProduct (
	transaction_id INT NOT NULL,
    product_id  INT NOT NULL,
    
    PRIMARY KEY (transaction_id, product_id),
    
    FOREIGN KEY (transaction_id)
		REFERENCES Transaction(transaction_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
	FOREIGN KEY (product_id)
		REFERENCES Product(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ProductStore (
	product_id INT NOT NULL,
    store_name VARCHAR(64) NOT NULL,
	store_street VARCHAR(64) NOT NULL,
	store_city VARCHAR(64) NOT NULL,
	store_state VARCHAR(2) NOT NULL,
	store_zipcode INT NOT NULL, 
    
    product_quantity INT NOT NULL,
    
    PRIMARY KEY (product_id, store_name, store_street, store_state, store_zipcode),
    
    FOREIGN KEY (store_name, store_street, store_city, store_state, store_zipcode)
		REFERENCES Store (name, street, city, state, zipcode)
        ON DELETE CASCADE ON UPDATE CASCADE,
        
	 FOREIGN KEY (product_id)
		REFERENCES Product (product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

DROP PROCEDURE IF EXISTS add_customer;

-- Procedure to Add a Customer
DELIMITER //

CREATE PROCEDURE add_customer(
    IN p_first_name VARCHAR(64),
    IN p_last_name VARCHAR(64),
    IN p_email VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT
)
BEGIN
    INSERT INTO Customer (first_name, last_name, email, street, city, state, zipcode)
    VALUES (p_first_name, p_last_name, p_email, p_street, p_city, p_state, p_zipcode);
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS delete_customer;
-- Procedure to Delete a Customer
DELIMITER //

CREATE PROCEDURE delete_customer(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM Customer
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS add_store;
-- Procedure to Add a Store
DELIMITER //

CREATE PROCEDURE add_store(
    IN p_name VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT
)
BEGIN
    INSERT INTO Store (name, street, city, state, zipcode)
    VALUES (p_name, p_street, p_city, p_state, p_zipcode);
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS delete_store;
-- Procedure to Delete a Store
DELIMITER //

CREATE PROCEDURE delete_store(
    IN p_name VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT
)
BEGIN
    DELETE FROM Store
    WHERE name = p_name
    AND street = p_street
    AND city = p_city
    AND state = p_state
    AND zipcode = p_zipcode;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS add_employee;
-- Procedure to Add an Employee
DELIMITER //

CREATE PROCEDURE add_employee(
    IN p_first_name VARCHAR(64),
    IN p_last_name VARCHAR(64),
    IN p_role VARCHAR(64),
    IN p_store_name VARCHAR(64),
    IN p_store_street VARCHAR(64),
    IN p_store_city VARCHAR(64),
    IN p_store_state VARCHAR(2),
    IN p_store_zipcode INT
)
BEGIN
    INSERT INTO Employee (first_name, last_name, role, store_name, store_street, store_city, store_state, store_zipcode)
    VALUES (p_first_name, p_last_name, p_role, p_store_name, p_store_street, p_store_city, p_store_state, p_store_zipcode);
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS delete_employee;
-- Procedure to Delete an Employee
DELIMITER //

CREATE PROCEDURE delete_employee(
    IN p_employee_id INT
)
BEGIN
    DELETE FROM Employee
    WHERE employee_id = p_employee_id;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS add_transaction;
-- Procedure to Add a Transaction
DELIMITER //

CREATE PROCEDURE add_transaction(
    IN p_customer_id INT,
    IN p_total_amount FLOAT,
    IN p_date DATE,
    IN p_payment_method ENUM('credit', 'debit', 'cash', 'check', 'ebt')
)
BEGIN
    INSERT INTO Transaction (customer_id, total_amount, date, payment_method)
    VALUES (p_customer_id, p_total_amount, p_date, p_payment_method);
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS delete_transaction;
-- Procedure to Delete a Transaction
DELIMITER //

CREATE PROCEDURE delete_transaction(
    IN p_transaction_id INT
)
BEGIN
    DELETE FROM Transaction
    WHERE transaction_id = p_transaction_id;
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS add_product;
-- Procedure to Add a Product
DELIMITER //

CREATE PROCEDURE add_product(
    IN p_product_name VARCHAR(64),
    IN p_description VARCHAR(128),
    IN p_price FLOAT
)
BEGIN
    INSERT INTO Product (product_name, description, price)
    VALUES (p_product_name, p_description, p_price);
END //

DELIMITER ;


DROP PROCEDURE IF EXISTS delete_product;
-- Procedure to Delete a Product
DELIMITER //

CREATE PROCEDURE delete_product(
    IN p_product_id INT
)
BEGIN
    DELETE FROM Product
    WHERE product_id = p_product_id;
END //

DELIMITER ;

INSERT INTO Store (name, street, city, state, zipcode) VALUES
('TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107),
('GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001),
('BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601),
('ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001),
('FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101),
('HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201),
('PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001),
('ToyLand', '5050 Fun Dr', 'Phoenix', 'AZ', 85001),
('GourmetFood', '6060 Food Way', 'Boston', 'MA', 02108),
('SportsShop', '7070 Sport Ave', 'Chicago', 'IL', 60611),
('TechWorld', '124 Tech Blvd', 'San Francisco', 'CA', 94108),
('GroceryMart', '457 Market St', 'Los Angeles', 'CA', 90002),
('BestBooks', '790 Book Ave', 'Chicago', 'IL', 60602);

INSERT INTO Employee (first_name, last_name, role, store_name, store_street, store_city, store_state, store_zipcode) VALUES
('John', 'Doe', 'Manager', 'TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107),
('Jane', 'Smith', 'Cashier', 'GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001),
('Mark', 'Johnson', 'Stock Clerk', 'BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601),
('Emily', 'Davis', 'Manager', 'ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001),
('Chris', 'Martinez', 'Cashier', 'FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101),
('David', 'Perez', 'Manager', 'HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201),
('Linda', 'Brown', 'Stock Clerk', 'PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001);

INSERT INTO Customer (first_name, last_name, email, street, city, state, zipcode) VALUES
('Alice', 'Williams', 'alice.williams@email.com', '321 Oak St', 'San Francisco', 'CA', 94105),
('Bob', 'Taylor', 'bob.taylor@email.com', '123 Elm St', 'Los Angeles', 'CA', 90002),
('Charlie', 'Brown', 'charlie.brown@email.com', '456 Pine St', 'Chicago', 'IL', 60602),
('Diana', 'Wilson', 'diana.wilson@email.com', '789 Cedar St', 'New York', 'NY', 10002),
('Ethan', 'Moore', 'ethan.moore@email.com', '1010 Birch Ave', 'Miami', 'FL', 33110),
('Frank', 'Taylor', 'frank.taylor@email.com', '1112 Oak St', 'Dallas', 'TX', 75202),
('Grace', 'Garcia', 'grace.garcia@email.com', '1314 Maple St', 'Phoenix', 'AZ', 85002);

INSERT INTO Product (product_name, description, price) VALUES
('Laptop', 'High performance laptop', 999.99),
('Smartphone', 'Latest model smartphone', 699.99),
('Novel', 'Best-selling fiction novel', 19.99),
('Washing Machine', 'Energy-efficient washing machine', 499.99),
('Air Conditioner', 'Cool down your space with this AC', 299.99),
('Gaming Console', 'Next-gen gaming console', 399.99),
('Refrigerator', 'Stainless steel fridge', 799.99),
('TV', '4K Ultra HD Smart TV', 599.99),
('Coffee Maker', 'Brews perfect coffee every time', 49.99);

INSERT INTO Transaction (total_amount, date, payment_method, customer_id) VALUES
(999.99, '2024-11-10', 'credit', 1),
(699.99, '2024-11-11', 'debit', 2),
(19.99, '2024-11-12', 'cash', 3),
(499.99, '2024-11-13', 'check', 4),
(299.99, '2024-11-14', 'ebt', 5),
(799.99, '2024-11-15', 'credit', 6),
(599.99, '2024-11-16', 'debit', 7);

INSERT INTO CustomerStore (customer_id, store_name, store_street, store_city, store_state, store_zipcode) VALUES
(1, 'TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107),
(2, 'GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001),
(3, 'BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601),
(4, 'ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001),
(5, 'FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101),
(6, 'HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201),
(7, 'PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001);

INSERT INTO TransactionProduct (transaction_id, product_id) VALUES
(1, 1),  
(2, 2),  
(3, 3),  
(4, 4),  
(5, 5), 
(6, 6),  
(7, 7);

INSERT INTO ProductStore (product_id, store_name, store_street, store_city, store_state, store_zipcode, product_quantity) VALUES
(1, 'TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107, 100),
(2, 'GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001, 200),
(3, 'BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601, 300),
(4, 'ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001, 150),
(5, 'FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101, 50),
(6, 'HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201, 200),
(7, 'PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001, 250);


