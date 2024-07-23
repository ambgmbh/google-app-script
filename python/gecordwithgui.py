import tkinter as tk
from tkinter import messagebox
import csv
import numpy as np
import random
from geopy.geocoders import Nominatim

# Geographische Grenzen für Deutschland
MIN_LAT = 47.2701
MAX_LAT = 55.0992
MIN_LON = 5.8663
MAX_LON = 15.0419

# Funktion zum Überprüfen, ob die Koordinaten innerhalb Deutschlands liegen
def is_within_germany(lat, lon):
    return MIN_LAT <= lat <= MAX_LAT and MIN_LON <= lon <= MAX_LON

# Funktion zum Erzeugen von zufälligen GPS-Koordinaten innerhalb der Grenzen Deutschlands
def generate_random_coords_within_bounds(center_lat, center_lon, radius_km, num_points):
    coords = []
    while len(coords) < num_points:
        distance = random.uniform(0, radius_km)
        angle = random.uniform(0, 2 * np.pi)
        lat1, lon1 = np.radians(center_lat), np.radians(center_lon)
        lat2 = np.arcsin(np.sin(lat1) * np.cos(distance / 6371.0) +
                         np.cos(lat1) * np.sin(distance / 6371.0) * np.cos(angle))
        lon2 = lon1 + np.arctan2(np.sin(angle) * np.sin(distance / 6371.0) * np.cos(lat1),
                                 np.cos(distance / 6371.0) - np.sin(lat1) * np.sin(lat2))
        lat2, lon2 = np.degrees(lat2), np.degrees(lon2)
        if is_within_germany(lat2, lon2):
            coords.append((lat2, lon2))
    return coords

# Funktion zum Speichern der Koordinaten in Blöcken von 5000 Zeilen
def save_coordinates_in_blocks(coords, block_size=5000):
    for i in range(0, len(coords), block_size):
        block = coords[i:i + block_size]
        filename = f'gps_coordinates_{i // block_size + 1}.csv'
        with open(filename, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(['Latitude', 'Longitude'])
            writer.writerows(block)
        print(f"Gespeichert: {filename}")

# Funktion zur Verarbeitung der Eingaben und Start der Generierung
def process_inputs():
    city = city_entry.get()
    radius_km = int(radius_entry.get())
    
    geolocator = Nominatim(user_agent="geoapiExercises")
    location = geolocator.geocode(city)
    
    if location:
        center_lat, center_lon = location.latitude, location.longitude
        coordinates = generate_random_coords_within_bounds(center_lat, center_lon, radius_km, 100000)
        save_coordinates_in_blocks(coordinates, block_size=5000)
        messagebox.showinfo("Erfolg", "GPS-Koordinaten erfolgreich generiert und gespeichert.")
    else:
        messagebox.showerror("Fehler", "Stadt nicht gefunden. Bitte überprüfen Sie die Eingabe.")

# GUI erstellen
root = tk.Tk()
root.title("GPS-Koordinaten-Generator")

tk.Label(root, text="Stadt:").grid(row=0, column=0, padx=10, pady=10)
city_entry = tk.Entry(root)
city_entry.grid(row=0, column=1, padx=10, pady=10)

tk.Label(root, text="Radius (km):").grid(row=1, column=0, padx=10, pady=10)
radius_entry = tk.Entry(root)
radius_entry.grid(row=1, column=1, padx=10, pady=10)

start_button = tk.Button(root, text="Start", command=process_inputs)
start_button.grid(row=2, columnspan=2, padx=10, pady=10)

root.mainloop()
