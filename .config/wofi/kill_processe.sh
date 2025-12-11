#!/bin/bash

ps -eo pid,comm | wofi --dmenu | awk '{print $1}' | xargs -r kill
