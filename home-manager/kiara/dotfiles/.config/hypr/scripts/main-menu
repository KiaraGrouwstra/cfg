#!/usr/bin/env sh
# menu of menus
# unfortunately messy as bash won't retain strings as multi-line when stored in variables
mode=$(rofi --help | grep -E '• \+?[a-z\-]+$' | sed -E 's/\s+• \+?//g' | rofi -dmenu)
rofi -show $mode | wl-copy
