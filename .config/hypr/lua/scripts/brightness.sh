#!/usr/bin/env bash
BACKLIGHT_PATH="/sys/class/backlight/$(ls -A /sys/class/backlight)/"
CURRENT_BRIGHTNESS_LOC=$BACKLIGHT_PATH"brightness"
MAX_BRIGHTNESS_LOC=$BACKLIGHT_PATH"max_brightness"
b- () {
  new_brightness=$(( $( cat $CURRENT_BRIGHTNESS_LOC ) - 5*$( cat $MAX_BRIGHTNESS_LOC )/100 ))
  if [[ $new_brightness > 0 ]]; then
    echo $new_brightness > $CURRENT_BRIGHTNESS_LOC
  fi
} 

b+ () {

  new_brightness=$(( $( cat $CURRENT_BRIGHTNESS_LOC ) + 5*$( cat $MAX_BRIGHTNESS_LOC )/100 ))
  if [[ $new_brightness < $MAX_BRIGHTNESS_LOC ]]; then
    echo $new_brightness > $CURRENT_BRIGHTNESS_LOC 
  fi
}

case "$1" in
  "plus") b+
  ;;
  "minus") b-
  ;;
  *) 
     
  ;;
esac

