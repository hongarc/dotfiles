#!/usr/bin/env bash
# Live CPU package temperature reader (no lm_sensors needed).
# Reads coretemp from sysfs.

while true; do
    clear
    for f in /sys/class/hwmon/hwmon*/temp*_input; do
        name="$(cat "$(dirname "$f")/name" 2>/dev/null)"
        label_file="${f%_input}_label"
        label="$(cat "$label_file" 2>/dev/null || echo "$(basename "$f" _input)")"
        temp_milli="$(cat "$f" 2>/dev/null || echo 0)"
        printf '%-20s %-15s %.1f°C\n' "$name" "$label" "$(echo "scale=1;$temp_milli/1000" | bc -l)"
    done
    sleep 1
done
