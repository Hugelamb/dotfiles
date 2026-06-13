#!/usr/bin/env bash

# Controls various background processes.
# Can start/stop/restart individual scripts or all registered listeners at once.
#
# ---------------------------------
# Declare an associative array to store the names and full paths of all listener scripts.
# More can be added in the same fashion as those shown.
# ---------------------------------

declare -A LISTENERS
# LISTENERS["low-bat-notification"]="$HOME/.config/rice/listeners/low-bat-notification.sh"
LISTENERS["wallpaper-listener"]="$HOME/.config/rice/listeners/wallpaper-listener.sh"

start_listener() {
  local script_name="$1"
  local init_flag="$2"
  local script_path="${LISTENERS[$script_name]}"

  if [ -z $"script_path" ]; then
    echo "Error: Listener '$script_name' is not registered."
    return 1
  fi

  echo "Attempting to start '$script_name'..."

  # Perfom sanity check on script
  if [ ! -f "$script_path" ]; then
    echo "Error: Script file '$script_path' not found for '$script_name'."
    return 1
  fi
  if [ ! -x "$script_path" ]; then
    echo "Error: Script file '$script_path' is not executable. Please run 'chmod +x \"$script_path\"'."
    return 1
  fi

  # Check if script is already being run
  if pgrep -f "$script_path" >/dev/null; then
    echo "Listener '$script_name' is already running (PID: $(pgrep -f "$script_path"))."
    return 0
  fi

  # Start the script in the background using nohup to detach it from the terminal
  # Redirect stdout and stderr to /dev/null to prevent nohup.out files
  nohup "$script_path" "$init_flag" >/dev/null 2>&1 &
  echo "Listener '$script_name' started successfully."
}

stop_listener() {
  local script_name="$1"
  local script_path="${LISTENERS[$script_name]}"

  if [ -z "$script_path" ]; then
    echo "Error: Listener '$script_name' is not registered."
    return 1
  fi

  echo "Attempting to stop '$script_name'..."

  # Find the PID of the running script
  local pid=$(pgrep -f "$script_path")

  if [ -z "$pid" ]; then
    echo "Listener '$script_name' is not running."
    return 0
  else
    echo "Found PID(s) for '$script_name': $pid. Sending SIGTERM..."
    kill $pid
    # Give it a moment to terminate gracefully
    sleep 1
    if pgrep -f "$script_path" >/dev/null; then
      echo "Listener '$script_name' did not stop gracefully. Sending SIGKILL..."
      kill -9 $pid
      echo "Listener '$script_name' forcefully stopped."
    else
      echo "Listener '$script_name' stopped successfully."
    fi
  fi
}

restart_listener() {
  local script_name="$1"
  echo "Attempting to restart '$script_name'..."
  stop_listener "$script_name"
  start_listener "$script_name"
}


# Main script logic based on command-line arguments
case "$1" in
--startall)
    echo "Starting all registered listeners..."
    for key in "${!LISTENERS[@]}"; do
        start_listener "$key"
    done
    echo "All registered listeners processed."
    ;;
--stopall)
    echo "Stopping all registered listeners..."
    for key in "${!LISTENERS[@]}"; do
        stop_listener "$key"
    done
    echo "All registered listeners processed."
    ;;
--restartall)
    echo "Restarting all registered listeners..."
    for key in "${!LISTENERS[@]}"; do
        restart_listener "$key"
    done
    echo "All registered listeners processed."
    ;;
--start)
    if [ -z "$2" ]; then
        echo "Error: Missing listener name for --start option."
        echo "Usage: $0 --start <listener_name>"
        exit 1
    fi
    start_listener "$2"
    ;;
--stop)
    if [ -z "$2" ]; then
        echo "Error: Missing listener name for --stop option."
        echo "Usage: $0 --stop <listener_name>"
        exit 1
    fi
    stop_listener "$2"
    ;;
--restart)
    if [ -z "$2" ]; then
        echo "Error: Missing listener name for --restart option."
        echo "Usage: $0 --restart <listener_name>"
        exit 1
    fi
    restart_listener "$2"
    ;;
*)
    echo "Usage: $0 [--startall | --stopall | --restartall | --startall-init | --start <listener_name> | --stop <listener_name> | --restart <listener_name> | --start-init <listener_name>]"
    echo ""
    echo "Registered listeners:"
    for key in "${!LISTENERS[@]}"; do
        echo "  - $key"
    done
    exit 1
    ;;
esac
