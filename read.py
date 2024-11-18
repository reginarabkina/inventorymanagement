from tabulate import tabulate

from search import search_data


def format_and_display_table(results, headers):
    """Formats and displays query results in a table format."""
    print(tabulate(results, headers=headers, tablefmt="grid"))


def display_menu():
    """Displays a categorized menu."""
    print("\n--- Read Data Menu ---")
    print("\n[1] Sales Reports")
    print("  1.1 Top-Selling Products")
    print("  1.2 Store Sales Performance")
    print("  1.3 Yearly Sales Breakdown")
    print("\n[2] Inventory Reports")
    print("  2.1 Product Availability")
    print("  2.2 Store Inventory Value")
    print("  2.3 Low Inventory Alert")
    print("  2.4 Inventory Movement (Stock In/Out)")
    print("\n[3] Customer Reports")
    print("  3.1 Customer Total Spending")
    print("  3.2 Transaction Details")
    print("\n[4] Employee Reports")
    print("  4.1 Store Employee List")
    print("\n[5] Search")
    print("\n0. Back to Main Menu")


def read_data_menu(connection):
    """Menu for reading data from various tables."""
    while True:
        display_menu()
        choice = input("\nEnter your choice: ")

        if choice == '1.1':
            view_top_selling_products(connection)
        elif choice == '1.2':
            view_store_sales_performance(connection)
        elif choice == '1.3':
            view_yearly_sales_breakdown(connection)
        elif choice == '2.1':
            view_product_availability(connection)
        elif choice == '2.2':
            view_store_inventory_value(connection)
        elif choice == '2.3':
            print()
            view_low_inventory_alert(connection)
        elif choice == '2.4':
            print()
            view_inventory_movement(connection)
        elif choice == '3.1':
            view_customer_transaction_spending(connection)
        elif choice == '3.2':
            search_customer_and_get_transaction_details(connection)
        elif choice == '4.1':
            view_employees_at_store(connection)
        elif choice == '5':
            search_data(connection)
        elif choice == '0':
            print("Exiting menu.")
            break  # Exit the loop
        else:
            print("Invalid choice. Please try again.")

        # Asks user if they want to continue in the current menu or return to the main menu
        user_input = input(
            "\nWould you like to go back to the current menu? (y) or return to the main menu? (m): ").strip().lower()

        if user_input == 'm':
            break # Navigates to the main menu
        elif user_input != 'y':
            print("Invalid input. Exiting to the main menu.")
            break


def view_store_sales_performance(connection):
    with connection.cursor() as cursor:
        cursor.callproc("ViewStoreSalesPerformance")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- Sales Performance By Store ---")
        format_and_display_table(results, headers)


def view_yearly_sales_breakdown(connection):
    with connection.cursor() as cursor:
        cursor.callproc("ViewYearlySalesBreakdown")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- Yearly Sales Breakdown ---")
        format_and_display_table(results, headers)


def view_store_inventory_value(connection):
    with connection.cursor() as cursor:
        cursor.callproc("CreateStoreInventoryValueView")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- Store Inventory Value ---")
        format_and_display_table(results, headers)


def view_customer_transaction_spending(connection):
    with connection.cursor() as cursor:
        cursor.callproc("CreateCustomerSpendingView")
        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]
        print("\n--- Customer Total Transaction Spending ---")
        format_and_display_table(results, headers)


def view_top_selling_products(connection):
    """View top-selling products based on user input."""
    try:
        top_n = int(input("Enter the number of top-selling products you want to view (e.g., 5, 10, etc.): ").strip())

        if top_n <= 0:
            print("Please enter a positive integer greater than 0.")
            return

        # Call the stored procedure with the top_n parameter
        with connection.cursor() as cursor:
            cursor.callproc("ViewTopSellingProduct", [top_n])
            results = cursor.fetchall()
            headers = [desc[0] for desc in cursor.description]

        # Display the result in a tabular format
        print(f"\n--- Top {top_n} Selling Products ---")
        format_and_display_table(results, headers)

    except ValueError:
        print("Invalid input. Please enter a valid integer.")


def view_product_availability(connection):
    product_name = input("Enter product name to search (or press Enter to see all products): ").strip()

    with connection.cursor() as cursor:
        if product_name:
            cursor.callproc("CreateProductAvailabilityView", [product_name])
        else:
            cursor.callproc("CreateProductAvailabilityView", [None])

        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]

        print("\n--- Product Availability ---")
        format_and_display_table(results, headers)


def view_low_inventory_alert(connection):
    threshold = input("Enter threshold: ").strip()

    with connection.cursor() as cursor:
        if threshold:
            cursor.callproc("ViewLowInventoryAlert", [threshold])
        else:
            cursor.callproc("ViewLowInventoryAlert", [None])

        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]

        print("\n--- Low Inventory Alert ---")
        format_and_display_table(results, headers)


def view_employees_at_store(connection):
    store_name = input("Enter store name to search (or press Enter to see all stores): ").strip()

    with connection.cursor() as cursor:
        if store_name:
            cursor.callproc("ListEmployeesByStoreName", [store_name])
        else:
            cursor.callproc("ListEmployeesByStoreName", [None])

        results = cursor.fetchall()
        headers = [desc[0] for desc in cursor.description]

        print("\n--- Employees Working At Store ---")
        format_and_display_table(results, headers)


def view_inventory_movement(connection):
    """Display inventory movement for a date range."""
    try:
        start_date = input("Enter start date (YYYY-MM-DD): ").strip()
        end_date = input("Enter end date (YYYY-MM-DD): ").strip()

        if not start_date or not end_date:
            print("Both start date and end date are required.")
            return

        with connection.cursor() as cursor:
            cursor.callproc("ViewInventoryMovement", [start_date, end_date])
            results = cursor.fetchall()
            headers = [desc[0] for desc in cursor.description]

        print(f"\n--- Inventory Movement from {start_date} to {end_date} ---")
        format_and_display_table(results, headers)

    except Exception as e:
        print(f"An error occurred: {e}")


def get_customer_id_by_name(connection, first_name, last_name):
    """Fetch customer ID by name."""
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT customer_id
            FROM Customer
            WHERE first_name = %s AND last_name = %s
        """, (first_name, last_name))

        result = cursor.fetchone()
        if result:
            return result[0]
        else:
            print("Customer not found.")
            return None


def get_customer_transaction_details(connection, customer_id, transaction_date):
    """Fetch transaction details for a customer on a given transaction date."""
    try:
        with connection.cursor() as cursor:
            cursor.callproc("GetCustomerTransactionDetails", [customer_id, transaction_date])

            results = cursor.fetchall()
            headers = [desc[0] for desc in cursor.description]

            if results:
                print(f"\n--- Transaction Details for Customer ID {customer_id} on {transaction_date} ---")
                format_and_display_table(results, headers)
            else:
                print(f"No transactions found for Customer ID {customer_id} on {transaction_date}.")

    except Exception as e:
        print(f"An error occurred: {e}")


def search_customer_and_get_transaction_details(connection):
    """Search for a customer and then retrieve transaction details."""
    first_name = input("Enter customer's first name: ").strip()
    last_name = input("Enter customer's last name: ").strip()

    customer_id = get_customer_id_by_name(connection, first_name, last_name)

    if customer_id:
        transaction_date = input("Enter the transaction date (YYYY-MM-DD): ").strip()
        get_customer_transaction_details(connection, customer_id, transaction_date)
