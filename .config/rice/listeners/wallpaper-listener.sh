#!/usr/bin/env bash

# Automatically monitors changes to the rice wallpaper setting file
# and runs the appropriate scripts on change

# Path to the wallpaper setting file
SETTINGS_FILE="$HOME/.config/rice/settings/wallpaper"
SETTINGS_DIR="$HOME/.config/rice/settings"
SETTINGS_BASENAME=$(basename "$SETTINGS_FILE")

# Ensure that inotify-tools is installed (change report tool)
if ! command -v inotifywait &> /dev/null
then
  echo "Error: inotifywait is not installed."
  echo "Please install inotify-tools (e.g., sudo dnf install inotify-tools on Fedora)"
  exit 1
fi

# Ensure helper scripts are executable
RICE_SCRIPT_DIR="$HOME/.config/rice/scripts"
MATUGEN_SCRIPT="matugen-reload.sh"
MATUGEN_SCRIPT_PATH="$RICE_SCRIPT_DIR/$MATUGEN_SCRIPT"
if [[ -x $MATUGEN_SCRIPT_PATH ]]; then
  echo "Matugen Script located  successfully."
else
  echo "Error: $MATUGEN_SCRIPT not found in $RICE_SCRIPT_DIR, exiting now..."
  exit 1
fi

echo "Monitoring $SETTINGS_FILE for changes ..."
echo "Press CTRL+C to stop."

# Loop to notify on change to $SETTING_FILE
inotifywait -m -q -e close_write,moved_to "$SETTINGS_DIR" | while read -r dir events filename; do
  if [[ "$filename" == "$SETTINGS_BASENAME" ]]; then
    echo "Change detected in $SETTINGS_FILE. Running updating theming..."
    $MATUGEN_SCRIPT_PATH &
  fi
done
    
