#!/bin/bash
# mic-volume.sh

# MIC=$(pactl info | grep "Default Source" | awk '{print $3}')
# VOLUME=$(pactl list sources | grep -A 15 "$MIC" | grep 'Volume:' | head -n1 | awk '{print $5}')
# echo "$VOLUME"
# 

# Get default microphone
MIC=$(pactl info | grep "Default Source" | awk '{print $3}')

# Check if mic is muted
MUTED=$(pactl list sources | grep -A 15 "$MIC" | grep "Mute:" | awk '{print $2}')

if [ "$MUTED" = "yes" ]; then
  echo "Off"

else
  # Get volume (just take the first channel)

  VOLUME=$(pactl list sources | grep -A 15 "$MIC" | grep 'Volume:' | head -n1 | awk '{print $5}')
  echo "$VOLUME"
fi

