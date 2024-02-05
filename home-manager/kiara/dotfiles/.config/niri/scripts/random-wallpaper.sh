#!/usr/bin/env sh
pidof swaybg && kill -9 $(pidof swaybg)
find ~/Pictures/wallpapers/ \
  | sort -R \
  | tail -n 1 \
  | while read -r img ; do \
  	  swaybg -m fill -o '*' -i $img;
  	  wal -i $img;
  	done
