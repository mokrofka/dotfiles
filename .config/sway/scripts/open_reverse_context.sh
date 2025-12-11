#!/bin/bash

# Get the currently focused window's app_id using swaymsg and jq
focused_app=$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .app_id')

# If it's not Chrome, switch to workspace 1
if [ "$focused_app" != "google-chrome" ]; then
  swaymsg workspace number 1
fi

# Open the URL in a new tab (Chrome must be running for --new-tab to work)
google-chrome-stable --new-tab "https://context.reverso.net/translation/english-russian/Hello"
