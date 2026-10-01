#!/usr/bin/env bash

echo "$(realpath "$0")"
SCRIPT_DIR="$(dirname "$(realpath "$0")")/themes"
echo $SCRIPT_DIR
# -----------------------------------------------------
# Load Launcher
# -----------------------------------------------------
launcher=$(cat $HOME/.config/rice/settings/launcher)
default_theme="frosted-glass"

# -----------------------------------------------------
# Themes
# -----------------------------------------------------
# -----------------------------------------------------
# Start Launcher
# -----------------------------------------------------

# THEME_OPTIONS=$(find "$SCRIPT_DIR" -maxdepth 1 -mindepth 1 -type f | awk -F/ '{ print $NF }')
THEME_OPTIONS=$(find "$SCRIPT_DIR" -maxdepth 1 -mindepth 1 -type f | awk 'BEGIN{FS="-"; OFS=" "} {sub(/^.*\//,""); for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2)); print}') 


# ---------------------------------------------------------------------
# Use Fuzzel to select the theme
# ---------------------------------------------------------------------
echo $THEME_OPTIONS
_get_choice_fuzzel() {
  echo $(echo -e "$THEME_OPTIONS" | fuzzel --no-sort --match-mode=fuzzy --dmenu --prompt "Themes" --width 30 --index )
}

# ---------------------------------------------------------------------
# Use Rofi to select the theme
# ---------------------------------------------------------------------

_get_choice_rofi() {
    echo $(echo -e "$THEME_OPTIONS" | rofi -dmenu -replace -i -config ~/.config/rofi/config-themes.rasi -no-show-icons -width 30 -p "Themes" -format i)
}

# ---------------------------------------------------------------------
# Use Walker to select the theme
# ---------------------------------------------------------------------

_get_choice_walker() {
    echo $(echo -e "$THEME_OPTIONS" | $HOME/.config/walker/launch.sh -d -i -N -H -p "Search Theme")
}

# ---------------------------------------------------------------------
# Display selector menu
# ---------------------------------------------------------------------


declare -a themes

readarray -t themes < <(find "$SCRIPT_DIR" -maxdepth 1 -mindepth 1 -type f)

if [ "$launcher" == "fuzzel" ]; then
  choice=$(_get_choice_fuzzel)
elif [ "$launcher" == "walker" ]; then
  choice=$(_get_choice_walker)
else 
  choice=$(_get_choice_rofi)
fi
echo exited selection menu
# -----------------------------------------------------
# Source selected theme
# -----------------------------------------------------
selected_theme="${themes[$choice]}"
source $selected_theme
