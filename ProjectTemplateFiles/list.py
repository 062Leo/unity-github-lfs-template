# This script creates a list of all file types found in the directory where this script is located


import os

# Path of the current folder (where the script is located)
folder = os.path.dirname(os.path.abspath(__file__))

# Set for unique extensions
extensions = set()

# Recursively search all files
for root, dirs, files in os.walk(folder):
    for file in files:
        ext = os.path.splitext(file)[1]  # File extension including dot
        if ext:
            extensions.add(ext.lower())  # optional: convert everything to lowercase

# Output sorted
for ext in sorted(extensions):
    print(ext)
