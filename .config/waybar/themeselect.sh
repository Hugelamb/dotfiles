#!/usr/bin/env bash
#  _   _                                   _           _             
# | |_| |__   ___ _ __ ___   ___  ___  ___| | ___  ___| |_ ___  _ __ 
# | __| '_ \ / _ \ '_ ` _ \ / _ \/ __|/ _ \ |/ _ \/ __| __/ _ \| '__|
# | |_| | | |  __/ | | | | |  __/\__ \  __/ |  __/ (__| || (_) | |   
#  \__|_| |_|\___|_| |_| |_|\___||___/\___|_|\___|\___|\__\___/|_|   
# ---------------------------------------------------------------------
#

# ---------------------------------------------------------------------
# Load launcher of choice
# ---------------------------------------------------------------------

launcher=$(cat ~/.config/rice/settings/launcher)

# ---------------------------------------------------------------------
# Themes folder path
# ---------------------------------------------------------------------
theme_dir_path="$HOME/.config/waybar/themes"

# ---------------------------------------------------------------------
# Create arrays for storing lists of theme names
# ---------------------------------------------------------------------
listThemes=""
listNames=""
listNames2=""
# ---------------------------------------------------------------------
# Read theme names into array(s)
# ---------------------------------------------------------------------
# sleep 0.2
options=$(find $theme_dir_path -maxdepth 2 -type d)
for value in $options; do
    if [ ! $value == "$HOME/.config/waybar/themes/assets" ]; then
        if [ ! $value == "$theme_dir_path" ]; then
            if [ $(find $value -maxdepth 1 -type d | wc -l) = 1 ]; then
                result=$(echo $value | sed "s#$HOME/.config/waybar/themes/#/#g")
                IFS='/' read -ra arrThemes <<<"$result"
                listThemes[${#listThemes[@]}]="/${arrThemes[1]};$result"
                if [ -f $theme_dir_path$result/config.sh ]; then
                    source $theme_dir_path$result/config.sh
                    listNames+="$theme_name\n"
                    listNames2+="$theme_name~"
                else
                    listNames+="/${arrThemes[1]};$result\n"
                    listNames2+="/${arrThemes[1]};$result~"
                fi
            fi
        fi
    fi
done

# debug
# ---------------------------------------------------------------------
# Functions for selection menu based on launcher chosen in settings
# ---------------------------------------------------------------------
# options currently are rofi, fuzzel, and walker
#
# ---------------------------------------------------------------------
# Use Fuzzel to select the theme
# ---------------------------------------------------------------------

_get_choice_fuzzel() {
  echo $(echo -e "$listNames" | fuzzel --no-sort --match-mode=fuzzy --dmenu --prompt "Themes" -I --width 30 --index)
}

# ---------------------------------------------------------------------
# Use Rofi to select the theme
# ---------------------------------------------------------------------

_get_choice_rofi() {
    echo $(echo -e "$listNames" | rofi -dmenu -replace -i -config ~/.config/rofi/config-themes.rasi -no-show-icons -width 30 -p "Themes" -format i)
}

# ---------------------------------------------------------------------
# Use Walker to select the theme
# ---------------------------------------------------------------------

_get_choice_walker() {
    echo $(echo -e "$listNames" | $HOME/.config/walker/launch.sh -d -i -N -H --height 400 -p "Search Theme")
}

# ---------------------------------------------------------------------
# Display selector menu
# ---------------------------------------------------------------------

listNames=${listNames::-2}

if [ "$launcher" == "fuzzel" ]; then
  choice=$(_get_choice_fuzzel)
elif [ "$launcher" == "walker" ]; then
  choice=$(_get_choice_walker)
else 
  choice=$(_get_choice_rofi)
fi

IFS="~"
input=$listNames2
read -ra array <<<"$input"

# ---------------------------------------------------------------------
# Finally, set the new theme by writing it to ~/.config/rice/settings/waybar-theme.sh
# ---------------------------------------------------------------------
if [ "$choice" ]; then
  echo "Loading waybar theme..."
  echo "${listThemes[$choice + 1]}" >~/.config/rice/settings/waybar-theme.sh
  ~/.config/waybar/launch-waybar.sh # actually reloads waybar to set the new theme
fi
