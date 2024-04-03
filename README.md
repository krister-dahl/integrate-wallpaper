# integrate-wallpaper
Wallpaper integration for Stephan Raabes dotfiles
First of all, all credits to Stephan Raabe - ML4W for his hard work on his dotfiles 🙏
This scripts integrates the wallpaper completely for hyprland and qtile.

1. Logging out of hyprland sets sddm login screen to currently selected wallpaper.
2. Changing wallpaper in qtile sets sddm login screen to currently selected wallpaper.
3. Shutdown or rebooting from hyprland or qtile sets ssdm login screen to currently selected wallpaper.
4. Install a alternative hyprlock.conf. If you play music (f.ex spotify) the artist and track is displayed on the lockscreen below the clock and passwordfield.
The script is in 4 stages so all 4 could be installed individually.

How to use:
1. Run integrate-wallpaper.sh (all files changed by the script is backed up).
2. If you want to restore the changes run uninstall.sh and all files is restored.
