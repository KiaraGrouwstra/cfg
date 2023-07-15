# .nixconfig

This is my setup for [NixOS](https://nixos.org/) using [Nix Flakes](https://nixos.wiki/wiki/Flakes).

## usage

follow instructions:
- [nixos](https://nixos.org/manual/nixos/stable): `nixos-rebuild --flake .#kiara-steen`
- [cache](https://app.cachix.org/cache/kiara#pull): install `cachix` then `cachix use kiara`
- [home-manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone): `home-manager --flake .#kiara@steen`
- updating: `nix flake update`

### [guix](https://github.com/NixOS/nixpkgs/pull/150130#issuecomment-993954344)

```sh
export PATH="/var/guix/profiles/per-user/root/current-guix/bin:$PATH"
```

## references

- https://github.com/JavaCafe01/nixos
- https://mynixos.com/
- https://mipmip.github.io/home-manager-option-search/
- https://nur.nix-community.org/

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
