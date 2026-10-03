#!/bin/bash
brightnessctl s "$1"
bright=$(brightnessctl g)
max=$(brightnessctl m)
perc=$((bright * 100 / max))
notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -t 1500 "Brillo" -h int:value:$perc " "
