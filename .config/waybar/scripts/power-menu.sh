#!/usr/bin/env bash

# config="$HOME/.config/waybar/scripts/fuzzel-power-menu.ini"
actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n󰤄  Suspend\n󱣻  Hibernate\n󰍃  Logout")

selected_option=$(echo -e "$actions" | fuzzel --dmenu -i --config "${config}" -a top-right --y-margin=3 --x-margin=3 || pkill -x fuzzel)

# Take selected action

case "$selected_option" in 
    *Lock)
        hyprlock
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Hibernate)
        systemctl hibernate
        ;;
    *Logout)
        hyprctl dispatch exit 0
        ;;
esac
