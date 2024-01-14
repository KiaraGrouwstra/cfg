#!/usr/bin/env sh

systemctl --user restart kanshi
chosen=$(printf "󰍺  Extend\n󰍹  External\n󰪫  Internal" | rofi -dmenu -i -theme-str '@import "displays.rasi"')

case "$chosen" in
	"󰍺  Extend") kanshictl switch extend ;;
	"󰍹  External") kanshictl switch external ;;
	"󰪫  Internal") kanshictl switch internal ;;
	*) exit 1 ;;
esac
