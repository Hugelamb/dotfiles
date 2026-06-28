#!/usr/bin/env bash


# Prevent duplicate launches: only the first invocation succeeds

exec 200>/tmp/waybar-launch.lock
flock -n 200 || exit 0 # flock manages file locks from shell scripts

#----------------------------------------------------------------------------------------------
# Quit any currently running instances of waybar
#----------------------------------------------------------------------------------------------
killall waybar || true
pkill waybar || true
sleep 0.3


#----------------------------------------------------------------------------------------------
# set default theme
#----------------------------------------------------------------------------------------------

default_theme="/frosted-glass;/frosted-glass/setup"


#----------------------------------------------------------------------------------------------
# Get current theme from settings file
#----------------------------------------------------------------------------------------------

if [ -f ~/.config/rice/settings/theme ]; then
  themestyle=$(cat ~/.config/rice/settings/waybar-theme.sh)
else
  touch ~/.config/rice/settings/waybar-theme.sh
  echo "$default_theme" >~/.config/rice/settings/waybar-theme.sh
  themestyle=$default_theme
fi

IFS=';' read -ra arrThemes <<<"$themestyle"
echo ":: Theme: ${arrThemes[0]}" # for quickshell support

if [ ! -f ~/.config/waybar/themes/${arrThemes[1]}/style.css ]; then
  themestyle=$default_theme
fi

# -----------------------------------------------------
# Toggle Waybar modules (from https://github.com/mylinuxforwork/dotfiles/blob/main/dotfiles/.config/waybar/launch.sh)
# -----------------------------------------------------

_toggle_module() {
    local module_name=$1
    local settings_file=$2
    local value=$(cat "$settings_file")
    local file="$HOME/.config/waybar/themes${arrThemes[0]}/config"
    if [ "$value" == "True" ]; then
        search_string=" \"$module_name\""
        if ! grep -qF "$search_string" "$file"; then
            sed -i "s| //\"$module_name\"| \"$module_name\"|g" "$file"
        fi    
    else
        search_string=" //\"$module_name\""
        if ! grep -qF "$search_string" "$file"; then
            sed -i "s| \"$module_name\"| //\"$module_name\"|g" "$file"
        fi    
    fi
}

_toggle_module "custom/appmenu" "$HOME/.config/rice/settings/waybar_appmenu.sh"
_toggle_module "wlr/taskbar" "$HOME/.config/rice/settings/waybar_taskbar.sh"
_toggle_module "hyprland/workspaces" "$HOME/.config/rice/settings/waybar_workspaces.sh"
_toggle_module "group/quicklinks" "$HOME/.config/rice/settings/waybar_quicklinks.sh"
_toggle_module "hyprland/window" "$HOME/.config/rice/settings/waybar_window.sh"
_toggle_module "network" "$HOME/.config/rice/settings/waybar_network.sh"
_toggle_module "tray" "$HOME/.config/rice/settings/waybar_systray.sh"


# -----------------------------------------------------
# Load in the configuration
# -----------------------------------------------------
#
# all styles should use these naming conventions
config_file="config" 
style_file="style.css"

# Standard styles and configs can be overwritten using the specific syntax of (style/config)-custom(.css)
if [ -f ~/.config/waybar/themes${arrThemes[0]}/config-custom ]; then
  config_file="config-custom"
fi
if [ -f ~/.config/waybar/themes${arrThemes[1]}/style-custom.css ]; then
  style_file="style-custom.css"
fi

# Check if waybar has been disabled in settings
if [ ! -f $HOME/.config/rice/settings/waybar-disabled ]; then
    HYPRLAND_SIGNATURE=$(hyprctl instances -j | jq -r '.[0].instance')
    HYPRLAND_INSTANCE_SIGNATURE="$HYPRLAND_SIGNATURE" waybar -c ~/.config/waybar/themes${arrThemes[0]}/$config_file -s ~/.config/waybar/themes${arrThemes[1]}/$style_file &
else
    echo ":: Waybar disabled" # Quickshell support 
fi

# Explicitly release the lock (optional) -> flock releases on exit
flock -u 200
exec 200>&-
