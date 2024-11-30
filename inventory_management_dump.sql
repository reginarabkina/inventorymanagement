CREATE DATABASE  IF NOT EXISTS `inventory_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory_management`;
-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (x86_64)
--
-- Host: 127.0.0.1    Database: inventory_management
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `street` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipcode` int NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES (2,'Bob','Taylor','bob.taylor@email.com','123 Elm St','Los Angeles','CA',90002),(4,'Diana','Wilson','diana.wilson@email.com','789 Cedar St','New York','NY',10002),(6,'Frank','Taylor','frank.taylor@email.com','1112 Oak St','Dallas','TX',75202),(7,'Grace','Garcia','grace.garcia@email.com','1314 Maple St','Phoenix','AZ',85002),(8,'Regina','Rabkina','reginaemail@gmail.com','123 Street','City','NY',12345);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerStore`
--

DROP TABLE IF EXISTS `CustomerStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CustomerStore` (
  `customer_id` int NOT NULL,
  `store_name` varchar(64) NOT NULL,
  `store_street` varchar(64) NOT NULL,
  `store_city` varchar(64) NOT NULL,
  `store_state` varchar(2) NOT NULL,
  `store_zipcode` int NOT NULL,
  PRIMARY KEY (`customer_id`,`store_name`,`store_street`,`store_state`,`store_zipcode`),
  KEY `store_name` (`store_name`,`store_street`,`store_city`,`store_state`,`store_zipcode`),
  CONSTRAINT `customerstore_ibfk_1` FOREIGN KEY (`store_name`, `store_street`, `store_city`, `store_state`, `store_zipcode`) REFERENCES `Store` (`name`, `street`, `city`, `state`, `zipcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customerstore_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerStore`
--

LOCK TABLES `CustomerStore` WRITE;
/*!40000 ALTER TABLE `CustomerStore` DISABLE KEYS */;
INSERT INTO `CustomerStore` VALUES (4,'ElectroShop','1010 Circuit Rd','New York','NY',10001),(2,'GroceryMart','456 Market St','Los Angeles','CA',90001),(7,'PetStore','4040 Animal Ln','Houston','TX',77001);
/*!40000 ALTER TABLE `CustomerStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `role` varchar(64) NOT NULL,
  `store_name` varchar(64) DEFAULT NULL,
  `store_street` varchar(64) DEFAULT NULL,
  `store_city` varchar(64) DEFAULT NULL,
  `store_state` varchar(2) DEFAULT NULL,
  `store_zipcode` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `store_name` (`store_name`,`store_street`,`store_city`,`store_state`,`store_zipcode`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`store_name`, `store_street`, `store_city`, `store_state`, `store_zipcode`) REFERENCES `Store` (`name`, `street`, `city`, `state`, `zipcode`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,'Johnathan','Doe','Manager','TechWorld','123 Tech Blvd','San Francisco','CA',94107),(2,'Jane','Smith','Cashier','GroceryMart','456 Market St','Los Angeles','CA',90001),(3,'Mark','Johnson','Stock Clerk','BestBooks','789 Book Ave','Chicago','IL',60601),(4,'Emily','Davis','Manager','ElectroShop','1010 Circuit Rd','New York','NY',10001),(5,'Chris','Martinez','Cashier','FashionHub','2020 Fashion St','Miami','FL',33101),(6,'Dave','Perez','Assistant Manager',NULL,NULL,NULL,NULL,NULL),(7,'Lin','Brown','Stock Clerk','PetStore','4040 Animal Ln','Houston','TX',77001);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(64) NOT NULL,
  `description` varchar(128) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'Laptop','High performance laptop',999.99),(2,'Smartphone','Latest model smartphone',699.99),(3,'Book','Best selling nonfiction book',14.39),(4,'Washing Machine','Energy-efficient washing machine',499.99),(5,'Air Conditioner','Cool down your space with this AC',299.99),(6,'Gaming Console','Next-gen gaming console',399.99),(7,'Refrigerator','Stainless steel fridge',799.99),(8,'TV','4K Ultra HD Smart TV',599.99),(9,'Coffee Maker','Brews perfect coffee every time',49.99),(11,'Paint','Assorted paint colors',4.99);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductStore`
--

DROP TABLE IF EXISTS `ProductStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductStore` (
  `product_id` int NOT NULL,
  `store_name` varchar(64) NOT NULL,
  `store_street` varchar(64) NOT NULL,
  `store_city` varchar(64) NOT NULL,
  `store_state` varchar(2) NOT NULL,
  `store_zipcode` int NOT NULL,
  `product_quantity` int NOT NULL,
  PRIMARY KEY (`product_id`,`store_name`,`store_street`,`store_state`,`store_zipcode`),
  KEY `store_name` (`store_name`,`store_street`,`store_city`,`store_state`,`store_zipcode`),
  CONSTRAINT `productstore_ibfk_1` FOREIGN KEY (`store_name`, `store_street`, `store_city`, `store_state`, `store_zipcode`) REFERENCES `Store` (`name`, `street`, `city`, `state`, `zipcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productstore_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductStore`
--

LOCK TABLES `ProductStore` WRITE;
/*!40000 ALTER TABLE `ProductStore` DISABLE KEYS */;
INSERT INTO `ProductStore` VALUES (1,'TechWorld','123 Tech Blvd','San Francisco','CA',94107,100),(2,'GroceryMart','456 Market St','Los Angeles','CA',90001,200),(3,'BestBooks','789 Book Ave','Chicago','IL',60601,300),(4,'ElectroShop','1010 Circuit Rd','New York','NY',10001,150),(5,'FashionHub','2020 Fashion St','Miami','FL',33101,30),(7,'PetStore','4040 Animal Ln','Houston','TX',77001,250);
/*!40000 ALTER TABLE `ProductStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Store`
--

DROP TABLE IF EXISTS `Store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Store` (
  `name` varchar(64) NOT NULL,
  `street` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zipcode` int NOT NULL,
  PRIMARY KEY (`name`,`street`,`city`,`state`,`zipcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Store`
--

LOCK TABLES `Store` WRITE;
/*!40000 ALTER TABLE `Store` DISABLE KEYS */;
INSERT INTO `Store` VALUES ('BestBooks','789 Book Ave','Chicago','IL',60601),('BestBooks','790 Book Ave','Chicago','IL',60602),('ElectroShop','1010 Circuit Rd','New York','NY',10001),('FashionHub','2020 Fashion St','Miami','FL',33101),('GourmetFood','6060 Food Way','Boston','MA',2108),('GroceryMart','456 Market St','Los Angeles','CA',90001),('GroceryMart','457 Market St','Los Angeles','CA',90002),('New Store Name','Street','City','Ma',23456),('PetStore','4040 Animal Ln','Houston','TX',77001),('SportsShop','7070 Sport Ave','Chicago','IL',60611),('TechWorld','123 Tech Blvd','San Francisco','CA',94107),('TechWorld','124 Tech Blvd','San Francisco','CA',94108),('ToyLand','5050 Fun Dr','Phoenix','AZ',85001);
/*!40000 ALTER TABLE `Store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transaction`
--

DROP TABLE IF EXISTS `Transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `total_amount` float NOT NULL,
  `date` date NOT NULL,
  `payment_method` enum('credit','debit','cash','check','ebt') DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transaction`
--

LOCK TABLES `Transaction` WRITE;
/*!40000 ALTER TABLE `Transaction` DISABLE KEYS */;
INSERT INTO `Transaction` VALUES (2,599.9,'2024-11-11','check',2),(6,799.99,'2024-11-15','credit',6),(7,334.67,'2024-11-16','credit',7),(8,499.99,'2024-12-13','debit',7),(9,54.38,'2024-11-28','credit',8);
/*!40000 ALTER TABLE `Transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TransactionProduct`
--

DROP TABLE IF EXISTS `TransactionProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TransactionProduct` (
  `transaction_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_quantity` int NOT NULL,
  PRIMARY KEY (`transaction_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `transactionproduct_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `Transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transactionproduct_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TransactionProduct`
--

LOCK TABLES `TransactionProduct` WRITE;
/*!40000 ALTER TABLE `TransactionProduct` DISABLE KEYS */;
INSERT INTO `TransactionProduct` VALUES (2,2,2),(6,6,2),(7,7,1);
/*!40000 ALTER TABLE `TransactionProduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'inventory_management'
--

--
-- Dumping routines for database 'inventory_management'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomer`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddEmployee`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProduct`(
    IN p_product_name VARCHAR(64),
    IN p_description VARCHAR(128),
    IN p_price FLOAT
)
BEGIN
    INSERT INTO Product (product_name, description, price)
    VALUES (p_product_name, p_description, p_price);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddProductsToTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddProductsToTransaction`(
    IN p_transaction_id INT,
    IN p_product_id INT,
    IN p_product_quantity INT
)
BEGIN
    INSERT INTO TransactionProduct (transaction_id, product_id, product_quantity)
    VALUES (p_transaction_id, p_product_id, p_product_quantity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddStore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddStore`(
    IN p_name VARCHAR(64),
    IN p_street VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(2),
    IN p_zipcode INT
)
BEGIN
    INSERT INTO Store (name, street, city, state, zipcode)
    VALUES (p_name, p_street, p_city, p_state, p_zipcode);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTransaction`(
    IN p_customer_id INT,
    IN p_total_amount FLOAT,
    IN p_date DATE,
    IN p_payment_method ENUM('credit', 'debit', 'cash', 'check', 'ebt')
)
BEGIN
    INSERT INTO Transaction (customer_id, total_amount, date, payment_method)
    VALUES (p_customer_id, p_total_amount, p_date, p_payment_method);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateCustomerSpendingView` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateCustomerSpendingView`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateProductAvailabilityView` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateProductAvailabilityView`(IN ProductName VARCHAR(255))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateStoreInventoryValueView` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateStoreInventoryValueView`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCustomer`(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM Customer
    WHERE customer_id = p_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEmployee`(
    IN p_employee_id INT
)
BEGIN
    DELETE FROM Employee
    WHERE employee_id = p_employee_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProduct`(
    IN p_product_id INT
)
BEGIN
    DELETE FROM Product
    WHERE product_id = p_product_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteStore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteStore`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteTransaction`(
    IN p_transaction_id INT
)
BEGIN
    DELETE FROM Transaction
    WHERE transaction_id = p_transaction_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerTransactionDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerTransactionDetails`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListEmployeesByStoreName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ListEmployeesByStoreName`(IN input_store_name VARCHAR(64))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomer`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateEmployee`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProduct`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateProductQuantityInStore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateProductQuantityInStore`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateStore` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStore`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewInventoryMovement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewInventoryMovement`(IN start_date DATE, IN end_date DATE)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewLowInventoryAlert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewLowInventoryAlert`(IN threshold INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewStoreSalesPerformance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewStoreSalesPerformance`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewTopSellingProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewTopSellingProduct`(IN top_n INT)
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewYearlySalesBreakdown` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewYearlySalesBreakdown`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-29 20:00:43
