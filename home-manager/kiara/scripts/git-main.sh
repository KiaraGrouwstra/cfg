#!/usr/bin/env -S nix shell nixpkgs#git
# commit staged changes to main branch
export BRANCH=$(git rev-parse --abbrev-ref HEAD)
git stash --keep-index --include-untracked && \
git switch main && \
git commit && \
git push && \
git switch $BRANCH && \
git rebase main && \
git push --force && \
git stash pop
