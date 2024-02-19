#!/bin/sh

CONF_DIR="$(dirname $(readlink -f "$0"))/.."

case "$1" in
start)
    exec picom --config "$CONF_DIR/picom.conf" --daemon > /dev/null 2>&1
    ;;
stop)
    exec pkill -x picom
    ;;
*)
    echo 'usage:' $0 'start|stop'
    exit 1
    ;;
esac
