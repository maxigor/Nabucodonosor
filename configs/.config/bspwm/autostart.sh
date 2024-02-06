#!/bin/bash

picom &
alacritty &
firefox &
mullvad-vpn &
thunderbird &
qbittorrent &
insync start &
telegram-desktop &
discord &
steam &
brave &
notion-app &
spotify-launcher &
sleep 3 
fcitx5 &
# hexchat &
xautolock -time 5 -locker i3lock-fancy &
xset s 306 306 &
setxkbmap -model abnt2 -layout us -variant intl &
sleep 5
bitcoind &
