from tabulate import tabulate

def format_and_display_table(results, headers):
    """Formats and displays query results in a table format."""
    print(tabulate(results, headers=headers, tablefmt="grid"))

def display_menu():
    """Displays a categorized menu."""
    print("\n--- Update Data Menu ---")
    print("\n[1] Sales Data")
    print("\n[2] Inventory Data")
    print("\n[3] Customer Data")
    print("  3.1 Update Customer Information")
    print("\n[4] Employee Data")
    print("  4.1 Update Employee Information")
    print("\n[5] Product Data")
    print("  5.1 Update Product Information")
    print("\n[6] Store Data")
    print("  6.1 Update Store Information")
    print("  6.2 Update Product Quantity in Store")
    print("\n0. Exit")

def update_data_menu(connection):
    """Menu for updating data in various tables."""
    while True:
        display_menu()
        choice = input("\nEnter your choice: ")

        if choice == '3.1':
            print()
            update_customer_info(connection)
        elif choice == '4.1':
            print()
            update_employee_info(connection)
        elif choice == '5.1':
            print()
            update_product_info(connection)
        elif choice == '6.1':
            print()
            update_store_info(connection)
        elif choice == '6.2':
            print()
            update_product_quantity_in_store(connection)
        elif choice == '0':
            print("Exiting menu.")
            break
        else:
            print("Invalid choice. Please try again.")

        # Asks user if they want to continue in the current menu or return to the main menu
        user_input = input(
            "\nWould you like to go back to the current menu? (y) or return to the main menu? (m): ").strip().lower()

        if user_input == 'm':
            break
        elif user_input != 'y':
            print("Invalid input. Exiting to the main menu.")
            break


def search_customer(connection):
    """Allows user to search for a customer by first name, last name, or email."""
    search_option = input("Search by [1] Name or [2] Email? Enter 1 or 2: ").strip()

    if search_option == '1':
        first_name = input("Enter the first name: ")
        last_name = input("Enter the last name: ")
        query = """
            SELECT customer_id, first_name, last_name, email
            FROM Customer
            WHERE first_name LIKE %s AND last_name LIKE %s
        """
        cursor = connection.cursor()
        cursor.execute(query, (f"%{first_name}%", f"%{last_name}%"))
    elif search_option == '2':
        email = input("Enter the email: ")
        query = """
            SELECT customer_id, first_name, last_name, email
            FROM Customer
            WHERE email LIKE %s
        """
        cursor = connection.cursor()
        cursor.execute(query, (f"%{email}%",))
    else:
        print("Invalid input. Returning to the main menu.")
        return None

    results = cursor.fetchall()

    if not results:
        print("No customers found matching your search criteria.")
        return None

    # Display the search results
    print("\nFound the following customers:")
    headers = ['Customer ID', 'First Name', 'Last Name', 'Email']
    format_and_display_table(results, headers)

    # Let the user choose a customer
    try:
        customer_id = int(input("\nEnter the Customer ID of the customer you want to update: "))
        return customer_id
    except ValueError:
        print("Invalid input. Please enter a valid Customer ID.")
        return None

def search_employee(connection):
    """Allows user to search for an employee by first name, last name, or store."""
    search_option = input("Search by [1] Name or [2] Store? Enter 1 or 2: ").strip()

    if search_option == '1':
        first_name = input("Enter the first name: ")
        last_name = input("Enter the last name: ")
        query = """
            SELECT employee_id, first_name, last_name, store_name
            FROM Employee
            WHERE first_name LIKE %s AND last_name LIKE %s
        """
        cursor = connection.cursor()
        cursor.execute(query, (f"%{first_name}%", f"%{last_name}%"))
    elif search_option == '2':
        store = input("Enter the store: ")
        query = """
            SELECT employee_id, first_name, last_name, store_name
            FROM Employee
            WHERE store_name LIKE %s
        """
        cursor = connection.cursor()
        cursor.execute(query, (f"%{store}%",))
    else:
        print("Invalid input. Returning to the main menu.")
        return None

    results = cursor.fetchall()

    if not results:
        print("No customers found matching your search criteria.")
        return None

    # Display the search results
    print("\nFound the following customers:")
    headers = ['Customer ID', 'First Name', 'Last Name', 'Email']
    format_and_display_table(results, headers)

    # Let the user choose a customer
    try:
        customer_id = int(input("\nEnter the Employee ID of the employee you want to update: "))
        return customer_id
    except ValueError:
        print("Invalid input. Please enter a valid Customer ID.")
        return None

def search_product(connection):
    """Allows user to search for a product by name."""
    product_name = input("Enter product name to search: ").strip()

    query = """
        SELECT product_id, product_name, description, price
        FROM Product
        WHERE product_name LIKE %s
    """
    cursor = connection.cursor()
    cursor.execute(query, (f"%{product_name}%"))

    results = cursor.fetchall()

    if not results:
        print("No products found matching your search criteria.")
        return None

    # Display the search results
    print("\nFound the following products:")
    headers = ['Customer ID', 'First Name', 'Last Name', 'Email']
    format_and_display_table(results, headers)

    # Let the user choose a customer
    try:
        product_id = int(input("\nEnter the Product ID of the product you want to update: "))
        return product_id
    except ValueError:
        print("Invalid input. Please enter a valid Product ID.")
        return None


def update_customer_info(connection):
    """Prompts the user to select a customer and update their information."""
    customer_id = search_customer(connection)
    if customer_id is None:
        return

    try:
        first_name = input("Enter the new first name: ")
        last_name = input("Enter the new last name: ")
        email = input("Enter the new email: ")
        street = input("Enter the new street address: ")
        city = input("Enter the new city: ")
        state = input("Enter the new state (2-letter code): ")
        zipcode = int(input("Enter the new zipcode: "))

        cursor = connection.cursor()

        # Check if the email is already in use by another customer
        cursor.execute("SELECT customer_id FROM Customer WHERE email = %s", (email,))
        existing_customer = cursor.fetchone()

        if existing_customer and existing_customer[0] != customer_id:
            print(f"Error: The email '{email}' is already associated with another customer.")
            return

        # Call the stored procedure to update the customer details
        cursor.callproc('UpdateCustomer', [
            customer_id, first_name, last_name, email, street, city, state, zipcode
        ])
        connection.commit()
        print(f"Customer {first_name} {last_name} (ID: {customer_id}) updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()

def update_employee_info(connection):
    """Updates employee information."""
    employee_id = search_employee(connection)
    if employee_id is None:
        return

    try:
        employee_id = int(employee_id)
        first_name = input("Enter the new first name: ")
        last_name = input("Enter the new last name: ")
        role = input("Enter the new role: ")

        cursor = connection.cursor()
        cursor.callproc('UpdateEmployee', [
            employee_id, first_name, last_name, role
        ])
        connection.commit()
        print(f"Employee {first_name} {last_name} (ID: {employee_id}) updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()

def update_product_info(connection):
    """Updates product information."""
    product_id = search_product(connection)
    if product_id is None:
        return

    try:
        product_id = product_id
        product_name = input("Enter the new product name: ")
        description = input("Enter the new description: ")
        price = float(input("Enter the new price: "))

        cursor = connection.cursor()
        cursor.callproc('UpdateProduct', [
            product_id, product_name, description, price
        ])
        connection.commit()
        print(f"Product {product_name} (ID: {product_id}) updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()

def update_store_info(connection):
    """Updates store information."""
    try:
        store_name = input("Enter the store name to update: ")
        store_street = input("Enter the current store street: ")
        store_city = input("Enter the current store city: ")
        store_state = input("Enter the current store state (2-letter code): ")
        store_zipcode = int(input("Enter the current store zipcode: "))

        new_name = input("Enter the new store name: ")
        new_street = input("Enter the new store street: ")
        new_city = input("Enter the new store city: ")
        new_state = input("Enter the new store state (2-letter code): ")
        new_zipcode = int(input("Enter the new store zipcode: "))

        cursor = connection.cursor()
        cursor.callproc('UpdateStore', [
            store_name, store_street, store_city, store_state, store_zipcode,
            new_name, new_street, new_city, new_state, new_zipcode
        ])
        connection.commit()
        print(f"Store {store_name} updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()

def update_product_quantity_in_store(connection):
    """Updates product quantity in a store."""
    product_id = search_product(connection)
    if product_id is None:
        return

    try:
        product_id = int(product_id)
        store_name = input("Enter the store name: ")
        store_street = input("Enter the store street: ")
        store_city = input("Enter the store city: ")
        store_state = input("Enter the store state (2-letter code): ")
        store_zipcode = int(input("Enter the store zipcode: "))
        new_quantity = int(input("Enter the new quantity: "))

        cursor = connection.cursor()
        cursor.callproc('UpdateProductQuantityInStore', [
            product_id, store_name, store_street, store_city, store_state, store_zipcode, new_quantity
        ])
        connection.commit()
        print(f"Product quantity for product ID {product_id} updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()