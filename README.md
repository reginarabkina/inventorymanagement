# Inventory Management Project

## Introduction

This project involves developing a Grocery Store Database application that simulates key business operations of a retail grocery store, focusing on the ability to create, read, update, and delete records in a MySQL database. The system aims to help manage essential data such as customer information, product inventory, sales transactions, employee records, and store locations. Users will interact with the database through a simple user interface—a command-line program—allowing them to perform critical operations based on their needs. The project showcases the application of relational database concepts by ensuring data consistency, supporting multiple relationships between entities, and handling real-world scenarios like inventory management and transaction processing.  

### Project Overview and Functionality

The primary functionality of the Grocery Store Database application will revolve around several core operations. Users will be able to register and manage customers by adding new records, updating personal details, and removing customers when necessary. Product management will include adding new items to the inventory, adjusting prices or stock quantities, and deleting discontinued products. Transactions will be logged to keep track of purchases, with the ability to view, update, or delete transaction records. Employee management will allow the addition of new staff members, updates to employee roles, and searching for employees by store location. These operations will ensure that the database remains consistent and up-to-date, reflecting real-world business processes. 

---

## Project Setup

This project includes the following components:

- **Database Schema**: A MySQL database that supports inventory management with tables for items, categories, suppliers, etc.
- **Application Code**: A Python program to interact with the database, providing an interface for performing CRUD operations.
- **Required Libraries**: Python libraries such as `pymysql` for MySQL database connection and `tabulate` for formatted output of data.

---

## System Requirements

To run this project, you will need the following:

- **MySQL Database**: A MySQL server running locally or remotely with access credentials.
- **Python 3.x**: Python version 3.6 or higher.
- **Libraries**: `pymysql` and `tabulate`

  
  Install the required libraries using pip:
  ```bash
  pip install pymysql tabulate
  ```

-- 

## Installation Instructions

### Step 1: Download or Clone the Project

You can download the project files from the repository or clone it using Git.

Clone the repository in the terminal using:

```bash
git clone https://github.com/your-repo/inventory-management.git
cd inventory-management
```

### Step 2: Set Up the Database

Using MySQL Workbench, open the inventory_management_dump.sql and run the whole file.


-- 

## How to Use

### Run the Python Application

In your terminal or command prompt, navigate to the project folder and run:

```bash
python main.py
```

### Database Connection
After running the program, it will prompt you for the MySQL username and password. Enter your credentials to connect to the inventory_management database.

Select Operations
Once connected, you will be presented with a simple text-based menu to choose from:

1. Create Data: Add new records to the database.
2. Read Data: View existing data in the database.
3. Update Data: Modify existing records.
4. Delete Data: Remove records from the database.
5. Exit: Close the application.
