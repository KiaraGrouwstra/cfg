# nix-shell
any-nix-shell zsh --info-right | source /dev/stdin

# guix
GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"

# flatpak
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share

# kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# markdown
function mrkd() { pandoc ${@:1:2} | lynx -stdin; }
function markdown() {
  pandoc $1 > /tmp/$1.html
  xdg-open /tmp/$1.html
}
