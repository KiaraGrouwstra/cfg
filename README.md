# .nixconfig

This is my setup for [NixOS](https://nixos.org/).

## usage

follow instructions:
- [nixos](https://github.com/mcdonc/.nixconfig) (`chown` + git + `ln`)
- [home-manager](https://nix-community.github.io/home-manager/index.html#sec-install-standalone)

### link configs

```sh
# nixos, for $myhost
ln -s $PWD/hosts/$myhost/configuration.nix $PWD/configuration.nix
# home manager
mkdir -p ~/.config/nixpkgs/ && ln -s $PWD/home-manager/$USER/home.nix ~/.config/nixpkgs/home.nix
```

## references

- https://github.com/mcdonc/.nixconfig
- https://gitlab.com/KiaraGrouwstra/nix-config
- https://mynixos.com/
- https://mipmip.github.io/home-manager-option-search/

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
