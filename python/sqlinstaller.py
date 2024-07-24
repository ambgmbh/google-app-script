import mysql.connector
from mysql.connector import errorcode

# Konfigurationsparameter
config = {
    'user': 'root',
    'password': 'dein_root_passwort',  # Gib hier das root Passwort ein
    'host': '192.168.34.1',  # Setze hier die IP-Adresse deines MariaDB-Servers ein
    'port': '3306'  # Setze hier den Port deines MariaDB-Servers ein
}

# SQL Statements zur Erstellung der Datenbank und Tabellen
CREATE_DATABASE = "CREATE DATABASE IF NOT EXISTS count"
USE_DATABASE = "USE count"

CREATE_DEVICES_TABLE = """
CREATE TABLE IF NOT EXISTS devices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ip_address VARCHAR(39) NOT NULL,  -- IPV6 max Länge
    serial_number VARCHAR(100) NOT NULL,
    cpu VARCHAR(100),
    ram VARCHAR(100),
    connection_types VARCHAR(255),
    sd_card VARCHAR(100)  -- Eingabefeld
);
"""

CREATE_DEVICE_LOCATIONS_TABLE = """
CREATE TABLE IF NOT EXISTS device_locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    device_id INT NOT NULL,
    location_name VARCHAR(255) NOT NULL,
    device_name VARCHAR(255) NOT NULL,
    gps_latitude DECIMAL(10, 7) NOT NULL,
    gps_longitude DECIMAL(10, 7) NOT NULL,
    distance_km DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (device_id) REFERENCES devices(id)
);
"""

def create_database(cursor):
    try:
        cursor.execute(CREATE_DATABASE)
        cursor.execute(USE_DATABASE)
    except mysql.connector.Error as err:
        print(f"Fehler bei der Erstellung der Datenbank: {err}")
        exit(1)

def create_tables(cursor):
    try:
        cursor.execute(CREATE_DEVICES_TABLE)
        cursor.execute(CREATE_DEVICE_LOCATIONS_TABLE)
    except mysql.connector.Error as err:
        print(f"Fehler bei der Erstellung der Tabellen: {err}")
        exit(1)

def main():
    try:
        cnx = mysql.connector.connect(**config)
        cursor = cnx.cursor()

        create_database(cursor)
        create_tables(cursor)

        cursor.close()
        cnx.close()
        print("Die Datenbank und Tabellen wurden erfolgreich erstellt.")

    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Fehler: Ungültiger Benutzername oder Passwort")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Fehler: Datenbank existiert nicht")
        else:
            print(err)

if __name__ == "__main__":
    main()
