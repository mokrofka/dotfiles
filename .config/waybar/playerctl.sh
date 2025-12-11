#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ]; then
    icon=""   # play
elif [ "$status" = "Paused" ]; then
    icon=""   # pause
else
    echo ""    # no active player
    exit 0
fi

title=$(playerctl metadata xesam:title 2>/dev/null)

# fallback if empty
[ -z "$title" ] && title="Unknown"

# shorten long titles
short_title=$(echo "$title" | cut -c1-30)

echo "$icon $short_title"
