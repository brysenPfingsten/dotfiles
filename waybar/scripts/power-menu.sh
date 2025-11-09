#!/usr/bin/env bash

# Use -dmenu (one dash), not --dmenu
picker() { rofi -dmenu -i -p "Power"; }

choice="$(printf '%s\n' ' Lock' ' Suspend' ' Reboot' ' Shutdown' | picker)" || exit 0

case "$choice" in
" Lock") exec gtklock || exec swaylock ;;
" Suspend") exec systemctl suspend ;;
" Reboot") exec systemctl reboot ;;
" Shutdown") exec systemctl poweroff ;;
*) exit 0 ;;
esac
