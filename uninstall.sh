#!/bin/bash
#  _   _       _           _        _ _  
# | | | |_ __ (_)_ __  ___| |_ __ _| | | 
# | | | | '_ \| | '_ \/ __| __/ _` | | | 
# | |_| | | | | | | | \__ \ || (_| | | | 
#  \___/|_| |_|_|_| |_|___/\__\__,_|_|_| 
#                                        
#  
# by Krister Dahl (2024) 
# ---------------------------------------------------- 

echo "This script will uninstall wallpaper integration and  restore all changed files to its original state. Do you want to continue y/n"

read state
if [[ $state == y* ]]; then
    rm $HOME/dotfiles/hypr/scripts/exit.sh
    mv $HOME/dotfiles/hypr/scripts/exit.sh.backup $HOME/dotfiles/hypr/scripts/exit.sh
    rm $HOME/dotfiles/qtile/scripts/wallpaper.sh
    mv $HOME/dotfiles/qtile/scripts/wallpaper.sh.backup $HOME/dotfiles/qtile/scripts/wallpaper.sh
    rm $HOME/dotfiles/hypr/hyprlock.conf
    mv $HOME/dotfiles/hypr/hyprlock.conf.backup $HOME/dotfiles/hypr/hyprlock.conf
    rm $HOME/dotfiles/sddm/updatesddm.sh
    sudo systemctl stop setsddmwall.service
    sudo systemctl disable setsddmwall.service
    sudo rm /etc/systemd/system/setsddmwall.service
    sudo systemctl daemon-reload
    sudo sed -i '/updatesddm/d' /etc/sudoers
    read -p "All files restored to its original state. Please reboot your computer. Press enter to exit."
else
    read -p "Ok. Press enter to exit."
fi
exit
