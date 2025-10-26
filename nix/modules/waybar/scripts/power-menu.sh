#!/usr/bin/env bash
picker() { rofi --dmenu -i -p "Power"; }

choice=$(printf " Lock\n Suspend\n Reboot\n Shutdown" | picker)

case "$choice" in
" Lock") exec gtklock || exec swaylock ;;
" Suspend") exec systemctl suspend ;;
" Reboot") exec systemctl reboot ;;
" Shutdown") exec systemctl poweroff ;;
esac
