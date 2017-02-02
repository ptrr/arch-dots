#!/bin/sh

killall polybar
polybar bar1 -c ~/.config/i3/polybar &
#polybar bar2 -c ~/.config/i3/polybar &
polybar topbar1 -c ~/.config/i3/polybar &
#polybar topbar2 -c ~/.config/i3/polybar  &
