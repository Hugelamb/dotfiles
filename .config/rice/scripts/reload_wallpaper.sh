#!/usr/bin/env bash
# Wallpaper file name
# echo goodbye > $HOME/hello.txt
wallpaper_selection=$(cat "$HOME/.config/rice/settings/wallpaper")
WALLPAPER_DIR="$HOME/Pictures/Backgrounds/"
  default_wp=$(cat "$HOME/.config/rice/settings/default-wallpaper")
if [ -f "$WALLPAPER_DIR$wallpaper_selection" ]; then
  wallpaper=$wallpaper_selection
elif [ -f "$WALLPAPER_DIR$default_wp" ]; then
  wallpaper=$default_wp
else 
  echo "!!!ERROR: no valid wallpaper found, fallback default-wallpaper not found, please check your wallpapers and settings in $WALLPAPER_DIR and $HOME/.config/rice/settings/ !"
  exit 1
fi
echo -e "wallpaper {\n  monitor = \n  path = $WALLPAPER_DIR$wallpaper\n}\nsplash = false\nipc = true\n" > $HOME/.config/hypr/hyprpaper.conf
pkill hyprpaper
sleep 0.02
hyprpaper & 
