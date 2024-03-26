# kiara's nix config

This is my setup for [NixOS](https://nixos.org/).

![screenshot showing niri with neofetch and yazi in wezterm](./screenshot.png)

## usage

### prerequisites

- [install](https://nixos.org/manual/nixos/stable/#sec-installation) NixOS
- [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
- update `./hosts/<PROFILE>/hardware-configuration.nix`
- get a user password by either:
  - [setting one](https://nixos.org/manual/nixos/stable/options#opt-users.users._name_.initialPassword) in `./hosts/<PROFILE>/configuration.nix`
  - decoding secrets by adding the [`age`](https://github.com/FiloSottile/age) keys file to `/etc/nixos/keys.txt`

### commands

```sh
$ just -l
Available recipes:
    age       # Check when inputs were last updated
    clean     # Remove all generations older than 7 days
    decode    # Decode secrets
    encode    # Encode secrets
    fmt       # Format code
    gc        # Garbage collect all unused nix store entries
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

## project details

### used software

| Component      | Software     |
|----------------|--------------|
| Compositor     | [Niri](https://github.com/YaLTeR/niri/) |
| Bar            | [Waybar](https://github.com/Alexays/Waybar/) |
| Notifications  | [Swaynotificationcenter](https://github.com/ErikReider/SwayNotificationCenter/) |
| Menu           | [Anyrun](https://github.com/Kirottu/anyrun) |
| Web browser    | [Firefox](https://hg.mozilla.org/mozilla-central/) |
| File browser   | [Yazi](https://yazi-rs.github.io/) |
| Terminal       | [Wezterm](https://github.com/wez/wezterm) |
| Text editor    | [VSCodium](https://github.com/vscodium/vscodium) |
| Editor (shell) | [Neovim](https://neovim.io/) |
| Shell          | [Zsh](https://zsh.org/) |
| Pager          | [Gum](https://github.com/charmbracelet/gum#pager) |
| Fuzzy finder   | [Fzf](https://github.com/junegunn/fzf)

## features

- secrets: [sops](https://github.com/getsops/sops/)
- formatter: [treefmt](https://github.com/numtide/treefmt) + [editorconfig](https://editorconfig.org/)
- commands: [just](https://github.com/casey/just)
- CI: [garnix](https://garnix.io/)
- cache: [`./cachix/`](https://cachix.org/)
- environment loader: [direnv](https://direnv.net/)
- nix commands using `flake.lock`ed nixpkgs

## package types

- [Nix](https://search.nixos.org/)
  - [NUR](https://nur.nix-community.org/)
  - [Flakes](https://flakestry.dev/)
- [Guix](https://packages.guix.gnu.org/)
- [Flatpack](https://flathub.org/)
- [AppImage](https://appimagehub.com/)

### what goes where

| what | where |
|-|-|
| [system configuration](https://search.nixos.org/options) | [`./hosts/`](https://codeberg.org/kiara/cfg/src/branch/main/hosts/) |
| [home-manager configuration](https://nix-community.github.io/home-manager/options.xhtml) | [`./home-manager/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/) |
| binaries and command wrappers | [`./home-manager/kiara/commands/`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/commands/) |
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

### command drop-ins

| command | drop-in |
|-|-|
| `cd` | [`z`](https://github.com/ajeetdsouza/zoxide) |
| `cd` | `cd` ([enhancd](https://github.com/babarot/enhancd)) |
| `ls` | [`eza`](https://github.com/eza-community/eza) (aliased) |
| `cat` | [`bat`](https://github.com/sharkdp/bat) |
| `less` | `less` ([lesspipe](https://github.com/wofr06/lesspipe)) |
| `find` | [`fd`](https://github.com/sharkdp/fd) |
| `grep` | [`rg`](https://github.com/BurntSushi/ripgrep) |
| `make` | [`just`](https://github.com/casey/just) |
| `ssh` | [`xxh`](https://github.com/xxh/xxh) |

### keybinds

- In `zsh` shell:
  - `Tab` completion should suggest sub-commands thru [`tldr`](https://dbrgn.github.io/tealdeer/) pages
  - on error hit `Esc` (2x) to trigger [`fuck`](https://github.com/nvbn/thefuck/) suggestion
  - [thru `fzf`](https://github.com/junegunn/fzf#key-bindings-for-command-line)
    - `CTRL-T` - Paste the selected files and directories onto the command-line
    - `CTRL-R` - Paste the selected command from history onto the command-line
    - `ALT-C` - `cd` into the selected directory
- Niri: see [`./home-manager/kiara/niri.nix`](https://codeberg.org/kiara/cfg/src/branch/main/home-manager/kiara/niri.nix) (TODO)

### style

- theming module: [Stylix](https://danth.github.io/stylix/)
- GUI theme: [Catppuccin-Mocha-Maroon](https://catppuccin.com/)
- shell theme: [base16-classic-dark](https://base16.netlify.app/previews/base16-classic-dark)
- icons: [Papirus-Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)
- fonts:
  - regular: [DejaVu Sans](https://dejavu-fonts.github.io/)
  - monospace [MartianMono](https://github.com/evilmartians/mono)
  - emoji: [Noto Color Emoji](https://github.com/googlefonts/noto-emoji)

## links

- [issues](https://codeberg.org/kiara/cfg/issues/)
