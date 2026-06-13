#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Backgrounds/"
launcher=$(cat $HOME/.config/rice/settings/launcher)
default_wallpaper="portal.png"
# WALLPAPER_OPTIONS=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.tif" \) | awk -F '{sub(/^.*\\//,"");  print $NF }' )
WALLPAPER_OPTIONS=($(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)))
for path in "${WALLPAPER_OPTIONS[@]}"; do 
  wallpaper_names+=($(basename "$path")"\n")
done
echo "${wallpaper_names[@]}"




_get_choice_fuzzel() {
  echo $(echo -e "${wallpaper_names[@]}" | fuzzel --no-sort --match-mode=fuzzy --dmenu --prompt "Wallpapers" --width 30 --index )
}

# ---------------------------------------------------------------------
# Use Rofi to select the theme
# ---------------------------------------------------------------------

_get_choice_rofi() {
    echo $(echo -e "$wallpaper_names" | rofi -dmenu -replace -i -config ~/.config/rofi/config-themes.rasi -no-show-icons -width 30 -p "Wallpapers" -format i)
}

# ---------------------------------------------------------------------
# Use Walker to select the theme
# ---------------------------------------------------------------------

_get_choice_walker() {
    echo $(echo -e "${wallpaper_names[@]}" | $HOME/.config/walker/launch.sh -d -i -N -H -p "Search Wallpapers")
}

if [ "$launcher" == "fuzzel" ]; then
  choice=$(_get_choice_fuzzel)
elif [ "$launcher" == "walker" ]; then
  choice=$(_get_choice_walker)
else 
  choice=$(_get_choice_rofi)
fi

# wallpaper=$(echo -n "${wallpaper_names[$choice]}" | tr -d '\n')
tmp="${wallpaper_names[$choice]}"
#wallpaper="${tmp%$'\n'}"
# wallpaper=$(echo -ne "$tmp")
wallpaper=$(echo -ne "${wallpaper_names[$choice]}")
echo -e $wallpaper > $HOME/.config/rice/settings/wallpaper

# Reload wallpaper by modifying hyprpaper.conf file to reflect new choice

$HOME/.config/rice/scripts/reload_wallpaper.sh &
