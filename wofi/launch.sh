#!/usr/bin/env bash
# Lanzador de wofi con dos vistas: "list" (listado) y "gallery" (galería).
# Uso: launch.sh [open|toggle|list|gallery]
#   open    -> abre la última vista usada (o cierra wofi si ya está abierto)
#   toggle  -> cambia de vista y abre wofi (si estaba abierto, lo reabre)
#   list / gallery -> fuerza esa vista

DIR="$HOME/.config/wofi"
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/wofi-view"
mkdir -p "$(dirname "$STATE")"

mode=$(cat "$STATE" 2>/dev/null || echo list)

case "${1:-open}" in
  open)
    pkill -x wofi && exit 0 ;;
  toggle)
    [ "$mode" = list ] && mode=gallery || mode=list
    pkill -x wofi ;;
  list|gallery)
    mode=$1
    pkill -x wofi ;;
esac

echo "$mode" > "$STATE"

if [ "$mode" = gallery ]; then
  exec wofi --show drun \
    --style "$DIR/gallery.css" \
    -D columns=3 \
    -D image_size=48 \
    -D width=1200 \
    -D height=650 \
    -D line_wrap=word
else
  exec wofi --show drun
fi
