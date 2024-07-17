#!/bin/bash

source "install-scripts/global_functions.sh"

if ask_yes_no "Do you want to install?"; then
    sudo pacman -S --noconfirm bluetoothctl
    sleep 1
    if ask_yes_no "'scan on' and then 'pair MAC_address'. Ready to connect bluetooth devices?"; then
        bluetoothctl
        systemctl enable bluetooth.service
        systemctl start bluetooth.service
    fi
fi
