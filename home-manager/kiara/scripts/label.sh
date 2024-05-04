#!/usr/bin/env -S nix shell nixpkgs#git --command sh
if [ -z "$(git status --untracked-files=no --porcelain)" ]; then
  msg=$(git log -1 --pretty=%B)
else
  msg=$(cat .git/COMMIT_EDITMSG)
fi
echo $msg | head -n 1 | sed -E 's/[^a-zA-Z0-9:_\.-]+/_/g'
