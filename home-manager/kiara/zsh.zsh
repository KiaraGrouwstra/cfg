# vi mode
# set -o vi

# keybinds: list key sequences by `cat > /dev/null`
bindkey -s "^[h" ".. \C-j"
bindkey -s "^[k" "ide.sh \C-j"

# keybinds: list actions by `stty -a`
# have ctrl sequences retain their qwerty positions in workman
# stty eof '^h'
# stty intr '^m'  # breaks zsh, making it error SIGINT

# nix-shell
any-nix-shell zsh --info-right | source /dev/stdin

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
