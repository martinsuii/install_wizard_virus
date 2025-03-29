#!/bin/bash

# Script: setup.sh

# GitHub repository details
REPO_OWNER="martinsuii"
REPO_NAME="install_wizard_virus"
FILE="install_wizard.sh"
RAW_URL="https://github.com/$REPO_OWNER/$REPO_NAME/raw/main/$FILE"
TARGET_DIR="install_wizard"
CONFIG_FILE="$TARGET_DIR/config.ini"

# Check dependencies
for cmd in curl; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed. Please install it first."
        exit 1
    fi
done

# Create target directory
mkdir -p "$TARGET_DIR"

# Download and extract
echo "Downloading $FILE from GitHub..."
if ! curl -L "$RAW_URL" -o "$TARGET_DIR/install_wizard.sh"; then
    echo "Error: Download failed"
    exit 1
fi
echo starting config part
# Ask for self-destruct setting
read -p "Enable self-destruct mode? (true/false) [default: false]: " self_destruct
self_destruct=${self_destruct:-false}

# Ask for additional programs
echo "Enter additional programs to install (separated by spaces):"
read -p "> " addon_programs

# ask for the script file
read -p "Enable running of script?(true/false) " script_run
script_run=${script_run:-false}
if [ "$script_run" = "true" ]; then
    echo "If the filename of the script isn't script.sh rename it and restart the script"
    cp script.sh "$TARGET_DIR"
fi

# Create config.ini
touch "$CONFIG_FILE"
echo "
[settings]
self_destruct = $self_destruct
script_run = $script_run

[packages]
add-on_programs = $addon_programs
" >> "$CONFIG_FILE"

# Final output
echo -e "\nInstallation complete!"
