#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        if [[ $m == "DP-0" ]]; then
          MONITOR=$m polybar --reload mainbar -c ~/.config/polybar/config.ini &        
        else   
          MONITOR=$m polybar --reload leftbar -c ~/.config/polybar/config.ini &        
        fi
      done 
fi

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1-$USER.log /tmp/polybar2-$USER.log
#polybar black >>/tmp/polybar1.log 2>&1 & disown
#polybar example -r >>/tmp/polybar1-$USER.log 2>&1 & disown
echo "Bars launched..."
