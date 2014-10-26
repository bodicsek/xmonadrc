#!/bin/sh

mute_state=`cat ~/.xmonad/volume/.mute.state`

if [ $mute_state -eq 1 ]
then
    pactl set-sink-mute 0 0
    echo "0" > ~/.xmonad/volume/.mute.state
else
    pactl set-sink-mute 0 1
    echo "1" > ~/.xmonad/volume/.mute.state
fi
