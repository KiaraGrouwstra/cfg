#!/usr/bin/env sh

# # bisecting dep's perspective
# # after: git bisect $BAD $GOOD
# export DEPENDENCY_INPUT=niri-src
# export DEPENDENCY_URL=https://github.com/YaLTeR/niri
# export SYSTEM_REPO=~/Downloads/nix/nixos
export DEPENDENCY_INPUT=$0
export DEPENDENCY_URL=$1
export SYSTEM_REPO=$2

LOCK_FILE=$SYSTEM_REPO/flake.lock
TARGET_COMMIT=$(git rev-parse HEAD)
CURRENT_COMMIT=$(cat $LOCK_FILE | jq -r ".nodes.[\"${DEPENDENCY_INPUT}\"].locked.rev")
sed -E -i "s/$CURRENT_COMMIT/$TARGET_COMMIT/g" $LOCK_FILE
TARGET_HASH=$(nix-prefetch-url "${DEPENDENCY_URL}/archive/${TARGET_COMMIT}.zip" --type sha256)
CURRENT_HASH=$(cat $LOCK_FILE | jq -r ".nodes.[\"${DEPENDENCY_INPUT}\"].locked.narHash")
sed -E -i "s/$CURRENT_HASH/$TARGET_HASH/g" $LOCK_FILE

export DEPENDENCY_PATH=$PWD
cd $SYSTEM_REPO
sudo nixos-rebuild switch --flake .#$USER-$(hostname)
cd $DEPENDENCY_PATH
