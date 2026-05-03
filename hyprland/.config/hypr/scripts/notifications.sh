#!/usr/bin/env bash
# Show notification history via fuzzel. Pick one to invoke its default action.

if ! command -v makoctl >/dev/null 2>&1; then
    notify-send "mako" "makoctl not found"
    exit 1
fi

count=$(makoctl list | jq -r '.data[0] | length' 2>/dev/null)

if [[ -z "$count" || "$count" == "0" ]]; then
    # No active — try history
    hist=$(makoctl history 2>/dev/null | jq -r '.data[0][] | "\(.["app-name"].data) — \(.summary.data) — \(.body.data)"' 2>/dev/null)
    if [[ -z "$hist" ]]; then
        notify-send -t 2000 "Notifications" "No notifications"
        exit 0
    fi
    # Show history list (read-only)
    echo "$hist" | fuzzel --dmenu --prompt=" history " --width=60 --lines=15 >/dev/null
    exit 0
fi

# Active notifications: list, let user pick to invoke default action
mapfile -t items < <(makoctl list | jq -r '.data[0][] | "\(.id.data)\t\(.["app-name"].data) — \(.summary.data) — \(.body.data)"')

picked=$(printf '%s\n' "${items[@]}" | cut -f2- | fuzzel --dmenu --prompt=" notifications " --width=60 --lines=10)

[[ -z "$picked" ]] && exit 0

# Find matching id
for line in "${items[@]}"; do
    text="${line#*$'\t'}"
    id="${line%%$'\t'*}"
    if [[ "$text" == "$picked" ]]; then
        makoctl invoke "$id"
        exit 0
    fi
done
