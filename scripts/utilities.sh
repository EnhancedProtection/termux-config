#!/bin/bash
#========================================
# Android Root Utility Tool
# Features:
#   1. Clear cache of all user-installed apps
#   2. Force-stop all user-installed apps except Termux
#   3. Toggle Wireless ADB on/off
#========================================

# Ensure script is running as root (id -u == 0)
if [[ $(id -u) -ne 0 ]]; then
    echo "[!] Please run this script as root (su)."
    exit 1
fi

# Use Android's system binaries explicitly
PATH=/system/bin

# Get list of user-installed package names
USER_PACKAGES=$(pm list packages -3 | cut -d: -f2)

#-----------------------------
# Force-stop all user-installed apps (except Termux)
force_stop_apps() {
    for pkg in $USER_PACKAGES; do
        if [[ "$pkg" == "com.termux" ]]; then
            echo "[SKIP] $pkg"
        else
            echo "[KILL] $pkg"
            am force-stop "$pkg"
        fi
    done
}

#-----------------------------
# Clear cache for all user-installed apps
clear_app_cache() {
    for pkg in $USER_PACKAGES; do
        echo "[CACHE CLEAR] $pkg"
        pm clear --cache-only "$pkg" 2>/dev/null
    done
}

#-----------------------------
# Toggle Wireless ADB on port 5555
toggle_wireless_adb() {
    local current_port
    current_port=$(getprop service.adb.tcp.port)

    if [[ "$current_port" != "5555" ]]; then
        echo "[ADB] Enabling Wireless ADB on port 5555"
        setprop service.adb.tcp.port 5555
    else
        echo "[ADB] Disabling Wireless ADB"
        setprop service.adb.tcp.port 0
    fi

    stop adbd && start adbd
}

#-----------------------------
# Menu
show_menu() {
    printf "\ec"
    echo "============================="
    echo "   Android Root Utility Tool  "
    echo "============================="
    echo "1) Clear App Cache"
    echo "2) Force-Stop Apps"
    echo "3) Toggle Wireless ADB"
    echo "0) Exit"
    echo "-----------------------------"
}

#-----------------------------
# Main loop
show_menu
read -rp "Select an option: " choice

case $choice in
    0) echo "Bye!" ;;
    1) clear_app_cache ;;
    2) force_stop_apps ;;
    3) toggle_wireless_adb ;;
    *) echo "[!] Invalid selection. Exiting." ;;
esac
