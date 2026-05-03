#!/usr/bin/env bash
# Fetch weather via wttr.in for waybar (JSON output).
# No API key required. City auto-detected by IP.

CITY="${1:-}"
# %c returns weather icon (often emoji with variation selector) + extra spaces.
# Collapse multi-space to single, strip leading/trailing whitespace.
TEXT=$(curl -fsSL --max-time 4 "https://wttr.in/${CITY}?format=%c+%t" 2>/dev/null \
       | sed 's/+/ /g; s/[[:space:]]\+/ /g; s/^ //; s/ $//')

if [[ -z "$TEXT" ]]; then
    printf '{"text":"--","tooltip":"weather unavailable","class":"offline"}\n'
    exit 0
fi

TOOLTIP=$(curl -fsSL --max-time 4 "https://wttr.in/${CITY}?format=%l:+%C+%t,+feels+%f,+wind+%w,+humidity+%h" 2>/dev/null)

# JSON-escape (very basic)
TEXT_J=$(printf '%s' "$TEXT" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read().strip()))')
TIP_J=$(printf '%s' "$TOOLTIP" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read().strip()))')

printf '{"text":%s,"tooltip":%s}\n' "$TEXT_J" "$TIP_J"
