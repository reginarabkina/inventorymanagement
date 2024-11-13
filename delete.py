def delete_customer(connection):
    """Prompt the user to delete a customer."""
    customer_id = int(input("Enter Customer ID to delete: "))
    
    cursor = connection.cursor()
    cursor.callproc('delete_customer', [customer_id])
    connection.commit()
    print(f"Customer with ID {customer_id} deleted successfully.")

def delete_store(connection):
    """Prompt the user to delete a store using the composite key."""
    name = input("Enter Store Name to delete: ")
    street = input("Enter Store Street to delete: ")
    city = input("Enter Store City to delete: ")
    state = input("Enter Store State to delete: ")
    zipcode = int(input("Enter Store Zipcode to delete: "))
    
    cursor = connection.cursor()
    cursor.callproc('delete_store', [name, street, city, state, zipcode])
    connection.commit()
    print(f"Store {name} at {street}, {city}, {state}, {zipcode} deleted successfully.")
    
def delete_employee(connection):
    """Prompt the user to delete an employee."""
    employee_id = int(input("Enter Employee ID to delete: "))
    
    cursor = connection.cursor()
    cursor.callproc('delete_employee', [employee_id])
    connection.commit()
    print(f"Employee with ID {employee_id} deleted successfully.")

def delete_transaction(connection):
    """Prompt the user to delete a transaction."""
    transaction_id = int(input("Enter Transaction ID to delete: "))
    
    cursor = connection.cursor()
    cursor.callproc('delete_transaction', [transaction_id])
    connection.commit()
    print(f"Transaction with ID {transaction_id} deleted successfully.")

def delete_product(connection):
    """Prompt the user to delete a product."""
    product_id = int(input("Enter Product ID to delete: "))
    
    cursor = connection.cursor()
    cursor.callproc('delete_product', [product_id])
    connection.commit()
    print(f"Product with ID {product_id} deleted successfully.")

def delete_data_menu(connection):
    """Menu for deleting records."""
    while True:
        print("\n--- Delete Data Menu ---")
        print("1. Delete Customer")
        print("2. Delete Store")
        print("3. Delete Employee")
        print("4. Delete Transaction")
        print("5. Delete Product")
        print("6. Back to Main Menu")
        choice = input("Enter your choice: ")

        if choice == '1':
            delete_customer(connection)
        elif choice == '2':
            delete_store(connection)
        elif choice == '3':
            delete_employee(connection)
        elif choice == '4':
            delete_transaction(connection)
        elif choice == '5':
            delete_product(connection)
        elif choice == '6':
            break
        else:
            print("Invalid choice. Please try again.")
