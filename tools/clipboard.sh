#!/bin/sh

# https://github.com/lucas-mior/clipsim

case "$1" in
daemon)
    exec env XDG_CACHE_HOME=/tmp clipsim --daemon > /dev/null 2>&1
    ;;
select)
    exec clipsim --copy $( \
        clipsim --print 2> /dev/null \
        | sed -zr 's/\n/  /g;s/^([0-9]+)\s(.{0,50}).*/[\1] \2/' \
        | rofi -no-plugins -dmenu -i -p 'Clipboard' -sep '\0' \
        | sed -r 's/^\[([0-9]+)\].*/\1/' \
    ) 2> /dev/null
    ;;
*)
    echo 'usage:' $0 'daemon|select'
    exit 1
    ;;
esac
