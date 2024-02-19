#!/bin/sh

case $(
    echo -en 'Shutdown\nReboot\n' |
    rofi -no-plugins -dmenu -i -p 'Power' || exit 1
) in
Shutdown)
    exec shutdown now
    ;;
Reboot)
    exec shutdown -r now
    ;;
esac
exit 1
