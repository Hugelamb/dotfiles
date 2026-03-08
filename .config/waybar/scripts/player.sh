#!/bin/bash
###!/bin/sh

get_time () {
  length=$(playerctl metadata --format "{{duration(mpris:length)}}")
  position=$(playerctl metadata --format "{{duration(position)}}")
  echo "[$position|$length]"
}
# list of default players
players=("default" "firefox" "spotify" "mpris" "vlc" "tidal-hifi")
icons=("<span color='#8c57ff' >󰎇</span>" "<span color='#F30131' >󰗃</span>" "" "" "" "󱒀")

player_icon () {
  # set player icon if possible, otherwise default to note icon
  # $1 should be a string passed from playerctl metadata --format "{{playerName}}"

  for i in "${!players[@]}"; do
    if [[ "${players[$i]}" =~ $1 ]]; then
      icon_idx=$i;
      break;
    fi
  done
  echo  "${icons[$i]}"
}
# check length, truncate if too long
limit_string () {
  if [ "$#" -lt 2 ]; then
    length=20 # default max length 
  #elif [ "$#" -eq 2 -a $2 -gt 2 ]; then
  elif [ "$#" -eq 2 ] && [ "$2" -gt 2 ]; then
    length=$2
  else
    echo "ERROR"
    # echo " $# is the wrong number of inputs, should be either 1 or 2."
  fi
  string=$1
  
  if [ ${#string} -gt "$length" ]; then
    # cut to size, replace ending with ellipsis
    echo "${string:0:(($2-2))}…"
  fi
    echo "$string"
}

player_status=$(playerctl status 2> /dev/null)
icon=$(player_icon "$(playerctl metadata --format "{{playerName}}")")

# Get and set current player status icon
status_line () {
status=""

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
  if [ "$player_status" = "Playing" ]; then
    status="󰏤"
  else
    status="󰐊"
  fi 
  # check length of title
  # check length of artist name
  metadata_title="$(playerctl metadata title)"
  metadata_artist=$(playerctl metadata artist)
  title="$(limit_string "$metadata_title" 30)"
  artist="$(limit_string "$metadata_artist" 20)"
  time="$(get_time)"
  echo "$status | $icon : ${artist} - $title | $time"
else
    echo "${icon}  Nothing Playing yet."
fi

}

# code to run when script is called
status_line
