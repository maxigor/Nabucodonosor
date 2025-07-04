#!/bin/bash

picom &
alacritty &
protonvpn-app &
firefox &
thunderbird &
#qbittorrent &
insync start &
# spotify-launcher &
sleep 3 
fcitx5 &
xset dpms 0 0 300 &
xautolock -time 5 -locker i3lock-fancy &
setxkbmap -model abnt2 -layout us -variant intl &
sleep 5
./home/max/docker_Stop.sh &
