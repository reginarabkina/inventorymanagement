import pymysql

from read import read_data_menu
from update import update_data_menu
from create import create_data_menu
from delete import delete_data_menu

database_name = 'inventory_management'

USERS = {
    'admin': {'password': 'adminpass', 'role': 'admin'},
    'manager': {'password': 'managerpass', 'role': 'manager'},
    'user': {'password': 'userpass', 'role': 'user'}
}


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
                exit(1)


def authenticate_user():
    """Authenticate the user based on the predefined USER database."""
    while True:
        username = input("Enter your username: ").strip()
        password = input("Enter your password: ").strip()

        if username in USERS and USERS[username]['password'] == password:
            print(f"Welcome {username}!")
            return USERS[username]['role']
        else:
            print("Invalid credentials. Please try again.")
            retry = input("Would you like to try again? (y/n): ").strip().lower()
            if retry != 'y':
                print("Exiting the program.")
                exit(1)


def main():
    """The main function that connects to the database and initiates the menu handling."""
    connection = connect_to_database()
    user_role = authenticate_user()

    try:
        while True:
            print("\n--- Database Management Menu ---")

            # Show menu options based on user role
            if user_role == 'admin':
                print("1. Create Data")
                print("2. Read Data")
                print("3. Update Data")
                print("4. Delete Data")
                print("5. Exit")

            elif user_role == 'manager':
                print("2. Read Data")
                print("3. Update Data")
                print("5. Exit")

            elif user_role == 'user':
                print("2. Read Data")
                print("5. Exit")

            choice = input("Enter your choice: ")

            if choice == '1' and user_role == 'admin':
                create_data_menu(connection)
            elif choice == '2':
                read_data_menu(connection)
            elif choice == '3' and user_role in ['admin', 'manager']:
                update_data_menu(connection)
            elif choice == '4' and user_role == 'admin':
                delete_data_menu(connection)
            elif choice == '5':
                print("Exiting the program.")
                break
            else:
                print("Invalid choice or insufficient permissions. Please try again.")
    finally:
        if connection:
            connection.close()
            print("Disconnected from database.")


if __name__ == "__main__":
    main()
