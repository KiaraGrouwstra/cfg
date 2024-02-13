#!/usr/bin/env sh
(pidof rofi && kill -9 $(pidof rofi)) || rofi -show drun -show-icons
