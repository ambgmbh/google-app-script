import csv
import numpy as np
import random

# Geographische Grenzen für Deutschland
MIN_LAT = 47.2701
MAX_LAT = 55.0992
MIN_LON = 5.8663
MAX_LON = 15.0419

def is_within_germany(lat, lon):
    return MIN_LAT <= lat <= MAX_LAT and MIN_LON <= lon <= MAX_LON

# Funktion zum Erzeugen von zufälligen GPS-Koordinaten innerhalb der Grenzen Deutschlands
def generate_random_coords_within_bounds(center_lat, center_lon, radius_km, num_points):
    coords = []
    while len(coords) < num_points:
        # Zufällige Distanz und Richtung erzeugen
        distance = random.uniform(0, radius_km)
        angle = random.uniform(0, 2 * np.pi)
        
        # Neue Koordinaten berechnen
        lat1, lon1 = np.radians(center_lat), np.radians(center_lon)
        lat2 = np.arcsin(np.sin(lat1) * np.cos(distance / 6371.0) +
                         np.cos(lat1) * np.sin(distance / 6371.0) * np.cos(angle))
        lon2 = lon1 + np.arctan2(np.sin(angle) * np.sin(distance / 6371.0) * np.cos(lat1),
                                 np.cos(distance / 6371.0) - np.sin(lat1) * np.sin(lat2))
        
        lat2, lon2 = np.degrees(lat2), np.degrees(lon2)
        
        # Überprüfen, ob die Koordinaten innerhalb Deutschlands liegen
        if is_within_germany(lat2, lon2):
            coords.append((lat2, lon2))
    
    return coords
# Creating all Gpskoordinates in 10 KM Distaine per GPS Point
