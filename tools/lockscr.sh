#!/bin/sh

# https://github.com/google/xsecurelock

case "$1" in
daemon)
    xset s on
    xset s 600 5 # TIME_LOCK TIME_DIM (sec)
    exec env \
    XSECURELOCK_FONT='mono-24' \
    XSECURELOCK_AUTH_BACKGROUND_COLOR='#10254e' \
    XSECURELOCK_AUTH_FOREGROUND_COLOR='#eae2d8' \
    XSECURELOCK_AUTH_WARNING_COLOR='#c76e7c' \
    XSECURELOCK_AUTH_TIMEOUT=60 \
    XSECURELOCK_BACKGROUND_COLOR='#6a87a6' \
    XSECURELOCK_BLANK_TIMEOUT=120 \
    XSECURELOCK_PASSWORD_PROMPT=asterisks \
    XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0 \
    XSECURELOCK_COMPOSITE_OBSCURER=0 \
    XSECURELOCK_SHOW_DATETIME=1 \
    XSECURELOCK_DATETIME_FORMAT='%F %a %T' \
    xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
    ;;
kill)
    xset s default
    xset s off
    pkill -SIGTERM --exact xss-lock
    ;;
now)
    ;&
'')
    exec xset s activate
    ;;
*)
    echo 'usage:' $0 '[daemon|kill|now]'
    exit 1
    ;;
esac
