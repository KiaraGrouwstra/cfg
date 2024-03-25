#!/usr/bin/env -S nix shell nixpkgs#git --command sh
# turn a timestamp into a human time indication
# https://unix.stackexchange.com/a/451406/134234
cd /tmp
git init -q
git -c user.email=0 -c user.name=0 commit -q -m 0 --allow-empty --date="$1"
git show --format=%ar | cat
