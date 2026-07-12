#!/usr/bin/env bash

# Requires arecord, ffmpeg to be installed, and assumes that Anki user data is installed at
# $HOME/.local/share/Anki2/
# Default user folder is 'User 1'
###############################
### Configuration Variables ###
###############################
# Locations
USER="User 1"
ANKI_USER_DEFAULT_DATA_LOCATION=".local/share/Anki2/"
ANKI_USER_DATA="$ANKI_USER_DEFAULT_DATA_LOCATION$USER/collection.media"
ANKI_MEDIA_FOLDER="$HOME/$ANKI_USER_DATA"
STATE_FILE="$HOME/.local/state/arecord.log"
FUZZEL_CONFIG="$HOME/.config/hypr/conf/scripts/anki-record/fuzzel-menu.ini"
PID=""
# Recording Settings
### USING pw-cat utility
RECORD_PROGRAM=pw-record
RECORD_DEVICE="alsa_input.pci-0000_c1_00.6.HiFi__Mic2__source"
TIMEOUT_SECONDS=10

RECORD_CMD=(--target "$RECORD_DEVICE")
#RECORD_CMD=(--process-id-file "$STATE_FILE" -t "$RECORD_FILE_FORMAT" -d "$TIMEOUT_SECONDS" -f "$RECORD_FORMAT" -r "$RECORD_RATE")

### Using alsa-utils
#RECORD_PROGRAM=arecord 
#RECORD_FORMAT=S24_3LE # set recording data format, as arecord defaults to unsigned 8-bit, which often results in no audible output 
#RECORD_FORMAT=cd
#RECORD_RATE=44100     # Default is 8kHz, set to CD standard rate of 44.1kHz
#RECORD_FILE_FORMAT=wav

#RECORD_CMD=(--process-id-file "$STATE_FILE" -t "$RECORD_FILE_FORMAT" -d "$TIMEOUT_SECONDS" -f "$RECORD_FORMAT" -r "$RECORD_RATE")

### CONVERSION configuration ###
CONVERT_PROGRAM=ffmpeg
OUTPUT_FORMAT=mp3


#################
### FUNCTIONS ###
#################
check_state() {
  # Ensure that log file exists
  if ! [ -f "$STATE_FILE" ]; then
    touch "$STATE_FILE"
  fi
}
cleanup() {
  # Remove temporary files before exit
  if [[ -f $STATE_FILE ]]; then
    echo "$STATE_FILE" exists, removing now.
    rm "$STATE_FILE" 
    exit
  else
    echo "$STATE_FILE" does not exist, exiting now.
    exit 1
  fi
}

record() {
  # begin recording in floating alacritty window in media folder
  # Upon conclusion, print recording name and copy to primary system clipboard
  check_state
  date_string=$(date +"%Y-%m-%d_%H%M%S")
  recording_name="$date_string.$OUTPUT_FORMAT"
  # Create named pip called FIFO
  RAW_AUDIO=$(mktemp /tmp/rawaudio-XXX)
  #alacritty --working-directory "$ANKI_MEDIA_FOLDER" -e "$RECORD_PROGRAM" $RECORD_CMD $recording_name # -t wav -d 10 
  "$RECORD_PROGRAM" "${RECORD_CMD[@]}"  "$RAW_AUDIO" & # -t wav -d 10 
  PID=$! # Get pid of recording process

  selected_option=$(echo -e "Stop\n Discard\n" | fuzzel --dmenu -i --config "$FUZZEL_CONFIG" --minimal-lines -a center --mesg="$DEVICE"|| pkill -x fuzzel)
  case "$selected_option" in 
    *"Stop")
      echo "converting $RAW_AUDIO now, ending arecord process $PID" 
      kill -INT $PID
      output_location="$ANKI_MEDIA_FOLDER/$recording_name"
      "$CONVERT_PROGRAM" -i "$RAW_AUDIO" "$output_location" 
      rm "$RAW_AUDIO"
      wl-copy "$recording_name"
      ;;
    *"Save As")
      name=$(fuzzel --dmenu -i --config "$FUZZEL_CONFIG" -a center --prompt="New File: " --mesg="Save New File to $ANKI_USER_DATA")
      filename="$name.$OUTPUT_FORMAT"
      output_location="$ANKI_MEDIA_FOLDER/$filename"
      "$CONVERT_PROGRAM" -i "$RAW_AUDIO" "$output_location"
      rm "$RAW_AUDIO"
      wl-copy "$filename"
      ;;
    *"Discard")
      rm "$RAW_AUDIO"
      echo "Recording Discarded"
      ;;
    *)
      echo "No option Selected"
      ;;
  esac
  cleanup
}


open_fuzzel_menu() {
  # function call syntax: open_fuzzel_menu recorded_file_name
  actions=$(echo -e "Save\n Play\n Re-record\n Discard\n Record another\n")
  selected_option=$(echo -e "$actions" | fuzzel --dmenu -i --config "$FUZZEL_CONFIG" -a top-right --y-margin=3 --x-margin=3 || pkill -x fuzzel)
  case "$selected_option" in
    *"Save")
      echo "File saved to HOME/$ANKI_USER_DEFAULT_DATA_LOCATION"
      ;;
    *"Play")
      aplay "$1"
      ;;
    *"Re-record")
      echo "Not Implemented, please rerun \`record\`, removing current recording now"
      if [[ -f $1 ]]; then
        rm "$1"
        echo "Recording destroyed"
      fi
      ;;
    *"Discard")
      if [[ -f $1 ]]; then
        rm "$1"
        echo "Recording Discarded"
      fi 
      ;;
    *"Record another")
      echo "Not Implemented, please rerun \`record\`"
      ;; 
  esac
}

### CONTROL LOGIC ### 
### If sourced, don't run ###
(return 0 2>/dev/null) && sourced=1 || sourced=0
if [ "$sourced" -eq 0 ]; then
  if [[ "$1" == "record" ]]; then
    record
    #echo "$1 Not Implemented"
  elif [[ "$1" == "save" ]]; then
    echo "$1 Not Implemented"
  elif [[ "$1" == "menu" ]]; then
    #open_fuzzel_menu "$2"
    echo "$1 Not Implemented"
  elif [[ "$1" == "-h" ]]; then
    printf "Usage: %s [record|save|menu]\n 
    record: begins recording of a new audio file\n
    save: Saves recording to provided location (absolute path)
    menu: opens a menu in which an audio file provided to the function can be manipulated or destroyed.\n
    " "$0"
  else
    echo "Usage: $0 [record|save|menu]"
    exit 1
  fi
fi
