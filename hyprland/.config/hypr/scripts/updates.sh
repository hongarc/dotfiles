#!/usr/bin/env bash
# Count available dnf updates for waybar.

count=$(dnf -q check-update 2>/dev/null | grep -cE '^[a-zA-Z0-9]')

if [[ "$count" -gt 0 ]]; then
    printf '{"text":"🔄 %s","class":"updates","tooltip":"%s package(s) available\\nClick to update"}\n' "$count" "$count"
else
    printf '{"text":"✓ 0","class":"clean","tooltip":"System up to date"}\n'
fi
