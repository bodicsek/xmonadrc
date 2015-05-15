#!/bin/sh

mute_state=`cat ~/.xmonad/volume/.mute.state`

if [ $mute_state -eq 1 ]
then
    vol="--"
else
    vol=`pactl list sinks | grep 'Volume: front-left:' | sed -r 's/Volume: front-left:.+\/\s*([0-9]+)%.+/\1/'`
fi

echo "Vol:" $vol
