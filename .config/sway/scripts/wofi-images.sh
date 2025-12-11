#!/bin/bash

# Folder with images
IMG_DIR="$HOME/.config/sway/scripts/images"

# Use WoFi to select an image
FILE=$(find "$IMG_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) \
      -printf "%f\n" \
     | wofi --dmenu --prompt "Select image")

# If an image was selected, open it with your viewer
if [[ -n "$FILE" ]]; then
  # Example: use imv (Wayland-friendly viewer)
  imv "$IMG_DIR/$FILE"
fi
