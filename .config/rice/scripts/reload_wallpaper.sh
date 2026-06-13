#!/usr/bin/env bash
# Wallpaper file name
echo goodbye > $HOME/hello.txt
wallpaper=$(cat "$HOME/.config/rice/settings/wallpaper")
WALLPAPER_DIR="$HOME/Pictures/Backgrounds/"
echo -e "wallpaper {\n  monitor = \n  path = $WALLPAPER_DIR$wallpaper\n}\nsplash = false\nipc = true\n" > $HOME/.config/hypr/hyprpaper.conf
pkill hyprpaper
sleep 0.2
hyprpaper & 
