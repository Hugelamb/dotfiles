#!/usr/bin/env bash

# --------------------------------
# --- Notification functions --- #
# --------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
info() { echo -e "${GREEN}[INFO]${NC} $1" >&2;}
error() { echo -e "${RED}[ERROR]${NC} $1" >&2;}
##############################################################
# Run Matugen on new wallpaper whenever wallpaper is updated #
##############################################################
if [ -d $HOME/Pictures/Backgrounds ]; then
  WALLPAPER_DIR="$HOME/Pictures/Backgrounds"
elif [ -d $HOME/.config/rice/wallpapers ]; then
  WALLPAPER_DIR="$HOME/.config/rice/wallpapers"
else
  error "!!! No Wallpaper Directory found, please store at either ~/Pictures/Backgrounds or ~/.config/rice/wallpapers"
  exit 1
fi

IMAGE_PATH="$WALLPAPER_DIR/$(cat "$HOME/.config/rice/settings/wallpaper")"

echo $IMAGE_PATH
if ! [[ -f $IMAGE_PATH ]]; then
  error "!!! Wallpaper image not found at the set location -> $IMAGE_PATH !!!"
fi

# Check Matugen binary is executable
 
if [ -f $HOME/.cargo/bin/matugen ]; then
  MATUGEN_BIN="$HOME/.cargo/bin/matugen"
elif [ -f $HOME/.local/bin/matugen ]; then
  MATUGEN_BIN="$HOME/.local/bin/matugen"
elif ! [ $(command -v matugen) ]; then
  error "!!! Matugen not installed, skipping color (re-)generation !!!"
  exit 1
else
  MATUGEN_BIN="matugen"
fi

# Execute Matugen on currently selected wallpaper

$MATUGEN_BIN image "$IMAGE_PATH" --source-color-index 0 -m "dark" # look into setting up a setting for determining dark/light mode

info "Matugen Regeneration complete."

exit 0


  
