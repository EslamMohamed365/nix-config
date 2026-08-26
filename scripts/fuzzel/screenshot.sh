#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Step 1: Select Target
TARGET=$(printf "󰹑  Region\n󱂬  Active Window\n󰒆  Select Window\n󰍹  Active Monitor" |
        fuzzel --dmenu --prompt "󰄄 Target: ")

[ -z "$TARGET" ] && exit 0

case "$TARGET" in
*"Region"*) MODE="-m region -z" ;;
*"Active Window"*) MODE="-m window -m active" ;;
*"Select Window"*) MODE="-m window" ;;
*"Active Monitor"*) MODE="-m output -m active" ;;
esac

# Step 2: Select Action
ACTION=$(printf "󰆐  Save & Copy\n󰅍  Clipboard Only\n󰏫  Edit (Satty)" |
        fuzzel --dmenu --prompt "󰄄 Action: ")

[ -z "$ACTION" ] && exit 0

# Delay 1 second for fuzzel to close
sleep 0.25

# Step 3: Run hyprshot
case "$ACTION" in
*"Save & Copy"*) hyprshot $MODE -s -o "$SAVE_DIR" ;;
*"Clipboard Only"*) hyprshot $MODE -s --clipboard-only ;;
*"Edit"*) hyprshot "$MODE" --raw -s | satty --filename - ;;
esac
