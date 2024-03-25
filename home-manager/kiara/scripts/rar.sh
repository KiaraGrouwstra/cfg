#!/usr/bin/env sh
# unarchive a rar file
file="$1"
base="$(dirname $file)/$(basename $file .rar)"
mkdir -p "$base" && \
unrar-free -x "$file" && \
xdg-open "$base"
