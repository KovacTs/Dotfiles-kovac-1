#!/bin/bash
if [ "$1" == "mute" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -i muted)
    if [ -n "$is_muted" ]; then
        notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1500 "Volumen" "Silenciado"
    else
        vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
        notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1500 "Volumen" -h int:value:$vol " "
    fi
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"
    vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1500 "Volumen" -h int:value:$vol " "
fi
