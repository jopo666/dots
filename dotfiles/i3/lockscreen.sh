#!/bin/bash
resolution=$(xrandr | awk '{print $8$9$10}' | head -n 1 | head -c -2)
convert -resize $resolution $HOME/.config/i3/lockscreen.png /tmp/lockscreen.png
i3lock -i /tmp/lockscreen.png -e -u
sleep 600; pgrep i3lock && xset dpms force off
