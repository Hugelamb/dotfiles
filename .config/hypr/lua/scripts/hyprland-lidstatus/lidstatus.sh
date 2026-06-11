#!/usr/bin/env bash
### ATTRIBUTION and LICENSING
# This script is derived from the work of GitHub user Kore29, see their github repo https://github.com/Kore29/hyprland-clamshell for details. 
# This script requires the use of the MIT License
### END ATTRIBUTION and LICENSING

########################
### LIDSTATUS Script ###
########################

# Internal display name comment out default and replace with your own if needed
IFS=" " read -r -a BUILTIN_DISPLAY_ARR <<< "$(hyprctl monitors | grep "(ID 0)")"
BUILTIN_DISPLAY="${BUILTIN_DISPLAY_ARR[1]}"
# BUILTIN_DISPLAY="INSERTYOURMONITORNAME"
# echo "${BUILTIN_DISPLAY[1]}" # Uncomment to check output of automatically determined inbuilt monitor name

# User configuration file for workspaces (hyprland specific function)
WORKSPACE_CONF_PATH="$HOME/.config/hypr/conf/workspaces/laptop.conf"
searchCommand="grep -o 'workspace = \K([0-9]*),monitor:${BUILTIN_DISPLAY}' ${WORKSPACE_CONF_PATH}"
IFS=" " read -r -a BUILTIN_WORKSPACES_ARR <<< "$searchCommand"

# Icons for notifications (requires icon theme to be installed on your device)
ICON_LAPTOP="computer-laptop"
ICON_MONITOR="video-display"

source ./workspacesctl.sh # allows us to run functions that are defined in workspacesctl.sh


### FUNCTIONS ###
notify_user() {
  # Change '-u low' to '-u normal' to increase popup duration
  notify-send -u low -i "$3" "$1" "$2"
}

current_lid_state() {
  IFS=" " read -r -a state_arr <<< "$(cat /proc/acpi/button/lid/*/state)"
  current_state="${state_arr[1]}"
  echo "$current_state"
}

# MODES 
mode_close() {
  # Only disable builtin display IF at least one external monitor is connected
  MONITORS_COUNT=$(hyprctl monitors all | grep -c "Monitor")
  if [[ $MONITORS_COUNT ]]; then
    migrate_monitor_workspaces "$BUILTIN_DISPLAY" "DP-6" # Currently hardcoded to main display
    hyprctl keyword monitor "$BUILTIN_DISPLAY, disable"
  fi
}

mode_open() {
  # Force enable builtin display
  hyprctl keyword monitor "$BUILTIN_DISPLAY, preferred, 0x0, 1.875" # Replace 3rd argument with "auto" for automatic positioning, 4th with 1 for no scaling
}

### CONTROL LOGIC

if [[ "$1" == "close" ]]; then
  mode_close
  notify_user "Laptop Closed" "External monitor(s) active. Laptop display disabled." "$ICON_MONITOR"
  
elif [[ "$1" == "open" ]]; then
 mode_open
  notify_user "Laptop Mode" "Laptop screen enabled." "$ICON_LAPTOP" 

elif [[ "$1" == "check" ]]; then
  # Silent check for startup/reload to sync state
  if grep -q "open" /proc/acpi/button/lid/*/state; then
    mode_open
  else
    mode_close
  fi

elif [[ "$1" == "current" ]]; then
  current_lid_state

else 
  echo "Usage: $0 [open|close|check|current]"
  exit 1
fi

