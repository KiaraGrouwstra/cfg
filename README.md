# .nixconfig

This is my setup for [NixOS](https://nixos.org/) using [Nix Flakes](https://nixos.wiki/wiki/Flakes),
and with secrets managed using [Sops](https://github.com/getsops/sops/).

## usage

follow instructions:
- [download](https://nixos.org/download) / [install](https://nixos.org/manual/nixos/stable/#sec-installation) / boot [nixos](https://nixos.org/)
- take access to nixos directory: `sudo chown -R $USER /etc/nixos/`
- add [`age`](https://github.com/FiloSottile/age) keys file `keys.txt` in this directory to decode the secrets
- copy the contents of this repo to `/etc/nixos/`
- place the original `configuration.nix` and `hardware-configuration.nix` into one of the hardware profiles in `hosts/`
- in the `configuration.nix` [enable flakes](https://nixos.wiki/wiki/Flakes#NixOS)
- in `flake.nix` add device profiles for the system and user
- [nixos](https://nixos.org/manual/nixos/stable): `sudo nixos-rebuild switch --flake .#$USER-hammer --show-trace`
- [cache](https://app.cachix.org/cache/kiara#pull): install `cachix` then `cachix use kiara`
- [home-manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone): `home-manager --flake .#$USER@hammer switch -b backup --show-trace`
- updating:
  - `sudo nix-channel --update`
  - `nix flake update`
- shell: `nix-shell --command zsh -p lolcat`

### secrets

- encoding: `sops -e secrets.yml > secrets.enc.yml`
- decoding: `sops -d secrets.enc.yml > secrets.yml`

### [guix](https://github.com/NixOS/nixpkgs/pull/150130#issuecomment-993954344)

```sh
export PATH="/var/guix/profiles/per-user/root/current-guix/bin:$PATH"
```

## references

- https://github.com/javacafe01/dotfiles
- https://mynixos.com/
- https://mipmip.github.io/home-manager-option-search/
- https://nur.nix-community.org/
- https://packages.guix.gnu.org/
- https://flathub.org/

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

### home manager

```sh
# list generations
home-manager generations
# switch to a configuration manually
/nix/store/<revision>/activate
# switch to a configuration given a number
export n=1
$(echo `home-manager generations | grep "id ${n} " | grep --extended-regexp --only-matching '/nix/store/.*'`/activate)
```
