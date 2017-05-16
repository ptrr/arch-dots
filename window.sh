#!/bin/bash

if xrandr --query | grep "HDMI1 connected"; then
  if xrandr --query | grep "HDMI2 connected"; then
    echo "2 external HDMI monitors found"
    xrandr --auto --output "HDMI1" --dpi 96 --mode "1920x1080" --output "eDP1" --off --output "HDMI2" --off
    # --auto --output "HDMI-2" --mode "1920x1080" --right-of "HDMI-1"
  fi
elif xrandr --query | grep "HDMI3 connected"; then
  if xrandr --query | grep "HDMI3 connected"; then
    echo "2 external HDMI- monitors found"
    xrandr --auto --output "HDMI3" --dpi 96 --mode "1920x1200" --output "eDP1" --off --auto --output "HDMI-2" --off
    #--output "HDMI-2" --mode "1920x1080" --right-of "HDMI-1"
  fi
elif xrandr --query | grep "^DP-1 connected"; then
  echo "1 external DP monitor found"
  xrandr --auto --output "DP-1" --dpi 96 --mode "1920x1200" --output "eDP-1" --off
elif xrandr --query | grep "^DP1 connected"; then
  if xrandr --query | grep "^DP2 connected"; then
    echo "2 external DP monitor found"
    xrandr --auto --output "DP2" --dpi 96 --mode "1920x1080" --auto --right-of "DP1" --output "DP1" --dpi 96 --mode "1920x1080" --output "eDP1" --off
  fi
elif xrandr --query | grep "eDP-1 connected"; then
  echo "no external monitor found"
  xrandr --auto --output "eDP-1" --dpi 96 --mode "2880x1800"
else
  echo "no external monitor found"
  xrandr --auto --output "eDP1" --dpi 127 --mode "1920x1200"
fi
