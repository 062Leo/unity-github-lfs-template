# Dieses Skript erstellt eine liste aller Dateitypen die in dem Verzeichniss zu finden sind, indem sich dieses skript befindet


import os

# Pfad des aktuellen Ordners (wo das Skript liegt)
folder = os.path.dirname(os.path.abspath(__file__))

# Set für eindeutige Endungen
extensions = set()

# Alle Dateien rekursiv durchsuchen
for root, dirs, files in os.walk(folder):
    for file in files:
        ext = os.path.splitext(file)[1]  # Dateiendung inklusive Punkt
        if ext:
            extensions.add(ext.lower())  # optional: alles klein schreiben

# Ausgabe sortiert
for ext in sorted(extensions):
    print(ext)
