from update import format_and_display_table


def search_data(connection):
    """Prompt user for search type and handle search based on selection."""
    print("\n--- Search Data ---")
    print("[1] Search by Customer")
    print("[2] Search by Employee")
    print("[3] Search by Transaction")
    print("[4] Search by Store")
    choice = input("Enter your choice: ").strip()

    if choice == '1':
        search_customer_and_display_all(connection)
    elif choice == '2':
        search_employees_and_display_all(connection)
    elif choice == '3':
        search_transactions_and_display_all(connection)
    elif choice == '4':
        display_all_stores(connection)
    else:
        print("Invalid choice. Returning to menu.")


def display_table_with_search_option(results, headers, entity, connection):
    """Displays results with an option to search or show all."""
    if not results:
        print(f"No records found for {entity}.")
        return

    print(f"\n--- {entity} Records ---")
    format_and_display_table(results, headers)

    # Ask the user if they want to search again or display all records
    user_input = input(f"Do you want to search {entity} again? (y) or view all records? (a): ").strip().lower()

    if user_input == 'y':
        search_option(entity, connection)
    elif user_input == 'a':
        show_all_records(entity, connection)
    else:
        print("Invalid input. Returning to the menu.")


def search_customer_and_display_all(connection):
    """Search for a customer by name or display all customers."""
    choice = input("Would you like to (1) search for a customer by name or (2) view all customers? ").strip()

    if choice == '1':
        first_name = input("Enter customer's first name: ").strip()
        last_name = input("Enter customer's last name: ").strip()
        search_customer(connection, first_name, last_name)
    elif choice == '2':
        display_all_customers(connection)
    else:
        print("Invalid choice. Returning to the menu.")


def display_all_stores(connection):
    """Displays all stores."""
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Store")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- All Stores ---")
        format_and_display_table(results, headers)


def display_all_customers(connection):
    """Displays all customers."""
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Customer")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- All Customers ---")
        format_and_display_table(results, headers)


def search_transactions_and_display_all(connection):
    """Search for transactions by customer or date or display all transactions."""
    choice = input(
        "Would you like to (1) search for transactions by customer or date or (2) view all transactions? ").strip()

    if choice == '1':
        first_name = input("Enter customer's first name: ").strip()
        last_name = input("Enter customer's last name: ").strip()
        date = input("Enter transaction date (YYYY-MM-DD): ").strip()
        search_transactions(connection, first_name, last_name, date)
    elif choice == '2':
        display_all_transactions(connection)
    else:
        print("Invalid choice. Returning to the menu.")


def display_all_transactions(connection):
    """Displays all transactions."""
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Transaction")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- All Transactions ---")
        format_and_display_table(results, headers)


def search_employees_and_display_all(connection):
    """Search for employees by store or display all employees."""
    choice = input("Would you like to (1) search for employees by store or (2) view all employees? ").strip()

    if choice == '1':
        store_name = input("Enter store name: ").strip()
        search_employees(connection, store_name)
    elif choice == '2':
        display_all_employees(connection)
    else:
        print("Invalid choice. Returning to the menu.")


def display_all_employees(connection):
    """Displays all employees."""
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM Employee")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- All Employees ---")
        format_and_display_table(results, headers)


def show_all_records(entity, connection):
    """Show all records from a specified entity."""
    if entity == 'Transaction':
        display_all_transactions(connection)
    elif entity == 'Customer':
        display_all_customers(connection)
    elif entity == 'Store':
        display_all_stores(connection)
    elif entity == 'Employee':
        display_all_employees(connection)


def search_option(entity, connection):
    """Prompts user to search for a specific entity."""
    if entity == "Sales":
        store_name = input("Enter store name: ").strip()
        date = input("Enter date (YYYY-MM-DD): ").strip()
        search_sales(connection, store_name, date)
    elif entity == "Transaction":
        first_name = input("Enter customer's first name: ").strip()
        last_name = input("Enter customer's last name: ").strip()
        date = input("Enter transaction date (YYYY-MM-DD): ").strip()
        search_transactions(connection, first_name, last_name, date)
    elif entity == "Customer":
        first_name = input("Enter customer's first name: ").strip()
        last_name = input("Enter customer's last name: ").strip()
        search_customer(connection, first_name, last_name)
    elif entity == "Employee":
        store_name = input("Enter store name: ").strip()
        search_employees(connection, store_name)


def search_sales(connection, store_name, date):
    """Search for sales based on store or date."""
    with connection.cursor() as cursor:
        query = "SELECT * FROM Sales WHERE store_name LIKE %s AND sale_date LIKE %s"
        cursor.execute(query, (f"%{store_name}%", f"%{date}%"))
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        display_table_with_search_option(results, headers, "Sales", connection)


def search_transactions(connection, first_name, last_name, date):
    """Search for transactions based on customer or date."""
    with connection.cursor() as cursor:
        query = query = """
            SELECT t.* 
            FROM Transaction t
            JOIN Customer c ON t.customer_id = c.customer_id
            WHERE c.first_name LIKE %s AND c.last_name LIKE %s AND t.date LIKE %s
        """
        try:
            cursor.execute(query, (f"%{first_name}%", f"%{last_name}%", f"%{date}%"))
            results = cursor.fetchall()
            headers = [desc[0] for desc in cursor.description]
            display_table_with_search_option(results, headers, "Transactions", connection)
        except Exception as e:
            print(f"Error occurred while searching transactions: {e}")


def search_employees(connection, store_name):
    """Search for employees by store."""
    with connection.cursor() as cursor:
        query = "SELECT * FROM Employee WHERE store_name LIKE %s"
        cursor.execute(query, (f"%{store_name}%",))
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        display_table_with_search_option(results, headers, "Employee", connection)


def search_customer(connection, first_name, last_name):
    """Search for customers by name."""
    with connection.cursor() as cursor:
        query = "SELECT * FROM Customer WHERE first_name LIKE %s AND last_name LIKE %s"
        cursor.execute(query, (f"%{first_name}%", f"%{last_name}%"))
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        display_table_with_search_option(results, headers, "Customer", connection)
