# kiara's nix config

[![Gitea Last Commit](https://img.shields.io/gitea/last-commit/kiara/cfg?gitea_url=https%3A%2F%2Fcodeberg.org&style=flat&logo=forgejo&logoColor=orange&cacheSeconds=3600)](https://codeberg.org/kiara/cfg)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/KiaraGrouwstra/cfg?style=flat&logo=github&logoColor=white&cacheSeconds=86400)](https://github.com/KiaraGrouwstra/cfg)
[![Gitea Issues](https://img.shields.io/gitea/issues/open/kiara/cfg?gitea_url=https%3A%2F%2Fcodeberg.org&style=flat&cacheSeconds=1800)](https://codeberg.org/kiara/cfg/issues/)

This is my setup for [NixOS](https://nixos.org/).

<!-- ![screenshot showing niri with neofetch and yazi in wezterm. thefuck plugin for zsh filled the JIT-install command for the missing app neofetch.](./screenshot.png) -->

<details>
<summary>
Screenshot
</summary>
<img src="https://codeberg.org/kiara/cfg/raw/branch/main/screenshot.png" alt="screenshot showing niri with neofetch and yazi in wezterm.">
screenshot showing niri with neofetch and yazi in wezterm.
thefuck plugin for zsh filled the JIT-install command for the missing app neofetch.
<a href="https://www.artstation.com/artwork/LyG3K">wallpaper</a> by Alena Aenami.
</details>

## usage

<details>
<summary>clean install from NixOS USB</summary>
<div class="sourceCode">
<pre class="sourceCode sh">
<code class="sourceCode bash">cd Downloads
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
</code>
</pre>
</div>
</details>

### prerequisites

- [install](https://nixos.org/manual/nixos/stable/#sec-installation) NixOS
- update [`./hosts/<PROFILE>/hardware-configuration.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/hardware-configuration.nix)
- get a user password by either:
  - [setting one](https://nixos.org/manual/nixos/stable/options#opt-users.users._name_.initialPassword) in [`./hosts/<PROFILE>/configuration.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/configuration.nix)
  - decoding secrets by adding the [`age`](https://github.com/FiloSottile/age) keys file to `/etc/nixos/keys.txt`

### commands

```sh
$ just -l
Available recipes:
    age       # Check when inputs were last updated
    boot      # Build a new configuration
    clean     # Remove all generations older than 7 days
    decode    # Decode secrets
    default   # default action: list actions
    encode    # Encode secrets
    fmt       # Format code
    gc        # Garbage collect all unused nix store entries
    home      # Rebuild the home config
    repl      # Open a Nix REPL - run manually to load flake: `:lf .`
    switch    # Rebuild the system
    test      # Run tests
    up        # Update all inputs
    upp input # Update specific input. Usage: just upp nixpkgs
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

the `flake.lock`ed nixpkgs is used for:

- nix commands
- 'command not found' errors

## used software

| Component      | Software     |
|----------------|--------------|
| [DM](https://codeberg.org/kiara/cfg/issues?labels=201797)             | [TUIgreet](https://github.com/apognu/tuigreet) |
| [Compositor](https://codeberg.org/kiara/cfg/issues?labels=201796)     | [Niri](https://github.com/YaLTeR/niri/) |
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

## style

- theming module: [Stylix](https://danth.github.io/stylix/)
- GUI theme: [Catppuccin-Mocha-Maroon](https://catppuccin.com/)
- shell theme: [base16-classic-dark](https://base16.netlify.app/previews/base16-classic-dark)
- icons: [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- fonts:
  - regular: [DejaVu Sans](https://www.fontsquirrel.com/fonts/dejavu-sans)
  - monospace [MartianMono](https://github.com/evilmartians/mono)
  - emoji: [Noto Color Emoji](https://github.com/googlefonts/noto-emoji)

## package types

- [Nix](https://search.nixos.org/)
  - [NUR](https://nur.nix-community.org/)
  - [Flakes](https://flakestry.dev/)
- [Guix](https://packages.guix.gnu.org/)
- [Flatpak](https://flathub.org/)
- [AppImage](https://appimagehub.com/)
- [Progressive Web Apps](https://pwasforfirefox.filips.si/)

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

Used keyboard layout: `en-us` with `Caps Lock` remapped to `Esc`.

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

## mouse

### touchpad

niri supports three-finger swipes between:

- windows (left/right)
- workspaces (up/down)

### bottom bar

| module | left-click | right-click | scroll |
|-|-|-|-|
| media player | toggle play/pause | skip ahead | previous/next |
| clock | - | toggle month/year in calendar pop-up | previous/next in calendar pop-up |
| volume | toggle mute | [Pulse Audio Volume Control](https://freedesktop.org/software/pulseaudio/pavucontrol/#overview) | change volume |
| memory | manage processes with [Gnome System Monitor](https://wiki.gnome.org/Apps/SystemMonitor) | manage processes with [`btop`](https://github.com/aristocratos/btop) | - |
| CPU | open monitoring tool [`zfxtop`](https://github.com/ssleert/zfxtop) | manage processes with [`btop`](https://github.com/aristocratos/btop) | - |
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
| reusable [modules](https://nixos.wiki/wiki/Module) | [`./modules/`](https://codeberg.org/kiara/cfg/src/branch/main/modules) |
| custom [functions](https://noogle.dev/) | [`./lib/`](https://codeberg.org/kiara/cfg/src/branch/main/lib) |
| [custom packages](https://blog.ielliott.io/nix-docs/mkDerivation.html) | [`./pkgs/*.nix`](https://codeberg.org/kiara/cfg/src/branch/main/pkgs) (from flake inputs: [`./pkgs/default.nix`](https://codeberg.org/kiara/cfg/src/branch/main/pkgs/default.nix)) |
| [overlays](https://nixos.wiki/wiki/Overlays) | [`./overlays/*.nix`](https://codeberg.org/kiara/cfg/src/branch/main/overlays) (from flake inputs: [`./flake.nix`](https://codeberg.org/kiara/cfg/src/branch/main/flake.nix)) |
| [LSP](https://langserver.org/) (vscodium / [coc.nvim](https://github.com/neoclide/coc.nvim)) | [`./home-manager/kiara/features/development/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/features/development/) |
| shell scripts | [`./home-manager/kiara/scripts/*.sh`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/scripts/) |
| [dotfiles](https://www.freecodecamp.org/news/dotfiles-what-is-a-dot-file-and-how-to-create-it-in-mac-and-linux/) | [`./home-manager/kiara/dotfiles/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles/) + [`./home-manager/kiara/dotfiles.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles.nix) |
| custom [desktop entries](https://freedesktop.org/wiki/Specifications/desktop-entry-spec/) | [`./home-manager/kiara/desktop.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/desktop.nix) |
| [MIME types](https://www.digipres.org/formats/mime-types/) | [`./home-manager/kiara/mime.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/mime.nix) |
| [file templates](https://fedoramagazine.org/creating-using-nautilus-templates/) | [`./home-manager/kiara/dotfiles/Templates/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/dotfiles/Templates/) |
| keybinds | [`./home-manager/kiara/niri.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/niri.nix) |
| persisted state | [`./hosts/hammer/persistence.nix`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/hammer/persistence.nix) |
