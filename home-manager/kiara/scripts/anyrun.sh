#!/usr/bin/env -S nix shell nixpkgs#anyrun --command sh
# show a menu of desktop entries using anyrun
(pidof anyrun && kill -9 $(pidof anyrun)) || anyrun --plugins libapplications.so
