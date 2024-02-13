#!/usr/bin/env sh
(pidof anyrun && kill -9 $(pidof anyrun)) || anyrun --plugins libapplications.so
