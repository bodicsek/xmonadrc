#!/bin/sh

mute_state=`cat ~/.xmonad/volume/.mute.state`

if [ $mute_state -eq 1 ]
then
    vol="--"
else
    vol=`pactl list sinks | grep 'Volume: 0:'| sed -r 's/.+Volume: 0:\s*([0-9]+)%.+/\1/'`
fi

echo "Vol:" $vol
