#!/bin/bash


### Disable wifi powersave mode ###
LOC="/etc/NetworkManager/conf.d/wifi-powersave.conf"
echo -e "The following has been added to $LOC.\n"
echo -e "[connection]\nwifi.powersave = 2" | sudo tee -a $LOC
echo -e "\n"
echo -e "Restarting NetworkManager service...\n"
systemctl restart NetworkManager
sleep 1

systemctl enable NetworkManager.service
systemctl start NetworkManager.service
