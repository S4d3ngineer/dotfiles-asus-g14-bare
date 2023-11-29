xrdb -merge ~/.Xresources

# this might be needed due to having lightdm installed and configured by arch install and then being removed
dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

setxkbmap pl

/home/adam/scripts/external-monitor-connection.sh &

~/.fehbg &

exec i3
