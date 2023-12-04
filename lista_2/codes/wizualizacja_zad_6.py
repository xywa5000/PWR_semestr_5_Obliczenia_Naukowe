import pandas as pd
import matplotlib.pyplot as plt

# Wczytaj dane z pliku CSV
file_path = 'dane.csv'  # Zmień ścieżkę do pliku na odpowiednią
data = pd.read_csv(file_path, delimiter=';')

# Utwórz wykres
plt.plot(data['n'], data['value'], marker='o', linestyle='-')
plt.grid(True, linestyle='--', alpha=1)

# Dodaj tytuł i etykiety osi
plt.title('Results for (c = -1.0, x = 0.25):')
plt.xlabel('n')
plt.ylabel('value')

# Wyświetl wykres
plt.show()
