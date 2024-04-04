# integrate-wallpaper
Wallpaper integration for Stephan Raabes dotfiles
First of all, credits to Stephan Raabe - ML4W for his hard work on his dotfiles 🙏
This scripts integrates the wallpaper completely for hyprland and qtile.

1. Logging out of hyprland sets sddm login screen to currently selected wallpaper.
2. Changing wallpaper in qtile sets sddm login screen to currently selected wallpaper.
3. Shutdown or rebooting from hyprland or qtile sets ssdm login screen to currently selected wallpaper.
4. Install an alternative hyprlock.conf with required fonts. If you play music (f.ex spotify) the artist and track is displayed on the lockscreen below the clock and passwordfield.
The script is in 4 stages so all 4 could be installed individually.

How to use:
1. Run integrate-wallpaper.sh (all files changed by the script is backed up).
2. If you want to restore the changes run uninstall.sh and all files backed up will be restored and all new added files will be removed.

The script in detail 
1. Sets your username to the installfiles that requures it.
2. Backups your existing dotfiles/hypr/scripts/exit.sh to exit.sh.backup
3. Copy the prepared exit.sh to dotfiles/hypr/scripts/exit.sh
4. Backups your existing dotfiles/qtile/scripts/wallpaper.sh to wallpaper.sh.backup
5. copy the prepared wallpaper.sh to dotfiles/qtile/scripts/wallpaper.sh
6. copy the prepared updatesddm.sh to dotfiles/sddm
7. copy the servicefile setsddmwall.service to /etc/systemd/system and enables it.
