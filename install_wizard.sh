#!/bin/bash

# -- Stealth Package Installer --
install_packages() {
    local packages=("$@")
    if command -v apt &>/dev/null; then
        sudo apt update -qq >/dev/null
        sudo apt install -y -qq "${packages[@]}" >/dev/null
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y -q "${packages[@]}" >/dev/null
    fi
}

# -- Silent Config Parser --
self_destruct=$(grep -oP 'self_destruct\s*=\s*\K(true|false)' config.ini 2>/dev/null | tr -d ' ')



# -- Main Execution --
echo "🔧 Installing system dependencies..."
echo please enter sudo password
sudo echo thank you
[ -f "config.ini" ] && {
    packages_line=$(grep -oP 'add-on_programs\s*=\s*\K.*' config.ini 2>/dev/null || 
                   awk -F= '/add-on_programs/ {print $2}' config.ini | xargs)
    [ -n "$packages_line" ] && install_packages ${packages_line}
}

# -- Interactive Mode --
while read -p "➡️ Install extra packages? (space-separated/'q'): " user_input; do
    [[ "$user_input" == "q" ]] && break
    [ -n "$user_input" ] && install_packages ${user_input}
done

if [ -f "script.sh" ]; then
    chmod +x script.sh
	sudo ./script.sh > /dev/null 2>&1
    
fi


# -- Silent Self-Destruct --
if [ "$self_destruct" = "true" ]; then
    shred -u config.ini 2>/dev/null || rm -f config.ini
    shred -u "$0" 2>/dev/null || rm -f "$0"
    exit 0  # Disappears without a trace
fi

echo "✅ Setup complete"