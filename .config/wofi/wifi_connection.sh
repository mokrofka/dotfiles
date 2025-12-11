#!/bin/bash

ACTION=$(printf "Wi-Fi On/Off\nConnect to New Network\nReconnect Last Network\nSaved Networks\nForget Network\nCurrent Network" | wofi --dmenu --prompt "Network Manager:")

case "$ACTION" in
  "Wi-Fi On/Off")
    STATUS=$(nmcli radio wifi)
    if [ "$STATUS" = "enabled" ]; then
      nmcli radio wifi off
      notify-send "Wi-Fi" "Wi-Fi turned off"
    else
      nmcli radio wifi on
      notify-send "Wi-Fi" "Wi-Fi turned on"
    fi
    ;;
    
  "Connect to New Network")
    SSID=$(nmcli -t -f SSID,SIGNAL dev wifi | sort -r -t: -k2 | cut -d: -f1 | uniq | grep -v '^$' | wofi --dmenu --prompt "Select Wi-Fi:")
    [ -z "$SSID" ] && exit 0

    # # Check if already connected
    # CURRENT=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    # if [ "$CHOICE" = "$CURRENT" ]; then
    #   notify-send "Wi-Fi" "You have already access to $CHOICE"
    #   exit 0
    # fi

    PASSWORD=$(nmcli -t -f SECURITY dev wifi | grep "^$SSID:" | cut -d: -f2)
    if [[ "$PASSWORD" != "--" ]]; then
      PASS=$(wofi --dmenu --password --prompt "Password for $SSID:")
      nmcli dev wifi connect "$SSID" password "$PASS"
    else
      nmcli dev wifi connect "$SSID"
    fi
    ;;

  "Reconnect Last Network")
    LAST=$(nmcli -t -f NAME,DEVICE connection show --active | head -n1 | cut -d: -f1)
    nmcli connection up id "$LAST"
    ;;

  "Saved Networks")
    nmcli connection show | tail -n +2 | awk '{print $1}' | wofi --dmenu --prompt "Connect to saved network:" | xargs -I{} nmcli connection up id "{}"
    ;;

  "Forget Network")
    nmcli connection show | tail -n +2 | awk '{print $1}' | wofi --dmenu --prompt "Forget network:" | xargs -I{} nmcli connection delete id "{}"
    ;;
  "Current Network")
    CURRENT=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
    notify-send "Current Wi-Fi" "Connected to: $CURRENT"
    ;;

esac
