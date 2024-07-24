// Erzeugen der Datenbank
CREATE DATABASE count;

// ERzeugen der Tabelle devices 

  CREATE TABLE devices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ipv6_address VARCHAR(39) NOT NULL,
    serial_number VARCHAR(100) NOT NULL,
    cpu VARCHAR(100) NOT NULL,
    ram VARCHAR(100) NOT NULL,
    connection_types VARCHAR(255) NOT NULL,
    sd_card VARCHAR(100) NOT NULL,
    usb_ports INT NOT NULL,
    hdmi_ports INT NOT NULL,
    ethernet_port BOOLEAN NOT NULL,
    wifi BOOLEAN NOT NULL,
    bluetooth BOOLEAN NOT NULL,
    power_supply VARCHAR(100) NOT NULL,
    operating_system VARCHAR(100) NOT NULL
);

// Erzeuge device_location
// Die Adresse des Gerätes ist immer auf Bezug einer öffentlichen Einrichtung angegeben
// Es dürfen keine privatadressen angegeben werden. 
  
USE count;

CREATE TABLE device_locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    device_id INT NOT NULL,
    location_name VARCHAR(255) NOT NULL,
    device_name VARCHAR(255) NOT NULL,
    gps_latitude DECIMAL(10, 7) NOT NULL,
    gps_longitude DECIMAL(10, 7) NOT NULL,
    distance_km DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (device_id) REFERENCES devices(id)
);

-- Beispiel-Datensatz einfügen
INSERT INTO device_locations (device_id, location_name, device_name, gps_latitude, gps_longitude, distance_km)
VALUES (1, 'Berlin', 'Raspberry Pi 4', 52.5200, 13.4050, 0.00);

-- Anzeigen der erstellten Tabelle
SHOW TABLES;

-- Anzeigen der Struktur der Tabelle
DESCRIBE device_locations;

