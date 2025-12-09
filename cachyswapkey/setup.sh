#!/bin/bash

TARGET="/usr/local/bin/switch_kb"
SOURCE="$(pwd)/switch_kb.sh"

echo "Setup script for Switch Keyboard"
echo "------------------------------"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  sudo "$0" "$@"
  exit
fi

echo "Source script: $SOURCE"
echo "Target location: $TARGET"
echo ""
echo "Do you want to (l)ink or (c)opy the script? [l/c]"
read -r choice

if [[ "$choice" == "l" || "$choice" == "L" ]]; then
    echo "Creating symbolic link..."
    ln -sf "$SOURCE" "$TARGET"
elif [[ "$choice" == "c" || "$choice" == "C" ]]; then
    echo "Copying script..."
    cp "$SOURCE" "$TARGET"
else
    echo "Invalid choice. Aborting."
    exit 1
fi

echo "Making target executable..."
chmod +x "$TARGET"

echo "Done! You can now run 'switch_kb' from anywhere."
