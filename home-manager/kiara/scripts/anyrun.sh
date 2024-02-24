#!/usr/bin/env -S nix shell nixpkgs#anyrun --command sh
(pidof anyrun && kill -9 $(pidof anyrun)) || anyrun --plugins libapplications.so
