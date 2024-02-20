# .nixconfig

This is my setup for [NixOS](https://nixos.org/) using [Nix Flakes](https://nixos.wiki/wiki/Flakes),
and with secrets managed using [Sops](https://github.com/getsops/sops/).

## usage

follow instructions:

- [download](https://nixos.org/download) / [install](https://nixos.org/manual/nixos/stable/#sec-installation) / boot [nixos](https://nixos.org/)
- take access to nixos directory: `sudo chown -R $USER /etc/nixos/`
- add [`age`](https://github.com/FiloSottile/age) keys file to `/etc/nixos/keys.txt` to decode the secrets
- ensure `/etc/nixos/hardware-configuration.nix` is reflected in `./hosts/$(hostname)/hardware-configuration.nix`
- in the `configuration.nix` [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
- in `flake.nix` add device profiles for the system and user
- [nixos](https://nixos.org/manual/nixos/stable): `nix fmt && sudo nixos-rebuild --impure switch --fast --flake .#hammer 2>&1 | tee build.log`
- [cache](https://app.cachix.org/cache/kiara#pull): install `cachix` then `cachix use kiara`
- updating:
  - `sudo nix-channel --update`
  - `nix flake update`
- shell: `nix-shell --command zsh -p lolcat`

### secrets

- encoding: `sops -e secrets.yml > secrets.enc.yml`
- decoding: `sops -d secrets.enc.yml > secrets.yml`

### updating

```sh
nix flake update --override-input nixpkgs github:NixOS/nixpkgs/<rev>
```

## references

- inspiration on repo setup:
  - [javacafe01](https://github.com/javacafe01/dotfiles)
  - [Misterio77](https://github.com/Misterio77/nix-config)
- search for options and packages:
  - [mynixos.com](https://mynixos.com/)
  - [mipmip.github.io/home-manager-option-search](https://mipmip.github.io/home-manager-option-search/)
  - [flakestry.dev](https://flakestry.dev/)
  - [nur.nix-community.org](https://nur.nix-community.org/)
- nix functions:
  - [mipmip.github.io/nix-builtins-search](https://mipmip.github.io/nix-builtins-search/)
  - [noogle.dev](https://noogle.dev/)
- packages: non-nix
  - [packages.guix.gnu.org](https://packages.guix.gnu.org/)
  - [flathub.org](https://flathub.org/)

## rollbacks

### nixos

```sh
# list configurations
ls -lt /nix/var/nix/profiles/system-*-link
# switch to a configuration manually
/nix/var/nix/profiles/system-<CONFIGURATION>-link/bin/switch-to-configuration switch
# switch to a configuration given a number
export n=1
$(echo sudo `ls -lt /nix/var/nix/profiles/system-${n}-link | grep --extended-regexp --only-matching '/nix/store/.*'`/bin/switch-to-configuration switch)
```

## Used software

| Component     | Software     |
|---------------|--------------|
| Compositor    | [Niri](https://github.com/YaLTeR/niri/) |
| Bar           | [Waybar](https://github.com/Alexays/Waybar/) |
| Notifications | [swaynotificationcenter](https://github.com/ErikReider/SwayNotificationCenter/) |
| Menu          | [Anyrun](https://github.com/Kirottu/anyrun) |
| Web browser   | [Firefox](https://hg.mozilla.org/mozilla-central/) |
| File browser  | [Nautilus](https://gitlab.gnome.org/GNOME/nautilus/) |
| Terminal      | [Wezterm](https://github.com/wez/wezterm) |
| Text editor   | [VSCodium](https://github.com/vscodium/vscodium) |
| Shell         | [Zsh](https://zsh.org/) |

## Debugging builds

### System flake

```sh
git bisect start $BAD $GOOD && git bisect run $CMD
```

### `nixpkgs` package

[run in `nixpkgs` repo](https://stackoverflow.com/questions/4713088/how-do-i-use-git-bisect/22592593#22592593), e.g. for `signal-desktop`:

```sh
cat >> .test<< EOF
#! /usr/bin/env bash
$(nix-build -A signal-desktop)/bin/signal-desktop --use-tray-icon --no-sandbox
EOF
chmod +x ./test
git bisect start -- pkgs/applications/networking/instant-messengers/signal-desktop/
git bisect bad
git bisect run sh -c './test; [ $? -eq 0 ]'
```

### Flake input

From the dependency's repo, run:

```sh
export DEPENDENCY_INPUT=nixpkgs
export DEPENDENCY_URL=https://github.com/NixOS/nixpkgs
export SYSTEM_REPO=<MY_SYSTEM_FLAKE_REPO_PATH>

# if judgement needs manual intervention:
$SYSTEM_REPO/bisect.sh $DEPENDENCY_PATH $DEPENDENCY_URL $SYSTEM_REPO
# <COMMAND>
# git bisect good
# git bisect bad

# if judgement can be automated:
git bisect run "$SYSTEM_REPO/bisect.sh $DEPENDENCY_PATH $DEPENDENCY_URL $SYSTEM_REPO && <COMMAND>"
```
