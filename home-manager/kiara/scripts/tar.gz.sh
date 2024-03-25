#!/usr/bin/env sh
# unarchive a .tar.gz file
file="$1"
base="$(dirname $file)/$(basename $file .tar.gz)"
mkdir -p "$base" && \
tar -xvf "$file" --directory="$base" && \
xdg-open "$base"
