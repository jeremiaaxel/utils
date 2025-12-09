#!/bin/bash

# Configuration file path
CONF_FILE="/etc/modprobe.d/hid_apple.conf"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  sudo "$0" "$@"
  exit
fi

# Function to set Rexus mode
set_rexus() {
    echo "Switching to Rexus Daxa M71 mode (fnmode=1)..."
    cat > "$CONF_FILE" <<EOF
# Rexus
options hid_apple fnmode=1
# Zuoya GMK
#options hid_apple fnmode=2
EOF
}

# Function to set Zuoya mode
set_zuoya() {
    echo "Switching to Zuoya GMK67 mode (fnmode=2)..."
    cat > "$CONF_FILE" <<EOF
# Rexus
#options hid_apple fnmode=1
# Zuoya GMK
options hid_apple fnmode=2
EOF
}

# Check current state and toggle
if grep -q "^options hid_apple fnmode=2" "$CONF_FILE"; then
    # Currently Zuoya, switch to Rexus
    set_rexus
else
    # Default/Assume Rexus or other, switch to Zuoya
    set_zuoya
fi

# Apply changes
echo "Updating initramfs..."
update-initramfs -u

echo "Reloading hid_apple module..."
modprobe -r hid_apple
modprobe hid_apple

echo "Done!"
