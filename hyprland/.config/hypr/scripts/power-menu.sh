#!/usr/bin/env bash
# Fuzzel-driven power menu

choice=$(printf '%s\n' \
  "  Lock" \
  "  Logout" \
  "  Suspend" \
  "  Reboot" \
  "  Shutdown" \
  | fuzzel --dmenu --prompt="⏻ " --lines=5 --width=20)

case "$choice" in
  *Lock*)     hyprlock ;;
  *Logout*)   hyprctl dispatch exit ;;
  *Suspend*)  systemctl suspend ;;
  *Reboot*)   systemctl reboot ;;
  *Shutdown*) systemctl poweroff ;;
esac
