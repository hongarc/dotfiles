#!/usr/bin/env bash
# Show current fcitx5 input method state for waybar.

if ! command -v fcitx5-remote >/dev/null 2>&1; then
    printf '{"text":"--","tooltip":"fcitx5 not installed","class":"off"}\n'
    exit 0
fi

state=$(fcitx5-remote 2>/dev/null)

# 0 = inactive (English / direct typing)
# 1 = active but no IME engaged (still passthrough)
# 2 = active IME (e.g., Vietnamese typing)
case "$state" in
    2)
        # IME engaged — fetch the active engine name
        engine=$(fcitx5-remote -n 2>/dev/null)
        case "$engine" in
            unikey*) printf '{"text":"🇻🇳","tooltip":"Vietnamese (Unikey)","class":"vi"}\n' ;;
            *)       printf '{"text":"⌨ %s","tooltip":"Engine: %s","class":"ime"}\n' "${engine:-IME}" "$engine" ;;
        esac
        ;;
    1|0)
        printf '{"text":"🇺🇸","tooltip":"English (passthrough)","class":"en"}\n'
        ;;
    *)
        printf '{"text":"⌨","tooltip":"fcitx5 not running","class":"off"}\n'
        ;;
esac
