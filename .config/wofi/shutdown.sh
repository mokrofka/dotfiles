#!/bin/bash

# Define options
OPTIONS="Shutdown\nRestart\nSleep\nLogout\nLock"

# Show Wofi menu
CHOICE=$(echo -e $OPTIONS | wofi --dmenu --prompt "Power:")

# Take action
case $CHOICE in
  Shutdown)
    systemctl poweroff
    ;;
  Restart)
    systemctl reboot
    ;;
  Sleep)
    systemctl suspend
    ;;
  Logout)
    swaymsg exit
    ;;
  Lock)
    swaylock
    ;;
esac
