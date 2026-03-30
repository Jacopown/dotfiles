#!/usr/bin/env bash

# Options
lock="󰌾  Lock"
logout="󰍃  Logout"
sleep="󰒲  Sleep"
reboot="󰜉  Reboot"
shutdown="󰐥  Shutdown"

# Get selection from rofi
# We use -dmenu to treat rofi as a generic menu
# We use -i for case-insensitive matching
# We use -p to set the prompt text
selected_option=$(echo -e "$lock\n$logout\n$sleep\n$reboot\n$shutdown" | rofi -dmenu -i -p "Power" -theme theme)

# Map selection to command
case "$selected_option" in
    "$lock")
        hyprlock
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
    "$sleep")
        systemctl suspend
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$shutdown")
        systemctl poweroff
        ;;
esac
