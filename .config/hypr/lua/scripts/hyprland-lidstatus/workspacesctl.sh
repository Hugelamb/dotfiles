#!/usr/bin/env bash
### Information ###
# Helper script that will automatically move workspaces to/from specified monitors when called. 
### Usage ###
# ./workspacesctl.sh move OLDMONITOR NEWMONITOR
# Example Application:
# Move workspaces from the builtin display ("eDP-1") to an external display ("DP-6") when lid is closed
# Run the following: ./workspacesctl.sh move eDP-1 DP-6
##############
### SCRIPT ###
##############

#################
### VARIABLES ###
#################
# Initialize all_monitors as an empty array
declare -a all_monitors=()
# Key is the name, value is the id number
declare -A monitor_ids

#monitorsString=$(hyprctl -j monitors | grep -o -P '"name": "\K(.*)(?=",)')
#echo $monitorsString
readarray -d " " -t all_monitors <<< "$(hyprctl -j monitors | grep -o -P '"name": "\K(.*)(?=",)')"
#for val in ${all_monitors[@]}; do
#  echo $val
#done
#################
### FUNCTIONS ###
#################
update_monitors() {
  # sync currently connected monitor list
  readarray -t all_monitors <<< "$(hyprctl -j monitors | grep -o -P '"name": "\K(.*)(?=",)')"
  for (( i=0; i<${#all_monitors[@]}; i++ )); do
    #echo i is "$i"
    name="${all_monitors[$i]}"
    idPattern='Monitor '"$name"' \(ID \K([0-9])(?=\))'
    #idPattern='"id": \K([0-9]*)(?=,[[:space:]]*"name": "eDP-1",)'
    IFS= read -d '' -r id _ <<<"$(hyprctl monitors | grep -oP "$idPattern")"
    monitor_ids[$name]=$id
  done
}
check_monitor() {
  # confirm provided monitor name matches an existing connection
  echo "Not Implemented"
}
move_workspaces() {
  # Call syntax is: move_workspaces TARGET_MONITOR workspace1 workspace2 workspace3 ... workspaceN
  # where the workspaces are the ones to move to TARGET_MONITOR
  # hyprctl workspaces syntax is:
  # workspace ID N (N) on monitor NAME:
  # check that workspaces were passed
  if [[ "$#" -lt 3 ]]; then
    echo Please specify at least one workspace to move
    exit 1
  fi
  cmd_args=( "$@" )
  update_monitors
  dispatchCommand=''
  for (( i=2; i<${#cmd_args[@]}; i++ )); do
    #echo hyprctl dispatch moveworkspacetomonitor "${workspaces_arr[$i]}" ${monitor_ids[$2]}
    dispatchString+="dispatch moveworkspacetomonitor ${cmd_args[$i]} ${monitor_ids[$2]} ;"
  done
  tmp="$dispatchString"
  dispatchString=${tmp%;} # remove trailing ;
  hyprctl --batch "$dispatchString"

}

migrate_monitor_workspaces() {
  # Arguments should be OLD_MONITOR NEW_MONITOR
  # hyprctl workspaces syntax is:
  # workspace ID N (N) on monitor NAME:
  update_monitors
  dispatchString=''
  grepPattern='workspace ID ([0-9]*) \(([0-9]*)\) on monitor '+"$1"
  workspaces=$(hyprctl workspaces | grep -oE "$grepPattern" | sed 's/workspace ID \([0-9]*\).*/\1/')
  #workspaces=$(hyprctl workspaces | grep -oE "$grepPattern" | sed 's/workspace ID \([0-9]*\) ([0-9]*) on monitor \([^\s]*\)/\1 \2/')
  #echo "$workspaces"
  readarray -t workspaces_arr <<< $workspaces
  #echo monitor $2 with ID "${monitor_ids[$2]}"
  echo $2
  if [[ $2 =~ ^[0-9]+$ ]]; then
    monitorID=$2
  else
    monitorID="${monitor_ids[$2]}"
  fi
  for (( i=0; i<${#workspaces_arr[@]}; i++ )); do
    #echo hyprctl dispatch moveworkspacetomonitor "${workspaces_arr[$i]}" ${monitor_ids[$2]}
    dispatchString+="dispatch moveworkspacetomonitor ${workspaces_arr[$i]} ${monitorID} ;"
  done
  tmp="$dispatchString"
  dispatchString=${tmp%;}
  hyprctl --batch "$dispatchString"

}
update_monitors

### Function selection if run directly

(return 0 2>/dev/null) && sourced=1 || sourced=0
if [ $sourced -eq 0 ]; then
  if [[ "$1" == "migrate" ]]; then
    migrate_monitor_workspaces "$2" "$3"
  elif [[ "$1" == "move" ]]; then
    move_workspaces "$@"
  else
    echo "Usage: $0 [migrate|move]"
    exit 1
  fi
fi
