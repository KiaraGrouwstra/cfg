#!/usr/bin/env sh
# show a menu of desktop entries using wofi
(pidof wofi && kill -9 $(pidof wofi)) || wofi
