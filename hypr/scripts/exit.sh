#!/bin/bash
# -------------------------------------------
# Addition by Krister Dahl (2024). Set sddm login screen to current wallpaper at hypr logout.
sudo /home/USER/dotfiles/sddm/updatesddm.sh
# -------------------------------------------
sleep 1
killall -9 Hyprland sleep 2

