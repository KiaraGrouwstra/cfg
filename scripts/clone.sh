#!/usr/bin/env -S nix shell nixpkgs#git
# go from clicking an SSH URI to having it opened in the local IDE
uri="${1}"
directory="$(basename "${uri}" .git)"
user="$(echo "${uri}" | grep -Po '(?<=:).+?(?=/)')"
my_git_user="KiaraGrouwstra"  # technically differs by forge, for now hardcoding mine for github
remote="$(echo "${uri}" | sed "/${user}/${my_git_user}/")"
# perform steps: git clone, enter directory, add fork remote, open IDE
git clone "${uri}" && cd "${directory}" && git add remote "${USER}" "${remote}" && ide
# command="git clone '${uri}' && cd '${directory}' && git add remote '${USER}' '${remote}' && ide"
# wezterm -e --always-new-process sh -c "${command}"
