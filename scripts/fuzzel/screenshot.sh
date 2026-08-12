#!/usr/bin/env bash

# Output directory for screenshots
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Define menu options for fuzzel
declare -A OPTIONS=(
  ["󰹑  Region (Save & Copy)"]="hyprshot -m region -o '$SAVE_DIR'"
  ["󰍹  Active Monitor (Save & Copy)"]="hyprshot -m output -m active -o '$SAVE_DIR'"
  ["󱂬  Active Window (Save & Copy)"]="hyprshot -m window -m active -o '$SAVE_DIR'"
  ["󰒆  Select Window (Save & Copy)"]="hyprshot -m window -o '$SAVE_DIR'"
  ["󰆞  Region (Clipboard Only)"]="hyprshot -m region --clipboard-only"
  ["󰍹  Active Monitor (Clipboard Only)"]="hyprshot -m output -m active --clipboard-only"
  ["󱂬  Active Window (Clipboard Only)"]="hyprshot -m window -m active --clipboard-only"
  ["󰐃  Region (Freeze Screen)"]="hyprshot -m region -z -o '$SAVE_DIR'"
)

# Format list for fuzzel
CHOICE=$(printf '%s\n' "${!OPTIONS[@]}" | fuzzel --dmenu --prompt "󰄄 Screenshot: ")

# Execute selected action
if [[ -n "$CHOICE" && -n "${OPTIONS[$CHOICE]}" ]]; then
    eval "${OPTIONS[$CHOICE]}"
fi
