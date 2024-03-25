#!/usr/bin/env sh
# show a menu of desktop entries using rofi
(pidof rofi && kill -9 $(pidof rofi)) || rofi -show drun -show-icons
