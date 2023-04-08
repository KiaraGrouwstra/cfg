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
- https://search.nixos.org/packages
- https://search.nixos.org/options
- https://mipmip.github.io/home-manager-option-search/
- https://mynixos.com/
