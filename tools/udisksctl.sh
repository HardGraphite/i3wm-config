#!/bin/bash

function notify {
    notify-send --app-name='USB Storage' "$1" "$2"
}

function user_menu {
    echo -en "$2" | rofi -no-plugins -dmenu -i -p "$1" || exit 1
}

function do_mount {
    local item=$( \
        lsblk -npro 'LABEL,NAME,RM,MOUNTPOINT' /dev/disk/by-label/* | \
        # awk 'NF == 3 && $3 == 1 { print $1 " (" $2 ")" }' | \
        awk 'NF == 3 { print $1 " (" $2 ")" }' | \
        rofi -no-plugins -dmenu -i -p 'Mount' \
    )
    local name=$(echo "$item" | sed -nr 's/.*[(](.+)[)]$/\1/p')
    if [[ -z "$name" ]]; then
        exit 1
    fi
    local msg=$(udisksctl mount --no-user-interaction -b "$name" 2>&1)
    if [[ $? = 0 ]]; then
        notify "$item mounted" "$msg"
        exit
    else
        notify "Failed to mount $item" "$msg"
        exit 1
    fi
}

function do_eject {
    local item=$( \
        lsblk -npro 'LABEL,NAME,RM,MOUNTPOINT' /dev/disk/by-label/* | \
        # awk 'NF == 4 && $3 == 1 { print $1 " (" $2 ")" }' | \
        awk 'NF == 4 { print $1 " (" $2 ")" }' | \
        rofi -no-plugins -dmenu -i -p 'Eject' \
    )
    local name=$(echo "$item" | sed -nr 's/.*[(](.+)[)]$/\1/p')
    if [[ -z "$name" ]]; then
        exit 1
    fi
    local msg=$( \
        udisksctl unmount --no-user-interaction -b "$name" 2>&1 && \
        udisksctl power-off --no-user-interaction -b "$name" 2>&1 \
    )
    if [[ $? = 0 ]]; then
        notify "$item ejected" "$msg"
        exit
    else
        notify "Failed to eject $item" "$msg"
        exit 1
    fi
}

case $(user_menu 'USB storage devices' 'Mount\nEject\n') in
'Mount')
    do_mount
    ;;
'Eject')
    do_eject
    ;;
*)
    exit 1
    ;;
esac
