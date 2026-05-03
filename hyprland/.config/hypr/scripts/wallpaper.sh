#!/usr/bin/env bash
# Wallpaper randomizer for swww.
#
# Usage:
#   wallpaper.sh                # pick a random wallpaper now
#   wallpaper.sh next           # next file in alphabetical order
#   wallpaper.sh prev           # previous file
#   wallpaper.sh watch          # daemon: random wallpaper on every workspace change
#   wallpaper.sh <file>         # set specific file (relative or absolute)

WP_DIR="$HOME/.config/hypr/wallpapers"
STATE="$HOME/.cache/swww-current"

mapfile -t WPS < <(find "$WP_DIR" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | sort)

[[ ${#WPS[@]} -eq 0 ]] && { notify-send -i image-x-generic "Wallpaper" "No images in $WP_DIR"; exit 1; }

mkdir -p "$(dirname "$STATE")"
current="$(cat "$STATE" 2>/dev/null)"

set_wallpaper() {
    local wp="$1"
    swww img "$wp" \
        --transition-type any \
        --transition-fps 60 \
        --transition-duration 1.0 \
        >/dev/null 2>&1
    echo "$wp" > "$STATE"
    notify-send -i image-x-generic -t 1500 "Wallpaper" "$(basename "$wp")"
}

random_pick() {
    # Pick a random one that isn't the current
    local pick
    while :; do
        pick="${WPS[RANDOM % ${#WPS[@]}]}"
        [[ "$pick" != "$current" ]] && break
        [[ ${#WPS[@]} -eq 1 ]] && break
    done
    set_wallpaper "$pick"
}

case "${1:-}" in
    "")
        random_pick
        ;;
    next|prev)
        idx=0
        for i in "${!WPS[@]}"; do
            [[ "${WPS[i]}" == "$current" ]] && idx=$i && break
        done
        if [[ "$1" == "next" ]]; then
            idx=$(( (idx + 1) % ${#WPS[@]} ))
        else
            idx=$(( (idx - 1 + ${#WPS[@]}) % ${#WPS[@]} ))
        fi
        set_wallpaper "${WPS[idx]}"
        ;;
    watch)
        # Listen to Hyprland workspace events and randomize on change.
        echo "Watching workspace changes — Ctrl-C to stop"
        SOCK="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
        socat -U - "UNIX-CONNECT:$SOCK" | while IFS= read -r line; do
            if [[ "$line" == workspace*'>>'* ]]; then
                random_pick
            fi
        done
        ;;
    *)
        # Treat as a filename
        if [[ -f "$1" ]]; then
            set_wallpaper "$(realpath "$1")"
        elif [[ -f "$WP_DIR/$1" ]]; then
            set_wallpaper "$WP_DIR/$1"
        else
            echo "Not found: $1"; exit 1
        fi
        ;;
esac
