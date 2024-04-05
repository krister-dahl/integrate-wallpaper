#!/bin/bash
# __        __    _ _                              
# \ \      / /_ _| | |_ __   __ _ _ __   ___ _ __  
#  \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#   \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#    \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                    |_|         |_|               
#  ___       _                       _   _              
# |_ _|_ __ | |_ ___  __ _ _ __ __ _| |_(_) ___  _ __   
#  | || '_ \| __/ _ \/ _` | '__/ _` | __| |/ _ \| '_ \  
#  | || | | | ||  __/ (_| | | | (_| | |_| | (_) | | | | 
# |___|_| |_|\__\___|\__, |_|  \__,_|\__|_|\___/|_| |_| 
#                    |___/                              
#  
# by Krister Dahl (2024) 
# ---------------------------------------------------- 

echo "All files changed by this script will be backed up (.backup). Lets begin to set your username. Whats your username?"

read username
 
function confirm() {
    while true; do
        read -p "Your username is $username. If this is correct, do you want to continue?  (YES/NO) " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) exit;;
            * ) echo "Please answer YES or NO.";;
        esac
    done
}
 
if confirm; then
    echo "User chose YES. Executing the operation..."
    find service/ -name '*.service' -exec sed -i "s/USER/$username/g" {} \;
    find sddm/ -name '*.sh' -exec sed -i "s/USER/$username/g" {} \;
    find qtile/scripts/ -name '*.sh' -exec sed -i "s/USER/$username/g" {} \;
    find hypr/scripts/ -name '*.sh' -exec sed -i "s/USER/$username/g" {} \;
else
    read -p "Username not set. Its required for the script. Press enter to exit."
    exit
fi


read -p "Done! Now lets integrate the wallpaper. Press enter to continue."

# ----------------------------------------------------
# Set current wallpaper as sddm loginscreen at logout for hyprland and qtile..
# ----------------------------------------------------

echo "Do you want to set current wallpaper as sddm loginscreen at logout? y/n"
read logout
if [[ $logout == y* ]]; then
    cp $HOME/dotfiles/hypr/scripts/exit.sh $HOME/dotfiles/hypr/scripts/exit.sh.backup
    cp hypr/scripts/exit.sh $HOME/dotfiles/hypr/scripts/exit.sh
    cp $HOME/dotfiles/qtile/scripts/wallpaper.sh $HOME/dotfiles/qtile/scripts/wallpaper.sh.backup
    cp qtile/scripts/wallpaper.sh $HOME/dotfiles/qtile/scripts/wallpaper.sh
    cp sddm/updatesddm.sh $HOME/dotfiles/sddm/
    echo "ALL ALL=NOPASSWD: /home/$USER/dotfiles/sddm/updatesddm.sh" | sudo EDITOR='tee -a' visudo
    read -p "loginscreen successfully set. Press enter to continue."
else
    read -p "ok! Press enter to continue."
fi

# ----------------------------------------------------
# Set current wallpaper as sddm loginscreen at reboot or shutdown.
# ----------------------------------------------------

echo "Do you want to set current wallpaper as loginscreen at reboot or shutdown? y/n"
read reboot
if [[ $reboot == y* ]]; then
    cp sddm/updatesddm.sh $HOME/dotfiles/sddm/
    sudo cp service/setsddmwall.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable setsddmwall.service
    read -p "loginscreen at reboot or shutdown successfully set. Press enter to continue."
else
    read -p "ok! Press enter to continue."
fi

# ----------------------------------------------------
# Restoring installfiles changed by $username.
# ----------------------------------------------------

echo "Do you want to restore installfiles changed by your username?. Recommended if you want to run this script again. y/n"
read again
if [[ $again == y* ]]; then
    find service/ -name '*.service' -exec sed -i "s/$username/USER/g" {} \;
    find sddm/ -name '*.sh' -exec sed -i "s/$username/USER/g" {} \;
    find qtile/scripts/ -name '*.sh' -exec sed -i "s/$username/USER/g" {} \;
    find hypr/scripts/ -name '*.sh' -exec sed -i "s/$username/USER/g" {} \;
else
    read -p "ok! Press enter to continue."
fi

# ----------------------------------------------------
# Backup existing hyprlock.conf (.backup) and copy new.
# ----------------------------------------------------

echo "Do you want to backup and replace hyprlock.conf now? y/n"
read replace
if [[ $replace == y* ]]; then
    cp $HOME/dotfiles/hypr/hyprlock.conf $HOME/dotfiles/hypr/hyprlock.conf.backup
    cp hypr/hyprlock.conf $HOME/dotfiles/hypr/hyprlock.conf
    read -p "new hyprlock.conf installed. Press enter to continue."
else
    read -p "ok! Press enter to continue"
fi

echo "Install required font the new hyprlock.conf? y/n"
read font
if [[ $font == y* ]]; then
    sudo pacman -S ttf-jetbrains-mono
    read -p "font installed. A reboot is recommended. Press enter to exit script."
else
    read -p "ok! A reboot is recommended if you have changed anything. Press enter to exit script"
fi

exit
