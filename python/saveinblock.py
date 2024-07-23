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

def save_coordinates_in_blocks(coords, block_size=5000):
    for i in range(0, len(coords), block_size):
        block = coords[i:i + block_size]
        filename = f'gps_coordinates_{i // block_size + 1}.csv'
        with open(filename, 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerow(['Latitude', 'Longitude'])
            writer.writerows(block)
        print(f"Gespeichert: {filename}")

def main():
    center_lat, center_lon = 51.1657, 10.4515  # Zentrum von Deutschland
    radius_km = 10  # Radius in Kilometern
    num_points = 100000  # Anzahl der zu erzeugenden Punkte
    
    coordinates = generate_random_coords_within_bounds(center_lat, center_lon, radius_km, num_points)
    
    save_coordinates_in_blocks(coordinates, block_size=5000)

if __name__ == "__main__":
    main()
