#!/bin/zsh

killall polybar

polybar mainmybar -c ~/.config/i3/polybar &

if xrandr --query | grep "^DP1 connected"; then
  if xrandr --query | grep "^DP2 connected"; then
    echo "2 external DP monitor found"
    polybar mybar -c ~/.config/i3/polybar &
    polybar mybar2 -c ~/.config/i3/polybar &
  fi
fi
