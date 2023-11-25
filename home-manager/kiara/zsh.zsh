# nix-shell
any-nix-shell zsh --info-right | source /dev/stdin

# guix
path+=('/var/guix/profiles/per-user/root/current-guix/bin')
export PATH

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
