#!/usr/bin/env bash
# DNF update runner. Called from waybar custom/updates click handlers.

if [[ "$1" == "check" ]]; then
    dnf check-update
else
    sudo dnf upgrade
fi

echo
echo "─────────────────────────"
read -p "Press Enter to close..."
