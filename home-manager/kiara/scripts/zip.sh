#!/usr/bin/env sh
# unarchive a zip file
file="$1"
base="$(dirname $file)/$(basename $file .zip)"
mkdir -p "$base" && \
unzip "$file" -d "$base" && \
xdg-open "$base"
