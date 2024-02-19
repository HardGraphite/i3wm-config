#!/bin/sh

declare -A tools=(
    ['USB Storage Devices Control']='udisksctl.sh'
    ['Power Menu']='power.sh'
    ['Lock Screen']='lockscr.sh'
    ['Compositor: start']='compositor.sh start'
    ['Compositor: stop']='compositor.sh stop'
)

script=$(dirname $(readlink -f "$0"))/${tools[$(printf '%s\n' "${!tools[@]}" | rofi -no-plugins -no-sort -dmenu -i -p 'Tool')]}
exec $script
