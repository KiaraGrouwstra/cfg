set -o vi

# nix-shell
any-nix-shell zsh --info-right | source /dev/stdin

# guix
GUIX_PROFILE="$HOME/.config/guix/current"
if [ -f "$GUIX_PROFILE/etc/profile" ]; then
  . "$GUIX_PROFILE/etc/profile"
fi

# flatpak
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share

# yazi: update current working directory on exit
# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
function yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# markdown
function mrkd() { pandoc ${@:1:2} | lynx -stdin; }
# TODO: style browser for local html files
function markdown() {
  pandoc $1 >/tmp/$1.html
  xdg-open /tmp/$1.html
}
