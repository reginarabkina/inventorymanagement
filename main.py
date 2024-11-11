import pymysql

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
            print("Please try again.")

def main():
    """The main function that connects to the database and initiates the menu handling."""
    global connection
    connection = connect_to_database()

    try:
        print("hello")
    finally:
        if connection:
            connection.close()
            print("Disconnected from database.")


if __name__ == "__main__":
    main()
