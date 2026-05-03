#!/usr/bin/env bash
# Toggle live mic-to-headphones monitoring (hear yourself).
# Pipes the DGM20 USB mic into the built-in audio output via PipeWire.

SOURCE='alsa_input.usb-Maono_DGM20_USB_Microphone_20230101-00.analog-stereo'
SINK='alsa_output.pci-0000_00_1f.3.analog-stereo'
TAG='node.name=mic-monitor'

if pgrep -af "pw-loopback.*${TAG}" >/dev/null; then
    pkill -f "pw-loopback.*${TAG}"
    notify-send -i audio-input-microphone "Mic monitor" "OFF"
else
    setsid pw-loopback \
        --capture-props="node.target=${SOURCE}" \
        --playback-props="node.target=${SINK} ${TAG} node.description=Mic-Monitor" \
        >/dev/null 2>&1 &
    disown
    notify-send -i audio-input-microphone "Mic monitor" "ON"
fi
