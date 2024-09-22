# kiara's nix config

[![Gitea Last Commit](https://img.shields.io/gitea/last-commit/kiara/cfg?gitea_url=https%3A%2F%2Fcodeberg.org&style=flat&logo=forgejo&logoColor=orange&cacheSeconds=3600)](https://codeberg.org/kiara/cfg)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/KiaraGrouwstra/cfg?style=flat&logo=github&logoColor=white&cacheSeconds=86400)](https://github.com/KiaraGrouwstra/cfg)
[![Gitea Issues](https://img.shields.io/gitea/issues/open/kiara/cfg?gitea_url=https%3A%2F%2Fcodeberg.org&style=flat&cacheSeconds=1800)](https://codeberg.org/kiara/cfg/issues/)

This is my setup for [NixOS](https://nixos.org/).

## philosophy

- reproducible
  - NixOS with flakes to lock versions
  - [ephemeral root](https://wiki.nixos.org/wiki/Impermanence) to stay conscious about unreproduced state
- ergonomics
  - keyboard-first favoring vim-like keybinds
- intuitiveness
  - scrollable tiling

## screenshots

(credit: [wallpaper](https://www.artstation.com/artwork/LyG3K) by Alena Aenami.)

<details>
<summary>
JIT-installed neofetch
</summary>

![neofetch](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/neofetch.png)

thefuck plugin for zsh (hit double `Esc`) filled the JIT-install command for the missing app neofetch.
the expanded notification bar [`SwayNotificationCenter`](https://github.com/ErikReider/SwayNotificationCenter/) is shown with a notification about a completed rebuild. this menu can be opened using `Super+\`` or by right-clicking the 'Windows' button.

</details>

<details>
<summary>
file managers
</summary>

![yazi](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/files.png)

[`yazi`](https://yazi-rs.github.io/) is a terminal-based file manager with vim-like keybindings.
[`thunar`](https://gitlab.xfce.org/xfce/thunar) is available as a graphical alternative.

![thunar](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/notifications-files.png)

</details>

<details>
<summary>
firefox
</summary>

![firefox](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/firefox.png)

Firefox is used as a web browser, with some [basic add-ons](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/firefox.nix).

</details>

<details>
<summary>
terminal-based IDE
</summary>

![helix](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/ide.png)

running `ide` in the WezTerm terminal opens a terminal-based IDE at that directory, consisting of:

- Git TUI [`lazygit`](https://github.com/jesseduffield/lazygit), offering a terminal-based way to work with Git repositories, including vim keybindings.
- [`helix`](https://helix-editor.com/), featuring language servers for nix (thru [`nixd`](https://github.com/nix-community/nixd)) and others
- a shell, using [Zsh](https://www.zsh.org/) and decorated using [`powerline-go`](https://github.com/justjanne/powerline-go)

![lazygit](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/lazygit.png)

As a back-up, the graphical [VSCodium](https://vscodium.com/) is provided (with some [plugins](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/vscode.nix)).

</details>

<details>
<summary>
application menu
</summary>

![anyrun](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/runner.png)

Application menu [`anyrun`](https://github.com/anyrun-org/anyrun) can be opened using `Super+Space` or by left-clicking the 'Windows' button.

</details>

<details>
<summary>
JIT application menu
</summary>

![jit menu](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/jit.png)

A menu to JIT-install and run applications can be opened using `Super+Shift+Space`.

</details>

<details>
<summary>
audio volume 
</summary>

![volume control](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/volume.png)

Right-clicking the volume icon in the bar opens [Pulse Audio Volume Control](https://freedesktop.org/software/pulseaudio/pavucontrol/#overview).

</details>

<details>
<summary>
wifi
</summary>

![nmtui](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/wifi.png)

Pressing `Super+i` or right-clicking the wifi icon opens the [Network Manager TUI](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmtui).

</details>

<details>
<summary>
show dependency age
</summary>

![just age](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/age.png)

command `just age` showing the age of any dependencies included in `flake.lock`

</details>

<details>
<summary>
emoji picker
</summary>

![emoji picker](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/emoji-picker.png)

pressing the Microsoft keyboard's emoji key](https://support.microsoft.com/en-us/topic/use-microsoft-ergonomic-keyboard-c917dad0-3797-d97b-efb3-fbe27ac9703c#ID0EDFBBDDD) (`Super-Ctrl-Alt-Shift-Space`) triggers an emoji picker using fuzzy picker [fzf](https://github.com/junegunn/fzf).

</details>

<details>
<summary>
symbol picker
</summary>

![anyrun symbols](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/anyrun-symbols.png)

keybind `Super+B` lets the user pick symbols using [`anyrun`'s `symbols` plugin](https://github.com/anyrun-org/anyrun/blob/master/plugins/symbols/README.md)

</details>

<details>
<summary>
file picker
</summary>

![file picker](https://codeberg.org/kiara/cfg/raw/branch/main/screenshots/file-picker.png)

pressing `CTRL-T` in the shell opens [`fzf`'s file picker](https://github.com/junegunn/fzf#key-bindings-for-command-line), copying the selected file or directory path to the clipboard.

</details>

## devices

This configuration was made with the following devices in mind:

| Name | Use | Model | Config |
|------|-----|-------|--------|
| `hammer` | home laptop | [Lenovo IdeaPad Slim 5 16ABR8](https://psref.lenovo.com/Product/IdeaPad/IdeaPad_Slim_5_16ABR8) | `nixosConfigurations` |
| `orca` | work laptop | [Dell XPS 13 9340](https://www.dell.com/en-us/shop/dell-laptops/xps-13-laptop/spd/xps-13-9340-laptop) | `homeConfigurations` |

## usage

### prerequisites

- update [`./hosts/<PROFILE>/hardware-configuration.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/hardware-configuration.nix)
- on an existing system, [disable impermanence](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/ephemeral.nix#L3) to prevent existing files not [opted into persistence](https://github.com/search?q=repo%3AKiaraGrouwstra%2Fcfg%20persistence&type=code) from being [wiped on boot](https://wiki.nixos.org/wiki/Impermanence)
- replace currently [hardcoded values](https://codeberg.org/kiara/cfg/issues/320)
- get a user password by either:
  - [setting one](https://nixos.org/manual/nixos/stable/options#opt-users.users._name_.initialPassword) in [`./hosts/<PROFILE>/configuration.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/configuration.nix)
  - decoding secrets by adding the [`age`](https://github.com/FiloSottile/age) keys file to `/etc/nixos/keys.txt`

### installation

<details>
<summary>clean install from <a href="https://nixos.org/download/#nixos-iso">NixOS USB</a></summary>

```sh
cd Downloads
git clone https://codeberg.org/kiara/cfg.git
cd cfg
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko -f .#hammer
dest=/mnt/persist/home/kiara/.config/sops/age/
sudo mkdir -p $dest
sudo cp -r ./. $dest
sudo cp ~/Downloads/keys.txt $dest  # import/create
sudo nixos-install --no-root-passwd --flake .#default --no-root-passwd
sudo nixos-enter --root /mnt
cp /etc/{machine-id,group,passwd,shadow} /persist/etc
```

</details>

<details>
<summary>install from <a href="https://nixos.org/manual/nixos/stable/#sec-installation">existing</a> NixOS system</summary>

```sh
$ nix --experimental-features "nix-command flakes" run nixpkgs#just -- switch
```

</details>

### commands

```sh
$ just -l
Available recipes:
    age                   # Check when inputs were last updated
    boot                  # Build a new configuration
    clean                 # Remove all generations older than 7 days
    decode                # Decode secrets
    default               # default action: list actions
    dry                   # Dry-build a new configuration
    encode                # Encode secrets
    ephemeral dir="$HOME" # Show what has yet to be persisted in a folder. Usage: just ephemeral $PWD | $PAGER
    fmt                   # Format code
    gc                    # Garbage collect all unused nix store entries
    home                  # Rebuild the home config
    repl                  # Open a Nix REPL - run manually to load flake: `:lf .`
    switch                # Rebuild the system
    test                  # Run tests
    up                    # Update all inputs
    upp input             # Update specific input. Usage: just upp nixpkgs
```

... or if `just` isn't available yet:

```sh
nix run nixpkgs#just -- -l
```

### impermanence

to ensure you can persist useful state on an ephemeral system, you can find say:

- newly created (5 mins) files: `find ~ -cmin -5`
- files now on root: `tree -x /`
- diffs from last backup: [`rsync --dry-run`](https://willbush.dev/blog/impermanent-nixos/#finding-what-to-persist)

## features

- secrets: [sops](https://github.com/getsops/sops)
- formatter: [treefmt](https://github.com/numtide/treefmt)
- commands: [just](https://just.systems/)
- CI: [garnix](https://garnix.io/)
- cache: [`./cachix/`](https://codeberg.org/kiara/cfg/src/branch/main/cachix)
- environment loader: [direnv](https://direnv.net/)
- declarative partitioning: [disko](https://github.com/nix-community/disko)
- [ephemeral root](https://wiki.nixos.org/wiki/Impermanence): [impermanence](https://github.com/nix-community/impermanence)

### fixes for flake

- the `flake.lock`ed nixpkgs is used for:
  - nix commands
  - 'command not found' errors
- `nix flake show` is fixed using [Flake Schemas](https://github.com/NixOS/nix/pull/8892)
- `$SHELL` is retained in `nix shell`

## used software

| Component      | Software     |
|----------------|--------------|
| Nix interpreter                                                       | [Lix](https://lix.systems/) |
| Nix shell                                                             | [Lorri](https://github.com/nix-community/lorri) |
| [DM](https://codeberg.org/kiara/cfg/issues?labels=201797)             | [TUIgreet](https://github.com/apognu/tuigreet) |
| [Compositor](https://codeberg.org/kiara/cfg/issues?labels=201796)     | [Niri](https://github.com/YaLTeR/niri/)[^1] |
| [Bar](https://codeberg.org/kiara/cfg/issues?labels=201795)            | [Waybar](https://github.com/Alexays/Waybar/) |
| [Notifications](https://codeberg.org/kiara/cfg/issues?labels=201793)  | [Swaynotificationcenter](https://github.com/ErikReider/SwayNotificationCenter/) |
| [Menu](https://codeberg.org/kiara/cfg/issues?labels=201794)           | [Anyrun](https://github.com/Kirottu/anyrun) |
| [Web browser](https://codeberg.org/kiara/cfg/issues?labels=201788)    | [Firefox](https://hg.mozilla.org/mozilla-central/) |
| [File browser](https://codeberg.org/kiara/cfg/issues?labels=201789)   | [Yazi](https://yazi-rs.github.io/) |
| [Terminal](https://codeberg.org/kiara/cfg/issues?labels=201790)       | [Wezterm](https://github.com/wez/wezterm) |
| [Text editor](https://codeberg.org/kiara/cfg/issues?labels=201792)    | [VSCodium](https://github.com/vscodium/vscodium) |
| [Editor](https://codeberg.org/kiara/cfg/issues?labels=201792) (shell) | [Helix](https://helix-editor.com) |
| [Shell](https://codeberg.org/kiara/cfg/issues?labels=201791)          | [Zsh](https://zsh.org/) |
| Fuzzy finder   | [Fzf](https://github.com/junegunn/fzf) |
| Pager          | [Nvimpager](https://github.com/lucc/nvimpager) |
| Text-to-speech | [Piper](https://rhasspy.github.io/piper-samples/) thru [LocalAI](https://localai.io/)

[^1]: While Niri uses [Wayland](https://wayland.freedesktop.org/), X11 applications can be emulated thru [`xwayland-run`](https://gitlab.freedesktop.org/ofourdan/xwayland-run).
## style

- theming module: [Stylix](https://danth.github.io/stylix/)
- GUI theme: [Catppuccin-Mocha-Maroon](https://catppuccin.com/)
- shell theme: [base16-classic-dark](https://base16.netlify.app/previews/base16-classic-dark)
- icons: [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- fonts:
  - regular: [DejaVu Sans](https://www.fontsquirrel.com/fonts/dejavu-sans)
  - monospace [MartianMono](https://github.com/evilmartians/mono)
  - emoji: [Twemoji](https://github.com/jdecked/twemoji)

## package types

- [Nix](https://search.nixos.org/)
  - [NUR](https://nur.nix-community.org/)
  - [Flakes](https://flakestry.dev/)
- [Flatpak](https://flathub.org/)
- [AppImage](https://appimagehub.com/)
- [Progressive Web Apps](https://pwasforfirefox.filips.si/)
- [Windows](https://www.winehq.org/)

## command drop-ins

| command | drop-in | improvements |
|-|-|-|
| `cd` | n/a | (can skip it in Zsh) |
| `cd` | [`z`](https://github.com/ajeetdsouza/zoxide) | remembers visited locations |
| `cd` | `cd` ([enhancd](https://github.com/babarot/enhancd)) | interactive directory picker using `cd`, `cd .` or `cd ..` |
| `ls` | [`eza`](https://github.com/eza-community/eza) (aliased to `ls`) | friendlier output and interface |
| `cat` | [`bat`](https://github.com/sharkdp/bat) | syntax highlighting |
| `less` | `less` ([lesspipe](https://github.com/wofr06/lesspipe)) | syntax highlighting |
| `find` | [`fd`](https://github.com/sharkdp/fd) | faster, friendlier interface, respects `.gitignore` |
| `grep` | [`rg`](https://github.com/BurntSushi/ripgrep) | friendlier interface |
| `make` | [`just`](https://github.com/casey/just) | show comments, friendlier file format |
| `ssh` | [`xxh`](https://github.com/xxh/xxh) | use your favorite shell |

## keybinds

Used keyboard layouts, with `Caps Lock` remapped to `Esc`:

- [workman-programmer](https://workmanlayout.org/#introducing-the-workman-keyboard-layout), with application keymaps [modified](https://gitlab.com/ajgrf/workman-vim-bindings) to keep arrow actions `h`/`j`/`k`/`l` (+ actions 'y'/'n') in their ergonomic qwerty positions (at the cost of moving actions `e`/`o` to keys `h`/`l`)
- `en-us` (qwerty)

Application keybinds, tweaked to layout by setting `config.keyboard.active`:

- `niri`: see [`./home-manager/kiara/niri.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/niri.nix) (TODO)
- [`swaynotificationcenter`](https://github.com/ErikReider/SwayNotificationCenter#control-center-shortcuts)
- [`firefox`](https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly) ([`vimium-c`](https://github.com/gdh1995/vimium-c#keyboard-bindings))
- [`yazi`](https://yazi-rs.github.io/docs/quick-start#keybindings) ([custom](https://yazi-rs.github.io/docs/tips))
- [`wezterm`](https://wezfurlong.org/wezterm/config/default-keys.html) (overrides: [`./home-manager/kiara/wezterm.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/wezterm.nix))
- [`vscodium`](https://code.visualstudio.com/docs/getstarted/keybindings) (overrides: [`./home-manager/kiara/vscode.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/vscode.nix))
- [`helix`](https://docs.helix-editor.com/keymap.html) (overrides: [`./home-manager/kiara/features/text/helix.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/features/text/helix.nix))
- [`neovim`](https://neovim.io/doc/user/)
- [`zsh`](https://gist.github.com/2KAbhishek/9c6d607e160b0439a186d4fbd1bd81df)
  - `Tab` completion should suggest sub-commands thru [`tldr`](https://dbrgn.github.io/tealdeer/) pages
  - on error hit `Esc` (2x) to trigger [`fuck`](https://github.com/nvbn/thefuck/) suggestion
  - [thru `fzf`](https://github.com/junegunn/fzf#key-bindings-for-command-line)
    - `CTRL-T` - Paste the selected files and directories onto the command-line
    - `ALT-C` - `cd` into the selected directory
- [`gum`](https://github.com/charmbracelet/gum/blob/main/pager/pager.go)
- [`zathura`](https://defkey.com/zathura-shortcuts)

## [mouse](https://github.com/YaLTeR/niri/wiki/Gestures)

### bottom bar

| module | left-click | right-click | scroll |
|-|-|-|-|
| start button | open [`anyrun`](https://github.com/anyrun-org/anyrun) application launcher | toggle [`swaync`](https://github.com/ErikReider/SwayNotificationCenter/) notifications | - |
| media player | toggle play/pause | skip ahead | previous/next |
| clock | - | toggle month/year in calendar pop-up | previous/next in calendar pop-up |
| volume | toggle mute | [Pulse Audio Volume Control](https://freedesktop.org/software/pulseaudio/pavucontrol/#overview) | change volume |
| memory | manage processes with [Bottom](https://github.com/ClementTsang/bottom) | - | - |
| CPU | manage processes with [Bottom](https://github.com/ClementTsang/bottom) | - | - |
| battery | run battery viewer `powersupply` | - | - |
| storage | garbage-collect nix | show big files/folders using [`dust`](https://github.com/bootandy/dust) | - |
| network | manage network by [`networkmanager_dmenu`](https://github.com/firecat53/networkmanager-dmenu) | manage network by [`nmtui`](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_ip_networking_with_nmtui) | - |
| systray | (application-specific) | open application context menu | - |

## what goes where

| what | where |
|-|-|
| [system configuration](https://search.nixos.org/options) | [`./hosts/`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/) |
| [home-manager configuration](https://nix-community.github.io/home-manager/options.xhtml) | [`./home-manager/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/) |
| binaries and command wrappers | [`./home-manager/kiara/commands.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/commands.nix) |
| reusable [modules](https://wiki.nixos.org/wiki/Module) | [`./modules/`](https://codeberg.org/kiara/cfg/src/branch/main/modules) |
| custom [functions](https://noogle.dev/) | [`./lib/`](https://codeberg.org/kiara/cfg/src/branch/main/lib) |
| [custom packages](https://blog.ielliott.io/nix-docs/mkDerivation.html) | [`./pkgs/*.nix`](https://codeberg.org/kiara/cfg/src/branch/main/pkgs) (from flake inputs: [`./pkgs/default.nix`](https://codeberg.org/kiara/cfg/src/branch/main/pkgs/default.nix)) |
| [overlays](https://wiki.nixos.org/wiki/Overlays) | [`./overlays/*.nix`](https://codeberg.org/kiara/cfg/src/branch/main/overlays) (from flake inputs: [`./flake.nix`](https://codeberg.org/kiara/cfg/src/branch/main/flake.nix)) |
| [LSP](https://langserver.org/) (vscodium / [coc.nvim](https://github.com/neoclide/coc.nvim)) | [`./home-manager/kiara/features/development/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/features/development/) |
| shell scripts | [`./home-manager/kiara/scripts/*.sh`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/scripts/) |
| [dotfiles](https://www.freecodecamp.org/news/dotfiles-what-is-a-dot-file-and-how-to-create-it-in-mac-and-linux/) | [`./home-manager/kiara/dotfiles/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles/) + [`./home-manager/kiara/dotfiles.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles.nix) |
| custom [desktop entries](https://freedesktop.org/wiki/Specifications/desktop-entry-spec/) | [`./home-manager/kiara/desktop.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/desktop.nix) |
| [MIME types](https://www.digipres.org/formats/mime-types/) | [`./home-manager/kiara/mime.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/mime.nix) |
| [file templates](https://fedoramagazine.org/creating-using-nautilus-templates/) | [`./home-manager/kiara/dotfiles/Templates/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles/Templates/) |
| keybinds | [`./home-manager/kiara/niri.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/niri.nix) |
| persisted state | [`./hosts/hammer/persistence.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/persistence.nix) |
