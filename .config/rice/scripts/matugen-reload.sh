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
# Set Matugen flag fallback values
COLOUR_MODE="dark"
MATUGEN_SCHEME_TYPE="scheme-tonal-spot"
MATUGEN_SOURCE_COLOR_INDEX=0
# Check color mode (light/dark)
if [ -f $HOME/.config/rice/settings/colour-mode ]; then
  COLOUR_MODE=$(cat $HOME/.config/rice/settings/colour-mode)
elif [ -f $HOME/.config/rice/settings/default-colour-mode ]; then
  COLOUR_MODE=$(cat $HOME/.config/rice/settings/default-colour-mode)
else
  info "!!! No color mode set, default to 'dark'"
  COLOUR_MODE="dark"
fi
# Execute Matugen on currently selected wallpaper
if [ $COLOUR_MODE == "light" ]; then
  MATUGEN_SCHEME_TYPE="scheme-content"
  MATUGEN_SOURCE_COLOR_INDEX=2
fi
$MATUGEN_BIN image "$IMAGE_PATH" --source-color-index $MATUGEN_SOURCE_COLOR_INDEX -m "$COLOUR_MODE" -t "$MATUGEN_SCHEME_TYPE" # look into setting up a setting for determining dark/light mode

info "Matugen Regeneration complete."

exit 0


  
