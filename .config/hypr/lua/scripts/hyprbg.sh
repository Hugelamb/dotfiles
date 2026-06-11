#!/usr/bin/env bash
WALLPAPERS_PATH="${HOME}/Pictures/Backgrounds/"
# path of list file
LISTPATH=$WALLPAPERS_PATH"all.txt"

# On call, update a list of all .png files in the WALLPAPERS_PATH directory (no need to search subdirs) and return the list 
get_papers () {
  filepaths=$(ls -A1 $WALLPAPERS_PATH*.png )
  files=$(basename -a $filepaths)
  echo $files 
}

get_current () {
  tmp=$(hyprctl hyprpaper listactive)
  {
    read
    while IFS=, read line 
    do
      IFS=' ' read -r -a array <<< "$line" 
      monitor=${array[0]}
      current_wp=${array[-1]}
      echo $monitor $current_wp
    done } <<< "$tmp"
}

test () {
  local monitor=$1
  local old_wp=$2
  local wp=$old_wp

  tmp=$(find $WALLPAPERS_PATH -name '*.png' | shuf -n 1 )
  echo $tmp
}

set_diff () {
  local monitor=$1
  local old_wp=$2
  local wp=$old_wp

  while [[ $wp == $old_wp ]]
  do
    wp=$( find $WALLPAPERS_PATH -name '*.png' | shuf -n 1 ) 
  done  
  # now wp contains the new, different wallpaper to set  
  echo $wp
  echo $old_wp
  hyprctl hyprpaper unload $old_wp
  hyprctl hyprpaper preload $wp
  hyprctl hyprpaper wallpaper $monitor, $wp
}
