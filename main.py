import pymysql

from read import read_data_menu
from update import update_data_menu

database_name = 'inventory_management'


def connect_to_database():
    """Connect to the MySQL database."""
    while True:
        username = input("Enter MySQL username: ").strip()
        password = input("Enter MySQL password: ").strip()
        try:
            conn = pymysql.connect(host='localhost',
                                   user=username,
                                   password=password,
                                   database=database_name)
            print("Connection successful!")
            return conn
        except pymysql.MySQLError as e:
            print(f"Error connecting to database: {e}.")
            retry = input("Would you like to try again? (y/n): ").strip().lower()
            if retry != 'y':
                print("Exiting the program.")
                exit(1)  # Exit if user does not want to retry

def main():
    """The main function that connects to the database and initiates the menu handling."""
    connection = connect_to_database()

    try:
        while True:
            print("\n--- Database Management Menu ---")
            print("1. Create Data")
            print("2. Read Data")
            print("3. Update Data")
            print("4. Delete Data")
            print("5. Exit")
            choice = input("Enter your choice: ")

            # if choice == '1':
            #     create_data_menu(connection)
            if choice == '2':
                read_data_menu(connection)
            elif choice == '3':
                update_data_menu(connection)
            # elif choice == '4':
            #     delete_data_menu(connection)
            elif choice == '5':
                print("Exiting the program.")
                break
            else:
                print("Invalid choice. Please try again.")
    finally:
        if connection:
            connection.close()
            print("Disconnected from database.")

if __name__ == "__main__":
    main()
