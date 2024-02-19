#!/bin/bash

PICTURE_DIR="$HOME/Pictures/Wallpapers/selected"
WALLPAPER_CMD='feh --bg-scale --no-fehbg'
CHANGE_INTERVAL='15m'

if [[ $(pgrep -x "$0") ]]; then
    echo "** '$0' is already running"
    exit 1
fi

readarray -d '' picture_files < <( \
    find "$PICTURE_DIR" -print0 -type f \
    \( -iname '*.jpg' -o -name '*.jpeg' -o -iname "*.png" \)
)
picture_count=${#picture_files[@]}
if [[ $picture_count -eq 0 ]]; then
    echo '** cannot find image files in' $PICTURE_DIR
    exit 1
fi

while true; do
    index_list=$(shuf -i 0-$(($picture_count - 1)))
    for idx in $index_list; do
        $WALLPAPER_CMD "${picture_files[idx]}"
        sleep $CHANGE_INTERVAL
    done
done
