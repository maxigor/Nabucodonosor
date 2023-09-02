#!/bin/bash

picom &
setxkbmap -model abnt2 -layout us -variant intl &
xautolock -time 5 -locker i3lock-fancy &
xset s 306 306 &
xset dpms 300 &
alacritty &
nordvpn c &
firefox &
thunderbird &
qbittorrent &
insync start &
telegram-desktop &
discord &
spotify-launcher &
steam &
brave &
notion-app &
hexchat &
