#!/usr/bin/env sh
(pidof wofi && kill -9 $(pidof wofi)) || wofi
