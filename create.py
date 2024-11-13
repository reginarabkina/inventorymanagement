def create_customer(connection):
    """Prompt the user to add a customer."""
    first_name = input("Enter Customer First Name: ")
    last_name = input("Enter Customer Last Name: ")
    email = input("Enter Customer Email: ")
    street = input("Enter Customer Street: ")
    city = input("Enter Customer City: ")
    state = input("Enter Customer State: ")
    zipcode = int(input("Enter Customer Zipcode: "))
    
    cursor = connection.cursor()
    cursor.callproc('add_customer', [first_name, last_name, email, street, city, state, zipcode])
    connection.commit()
    print(f"Customer {first_name} {last_name} added successfully.")

def create_store(connection):
    """Prompt the user to add a store."""
    name = input("Enter Store Name: ")
    street = input("Enter Store Street: ")
    city = input("Enter Store City: ")
    state = input("Enter Store State: ")
    zipcode = int(input("Enter Store Zipcode: "))
    
    cursor = connection.cursor()
    cursor.callproc('add_store', [name, street, city, state, zipcode])
    connection.commit()
    print(f"Store {name} added successfully.")

def create_employee(connection):
    """Prompt the user to add an employee."""
    first_name = input("Enter Employee First Name: ")
    last_name = input("Enter Employee Last Name: ")
    role = input("Enter Employee Role: ")
    store_name = input("Enter Store Name: ")
    store_street = input("Enter Store Street: ")
    store_city = input("Enter Store City: ")
    store_state = input("Enter Store State: ")
    store_zipcode = int(input("Enter Store Zipcode: "))
    
    cursor = connection.cursor()
    cursor.callproc('add_employee', [first_name, last_name, role, store_name, store_street, store_city, store_state, store_zipcode])
    connection.commit()
    print(f"Employee {first_name} {last_name} added successfully.")

def create_transaction(connection):
    """Prompt the user to add a transaction."""
    customer_id = int(input("Enter Customer ID: "))
    total_amount = float(input("Enter Transaction Total Amount: "))
    date = input("Enter Transaction Date (YYYY-MM-DD): ")
    payment_method = input("Enter Payment Method: ")
    
    cursor = connection.cursor()
    cursor.callproc('add_transaction', [customer_id, total_amount, date, payment_method])
    connection.commit()
    print(f"Transaction added for Customer ID {customer_id}.")

def create_product(connection):
    """Prompt the user to add a product."""
    product_name = input("Enter Product Name: ")
    description = input("Enter Product Description: ")
    price = float(input("Enter Product Price: "))
    
    cursor = connection.cursor()
    cursor.callproc('add_product', [product_name, description, price])
    connection.commit()
    print(f"Product {product_name} added successfully.")

def create_data_menu(connection):
    """Menu for creating new records."""
    while True:
        print("\n--- Create Data Menu ---")
        print("1. Add Customer")
        print("2. Add Store")
        print("3. Add Employee")
        print("4. Add Transaction")
        print("5. Add Product")
        print("6. Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == '1':
            create_customer(connection)
        elif choice == '2':
            create_store(connection)
        elif choice == '3':
            create_employee(connection)
        elif choice == '4':
            create_transaction(connection)
        elif choice == '5':
            create_product(connection)
        elif choice == '6':
            break
        else:
            print("Invalid choice. Please try again.")
