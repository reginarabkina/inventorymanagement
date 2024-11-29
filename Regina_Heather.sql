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
    
    product_quantity INT NOT NULL,
    
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
(599.99, '2024-11-16', 'debit', 7),
(499.99, '2024-12-13', 'debit', 7);

INSERT INTO CustomerStore (customer_id, store_name, store_street, store_city, store_state, store_zipcode) VALUES
(1, 'TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107),
(2, 'GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001),
(3, 'BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601),
(4, 'ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001),
(5, 'FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101),
(6, 'HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201),
(7, 'PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001);

INSERT INTO TransactionProduct (transaction_id, product_id, product_quantity) VALUES
(1, 1, 2),  
(2, 2, 3),  
(3, 3, 4),  
(4, 4, 1),  
(5, 5, 7), 
(6, 6, 2),  
(7, 7, 1);

INSERT INTO ProductStore (product_id, store_name, store_street, store_city, store_state, store_zipcode, product_quantity) VALUES
(1, 'TechWorld', '123 Tech Blvd', 'San Francisco', 'CA', 94107, 100),
(2, 'GroceryMart', '456 Market St', 'Los Angeles', 'CA', 90001, 200),
(3, 'BestBooks', '789 Book Ave', 'Chicago', 'IL', 60601, 300),
(4, 'ElectroShop', '1010 Circuit Rd', 'New York', 'NY', 10001, 150),
(5, 'FashionHub', '2020 Fashion St', 'Miami', 'FL', 33101, 50),
(6, 'HomeEssentials', '3030 Living Rd', 'Dallas', 'TX', 75201, 200),
(7, 'PetStore', '4040 Animal Ln', 'Houston', 'TX', 77001, 250);


-- ------------------------ READ ------------------------ --

-- Shows the quantity of each product available at each store location.
DROP PROCEDURE IF EXISTS CreateProductAvailabilityView;
DELIMITER //
CREATE PROCEDURE CreateProductAvailabilityView(IN ProductName VARCHAR(255))
BEGIN
       SELECT 
        ps.product_id,
        p.product_name,
        p.description,
        p.price,
        ps.store_name,
        ps.store_street,
        ps.store_city,
        ps.store_state,
        ps.store_zipcode,
        ps.product_quantity
    FROM 
        ProductStore ps
    JOIN 
        Product p ON ps.product_id = p.product_id
    WHERE 
        p.product_name LIKE CONCAT('%', IFNULL(ProductName, ''), '%');
END //
DELIMITER ;

-- Calculates the total inventory value at each store based on product prices and quantities.
DROP PROCEDURE IF EXISTS CreateStoreInventoryValueView;
DELIMITER //
CREATE PROCEDURE CreateStoreInventoryValueView()
BEGIN
	SELECT 
        ps.store_name,
        ps.store_street,
        ps.store_city,
        ps.store_state,
        ps.store_zipcode,
        SUM(p.price * ps.product_quantity) AS total_inventory_value
    FROM 
        ProductStore ps
    JOIN 
        Product p ON ps.product_id = p.product_id
    GROUP BY 
        ps.store_name, ps.store_street, ps.store_city, ps.store_state, ps.store_zipcode;
END //
DELIMITER ;

-- Summarizes each customer’s total spending on transactions.
DROP PROCEDURE IF EXISTS CreateCustomerSpendingView;
DELIMITER //
CREATE PROCEDURE CreateCustomerSpendingView()
BEGIN
	SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        SUM(t.total_amount) AS total_spent
    FROM 
        Customer c
    JOIN 
        Transaction t ON c.customer_id = t.customer_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name, c.email
    ORDER BY 
        total_spent DESC;
END //
DELIMITER ;

-- The top-selling products based on user input (such as the top N products)
DROP PROCEDURE IF EXISTS ViewTopSellingProduct;
DELIMITER //

CREATE PROCEDURE ViewTopSellingProduct(IN top_n INT)
BEGIN
    SELECT 
        p.product_name,
        SUM(tp.product_quantity * p.price) AS total_revenue,
        SUM(tp.product_quantity) AS total_quantity_sold
    FROM 
        TransactionProduct tp
    JOIN 
        Product p ON tp.product_id = p.product_id
    GROUP BY 
        p.product_name
    ORDER BY 
        total_revenue DESC
    LIMIT top_n;
END //

DELIMITER ;

-- Summary of sales performance at each store
DROP PROCEDURE IF EXISTS ViewStoreSalesPerformance;
DELIMITER //
CREATE PROCEDURE ViewStoreSalesPerformance()
BEGIN
	SELECT 
		ps.store_name, 
		SUM(tp.product_quantity) AS total_quantity_sold, 
		SUM(tp.product_quantity * p.price) AS total_revenue
	FROM 
		ProductStore ps
	JOIN 
		TransactionProduct tp ON ps.product_id = tp.product_id
	JOIN 
		Product p ON tp.product_id = p.product_id
	GROUP BY 
		ps.store_name;
END //
DELIMITER ;

-- Breaks down the total quantity sold and total revenue per year for each store
DROP PROCEDURE IF EXISTS ViewYearlySalesBreakdown;
DELIMITER //
CREATE PROCEDURE ViewYearlySalesBreakdown()
BEGIN
    SELECT 
        YEAR(t.date) AS year,
        ps.store_name,
        SUM(tp.product_quantity) AS total_quantity_sold,
        SUM(tp.product_quantity * p.price) AS total_revenue
    FROM 
        TransactionProduct tp
    JOIN 
        Transaction t ON tp.transaction_id = t.transaction_id
    JOIN 
        Product p ON tp.product_id = p.product_id
    JOIN 
        ProductStore ps ON ps.product_id = p.product_id
    GROUP BY 
        YEAR(t.date), ps.store_name
    ORDER BY 
        year DESC, total_revenue DESC;
END //
DELIMITER ;

--  provides an alert for products that have a quantity below a specified threshold
DROP PROCEDURE IF EXISTS ViewLowInventoryAlert;
DELIMITER //
CREATE PROCEDURE ViewLowInventoryAlert(IN threshold INT)
BEGIN
    SELECT 
        ps.store_name,
        ps.product_id,
        p.product_name,
        ps.product_quantity
    FROM 
        ProductStore ps
    JOIN 
        Product p ON ps.product_id = p.product_id
    WHERE 
        ps.product_quantity < threshold
    ORDER BY 
        ps.store_name, ps.product_quantity ASC;
END //
DELIMITER ;

-- Tracks the movement of inventory by summarizing the total 
-- quantity sold and remaining quantity within a specific date range
DROP PROCEDURE IF EXISTS ViewInventoryMovement;
DELIMITER //
CREATE PROCEDURE ViewInventoryMovement(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT 
        ps.store_name,
        p.product_name,
        SUM(tp.product_quantity) AS quantity_sold,
        SUM(ps.product_quantity) AS remaining_quantity
    FROM 
        ProductStore ps
    JOIN 
        Product p ON ps.product_id = p.product_id
    JOIN 
        TransactionProduct tp ON tp.product_id = ps.product_id
    JOIN 
        Transaction t ON tp.transaction_id = t.transaction_id
    WHERE 
        t.date BETWEEN start_date AND end_date
    GROUP BY 
        ps.store_name, p.product_name;
END //
DELIMITER ;

--  lists all employees working at a store
DROP PROCEDURE IF EXISTS ListEmployeesByStoreName;
DELIMITER //
CREATE PROCEDURE ListEmployeesByStoreName(IN input_store_name VARCHAR(64))
BEGIN
    SELECT 
        s.name AS store_name,
        s.street AS store_street,
        s.city AS store_city,
        s.state AS store_state,
        s.zipcode AS store_zipcode,
        e.employee_id,
        e.first_name,
        e.last_name,
        e.role
    FROM 
        Store s
    LEFT JOIN 
        Employee e ON s.name = e.store_name
                AND s.street = e.store_street
                AND s.city = e.store_city
                AND s.state = e.store_state
                AND s.zipcode = e.store_zipcode
    WHERE
		s.name LIKE CONCAT('%', IFNULL(input_store_name, ''), '%')
    ORDER BY 
        e.role;
END //
DELIMITER ;

-- Returns information about customer's transaction for a specific date, 
-- including the products purchased, quantities, and total value of transaction
DROP PROCEDURE IF EXISTS GetCustomerTransactionDetails;
DELIMITER //

CREATE PROCEDURE GetCustomerTransactionDetails(
    IN customer_id INT,
    IN transaction_date DATE
)
BEGIN
    SELECT 
        t.transaction_id,
        t.date AS transaction_date,
        tp.product_id,
        p.product_name,
        p.description,
        tp.product_quantity,
        p.price AS product_price,
        (tp.product_quantity * p.price) AS total_product_value,
        ps.store_name,
        ps.store_street,
        ps.store_city,
        ps.store_state,
        ps.store_zipcode,
        t.total_amount AS transaction_total
    FROM 
        TransactionProduct tp
    JOIN 
        Transaction t ON tp.transaction_id = t.transaction_id
    JOIN 
        Product p ON tp.product_id = p.product_id
    JOIN 
        ProductStore ps ON ps.product_id = p.product_id
    WHERE 
        t.customer_id = customer_id
    AND 
        t.date = transaction_date;
END //

DELIMITER ;

-- Enter customer's first name: Bob
-- Enter customer's last name: taylor
-- Enter the transaction date (YYYY-MM-DD): 2024-11-11

-- ------------------------ WRITE ------------------------ --
-- Update customer information
DROP PROCEDURE IF EXISTS UpdateCustomer;
DELIMITER //

CREATE PROCEDURE UpdateCustomer(
    IN p_customer_id INT, -- renamed to avoid confusion
    IN p_first_name VARCHAR(64),
    IN p_last_name VARCHAR(64),
    IN p_email VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT
)
BEGIN
    -- Check if the provided email already exists for another customer
    IF EXISTS (SELECT 1 FROM Customer WHERE email = p_email AND customer_id != p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists for another customer';
    ELSE
        -- If the email is the same as the current one, don't update it
        IF EXISTS (SELECT 1 FROM Customer WHERE customer_id = p_customer_id AND email = p_email) THEN
            -- Update all fields except the email
            UPDATE Customer
            SET first_name = p_first_name,
                last_name = p_last_name,
                street = p_street,
                city = p_city,
                state = p_state,
                zipcode = p_zipcode
            WHERE customer_id = p_customer_id;
        ELSE
            -- Update all fields, including the email
            UPDATE Customer
            SET first_name = p_first_name,
                last_name = p_last_name,
                email = p_email,
                street = p_street,
                city = p_city,
                state = p_state,
                zipcode = p_zipcode
            WHERE customer_id = p_customer_id;
        END IF;
    END IF;
END //

DELIMITER ;

-- update product information 
DROP PROCEDURE IF EXISTS UpdateProduct;
DELIMITER //

CREATE PROCEDURE UpdateProduct(
    IN p_product_id INT,
    IN p_product_name VARCHAR(64),
    IN p_description VARCHAR(128),
    IN p_price FLOAT
)
BEGIN
    UPDATE Product
    SET product_name = p_product_name,
        description = p_description,
        price = p_price
    WHERE product_id = p_product_id;
END //

DELIMITER ;

-- update store information 
DROP PROCEDURE IF EXISTS UpdateStore;
DELIMITER //

CREATE PROCEDURE UpdateStore(
    IN p_name VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT,
    IN p_new_name VARCHAR(64),
    IN p_new_street VARCHAR(64),
    IN p_new_city VARCHAR(64),
    IN p_new_state VARCHAR(2),
    IN p_new_zipcode INT
)
BEGIN
    UPDATE Store
    SET name = p_new_name,
        street = p_new_street,
        city = p_new_city,
        state = p_new_state,
        zipcode = p_new_zipcode
    WHERE name = p_name
    AND street = p_street
    AND city = p_city
    AND state = p_state
    AND zipcode = p_zipcode;
END //

DELIMITER ;

-- Update employee information 
DROP PROCEDURE IF EXISTS UpdateEmployee;
DELIMITER //

CREATE PROCEDURE UpdateEmployee(
    IN p_employee_id INT,
    IN p_first_name VARCHAR(64),
    IN p_last_name VARCHAR(64),
    IN p_role VARCHAR(64)
)
BEGIN
    UPDATE Employee
    SET first_name = p_first_name,
        last_name = p_last_name,
        role = p_role
    WHERE employee_id = p_employee_id;
END //

DELIMITER ;

-- Add product to transaction 
DROP PROCEDURE IF EXISTS AddProductsToTransaction;
DELIMITER //

CREATE PROCEDURE AddProductsToTransaction(
    IN p_transaction_id INT,
    IN p_product_id INT,
    IN p_product_quantity INT
)
BEGIN
    INSERT INTO TransactionProduct (transaction_id, product_id, product_quantity)
    VALUES (p_transaction_id, p_product_id, p_product_quantity);
END //

DELIMITER ;

-- Update product quantity in store
DROP PROCEDURE IF EXISTS UpdateProductQuantityInStore;
DELIMITER //

CREATE PROCEDURE UpdateProductQuantityInStore(
    IN p_product_id INT,
    IN p_store_name VARCHAR(64),
    IN p_store_street VARCHAR(64),
    IN p_store_city VARCHAR(64),
    IN p_store_state VARCHAR(2),
    IN p_store_zipcode INT,
    IN p_new_quantity INT
)
BEGIN
    -- Check if the store exists
    DECLARE store_exists INT;

    SELECT COUNT(*)
    INTO store_exists
    FROM Store
    WHERE name = p_store_name
    AND street = p_store_street
    AND city = p_store_city
    AND state = p_store_state
    AND zipcode = p_store_zipcode;

    -- If store doesn't exist, raise an error
    IF store_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: The specified store does not exist.';
    END IF;

    -- Proceed with updating the product quantity in the store if the store exists
    UPDATE ProductStore
    SET product_quantity = p_new_quantity
    WHERE product_id = p_product_id
    AND store_name = p_store_name
    AND store_street = p_store_street
    AND store_city = p_store_city
    AND store_state = p_store_state
    AND store_zipcode = p_store_zipcode;

END //

DELIMITER ;


-- ------------------------ CREATE ------------------------ --
DROP PROCEDURE IF EXISTS AddCustomer;

-- Procedure to Add a Customer
DELIMITER //

CREATE PROCEDURE AddCustomer(
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


DROP PROCEDURE IF EXISTS AddStore;
-- Procedure to Add a Store
DELIMITER //

CREATE PROCEDURE AddStore(
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


DROP PROCEDURE IF EXISTS AddEmployee;
-- Procedure to Add an Employee
DELIMITER //

CREATE PROCEDURE AddEmployee(
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


DROP PROCEDURE IF EXISTS AddTransaction;
-- Procedure to Add a Transaction
DELIMITER //

CREATE PROCEDURE AddTransaction(
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

DROP PROCEDURE IF EXISTS AddProduct;
-- Procedure to Add a Product
DELIMITER //

CREATE PROCEDURE AddProduct(
    IN p_product_name VARCHAR(64),
    IN p_description VARCHAR(128),
    IN p_price FLOAT
)
BEGIN
    INSERT INTO Product (product_name, description, price)
    VALUES (p_product_name, p_description, p_price);
END //

DELIMITER ;



-- ------------------------ DELETE ------------------------ --
DROP PROCEDURE IF EXISTS DeleteCustomer;
-- Procedure to Delete a Customer
DELIMITER //

CREATE PROCEDURE DeleteCustomer(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM Customer
    WHERE customer_id = p_customer_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteStore;
-- Procedure to Delete a Store
DELIMITER //

CREATE PROCEDURE DeleteStore(
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

DROP PROCEDURE IF EXISTS DeleteEmployee;
-- Procedure to Delete an Employee
DELIMITER //

CREATE PROCEDURE DeleteEmployee(
    IN p_employee_id INT
)
BEGIN
    DELETE FROM Employee
    WHERE employee_id = p_employee_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteTransaction;
-- Procedure to Delete a Transaction
DELIMITER //

CREATE PROCEDURE DeleteTransaction(
    IN p_transaction_id INT
)
BEGIN
    DELETE FROM Transaction
    WHERE transaction_id = p_transaction_id;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteProduct;
-- Procedure to Delete a Product
DELIMITER //

CREATE PROCEDURE DeleteProduct(
    IN p_product_id INT
)
BEGIN
    DELETE FROM Product
    WHERE product_id = p_product_id;
END //

DELIMITER ;

