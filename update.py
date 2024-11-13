from tabulate import tabulate


def format_and_display_table(results, headers):
    """Formats and displays query results in a table format."""
    print(tabulate(results, headers=headers, tablefmt="grid"))


def display_menu():
    """Displays a categorized menu."""
    print("\n--- Update Data Menu ---")
    print("\n[1] Sales Data")
    print("  1.1 Update Sales Performance")
    print("\n[2] Inventory Data")
    print("  2.1 Update Product Availability")
    print("  2.2 Update Inventory Levels")
    print("\n[3] Customer Data")
    print("  3.1 Update Customer Information")
    print("\n[4] Employee Data")
    print("  4.1 Update Employee Information")
    print("\n0. Exit")


def update_data_menu(connection):
    """Menu for updating data in various tables."""
    while True:
        display_menu()
        choice = input("\nEnter your choice: ")

        if choice == '1.1':
            print()
        elif choice == '2.1':
            print()
            # update_product_availability(connection)
        elif choice == '2.2':
            print()
            # update_inventory_levels(connection)
        elif choice == '3.1':
            print()
            update_customer_info(connection)
        elif choice == '4.1':
            print()
            # update_employee_info(connection)
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


def update_customer_info(connection):
    """Prompts the user to select a customer and update their information."""
    # First, search for the customer
    customer_id = search_customer(connection)
    if customer_id is None:
        return

    # Now, prompt the user to update the customer details
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

        # If the email exists and it's not the current customer, raise an error
        if existing_customer and existing_customer[0] != customer_id:
            print(f"Error: The email '{email}' is already associated with another customer.")
            return

        # Call the stored procedure to update the customer details
        cursor.callproc('UpdateCustomer', [
            customer_id, first_name, last_name, email, street, city, state, zipcode
        ])
        connection.commit()
        # Confirm the update
        print(f"Customer {first_name} {last_name} (ID: {customer_id}) updated successfully!")

    except Exception as e:
        print(f"Error occurred: {e}")
        connection.rollback()
