#!/usr/bin/env bash
# Check if elephant is running 

if pgrep "elephant" > /dev/null
then
  # send diagnostic to sterr
  echo ":: Elephant is running. ::" >&2
else
  echo ":: Elephant is NOT running. ::" >&2
  elephant &
fi

# Get walker theme
if [ -f "$HOME/.config/rice/settings/walker-theme" ]; then
  walker_theme=$(cat "$HOME/.config/rice/settings/walker-theme")
  echo ":: Launching walker ($walker_theme) with arguments: $* ::" >&2
  walker -t $walker_theme "$@"
else
  echo ":: Launching walker w/o theme with arguments: $* ::" >&2
  walker "$@"
fi
