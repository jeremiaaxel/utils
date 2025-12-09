# CachySwapKey

A simple utility script to toggle `hid_apple` configuration between **Rexus Daxa M71** and **Zuoya GMK67** keyboards on CachyOS (or Arch-based systems).

## Features
- Toggles `fnmode` between `1` (Rexus) and `2` (Zuoya).
- Automatically updates initramfs and reloads the `hid_apple` module.
- Installation script for easy global access.

## Installation

1. Clone or download this repository.
2. Run the setup script:
   ```bash
   sudo ./setup.sh
   ```
3. Follow the prompt to either **link** or **copy** the script to `/usr/local/bin/switch_kb`.

## Usage

Once installed, you can simply run:

```bash
switch_kb
```

The script will:
1. Detect the current configuration in `/etc/modprobe.d/hid_apple.conf`.
2. Toggle to the other keyboard mode.
3. Run `update-initramfs -u`.
4. Reload the kernel module.

## Configuration Details

It swaps between these two states in `/etc/modprobe.d/hid_apple.conf`:

**Rexus Mode:**
```bash
options hid_apple fnmode=1
#options hid_apple fnmode=2
```

**Zuoya Mode:**
```bash
#options hid_apple fnmode=1
options hid_apple fnmode=2
```

## Requirements
- `sudo` privileges.
- `update-initramfs` (or compatible initramfs updater on your distro).
- `hid_apple` kernel module.
