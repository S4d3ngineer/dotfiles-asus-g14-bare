#!/usr/bin/bash
#
restartDunst() {
  killall dunst; dunst & 
}

#########################

onConnect() {
    echo onConnection
    xrandr --output DisplayPort-2 --auto
    xrandr --output DisplayPort-1 --auto
    xrandr --output DisplayPort-1-1 --auto
    xrandr --output DisplayPort-1-2 --auto
    xrandr --output eDP-1 --off
    xrandr --output eDP --off
#    feh --bg-fill ~/.i3/res/wallpaper.png
    echo "Xft.dpi: 120" | xrdb -merge
    echo "*dpi: 120" | xrdb -merge
    i3-msg restart
    restartDunst
}

onDisconnect() {
    echo onDisconnection
    xrandr --output eDP-1 --auto
    xrandr --output eDP --auto
    xrandr --output DisplayPort-2 --off
    xrandr --output DisplayPort-1 --off
    xrandr --output DisplayPort-1-1 --off
    xrandr --output DisplayPort-1-2 --off
#    feh --bg-fill ~/.i3/res/wallpaper.png
    echo "Xft.dpi: 192" | xrdb -merge
    echo "*dpi: 192" | xrdb -merge
    i3-msg restart
    restartDunst
}

#########################

handleScreenSetup() {
    if xrandr -q | grep -qw 'DisplayPort-2 connected'; then
        onConnect
    elif xrandr -q | grep -qw 'DisplayPort-1 connected'; then
        onConnect
    elif xrandr -q | grep -qw 'DisplayPort-1-1 connected'; then
        onConnect
    elif xrandr -q | grep -qw 'DisplayPort-1-2 connected'; then
        onConnect
    else
        onDisconnect
    fi
}

handleScreenSetup

xev -root -event randr | grep --line-buffered XRROutputChangeNotifyEvent | \
while IFS= read -r line; do
    handleScreenSetup
done
