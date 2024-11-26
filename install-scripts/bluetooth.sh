#!/bin/bash

source "install-scripts/global_functions.sh"

# if ask_yes_no "Do you want to install Bluetooth utils?"; then
    sleep 1
    if ask_yes_no "'scan on' and then 'pair MAC_address'. Or use Ready to connect bluetooth devices?"; then
        systemctl enable bluetooth.service
        systemctl start bluetooth.service
        bluetoothctl
    fi
# fi
