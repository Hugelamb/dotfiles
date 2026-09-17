#!/usr/bin/env bash

###################################################
# Script to change colour mode for matugen theming 
###################################################
colour_mode="" # ensure the variable exists just in case
if [ -f "$HOME/.config/rice/settings/colour-mode" ]; then
  colour_mode=$(cat "$HOME/.config/rice/settings/colour-mode")
elif [ -f "$HOME/.config/rice/settings/default-colour-mode" ]; then
  colour_mode=$(cat "$HOME/.config/rice/settings/colour-mode")
else 
  colour_mode="dark"
  touch $HOME/.config/rice/settings/colour-mode
fi
# switch colour_mode value
if [ $colour_mode == "dark" ]; then
  colour_mode="light"
else
  colour_mode="dark"
fi

echo -e "$colour_mode" > $HOME/.config/rice/settings/colour-mode

