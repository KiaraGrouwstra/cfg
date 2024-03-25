# .nixconfig

This is my setup for [NixOS](https://nixos.org/).

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
just -l
```

or if `just` isn't available yet:

```sh
nix run nixpkgs#just -- -l
```

## used software

| Component     | Software     |
|---------------|--------------|
| Compositor    | [Niri](https://github.com/YaLTeR/niri/) |
| Bar           | [Waybar](https://github.com/Alexays/Waybar/) |
| Notifications | [Swaynotificationcenter](https://github.com/ErikReider/SwayNotificationCenter/) |
| Menu          | [Anyrun](https://github.com/Kirottu/anyrun) |
| Web browser   | [Firefox](https://hg.mozilla.org/mozilla-central/) |
| File browser  | [Yazi](https://yazi-rs.github.io/) |
| Terminal      | [Wezterm](https://github.com/wez/wezterm) |
| Text editor   | [VSCodium](https://github.com/vscodium/vscodium) |
| Shell         | [Zsh](https://zsh.org/) |

## features

- secrets: [sops](https://github.com/getsops/sops/)
- formatter: [treefmt](https://github.com/numtide/treefmt)
- commands: [just](https://github.com/casey/just)
- CI: [garnix](https://garnix.io/)
- legacy nix commands using locked nixpkgs

## references

- [search.nixos.org](https://search.nixos.org)
- [search.nixos.org/options](https://search.nixos.org/options)
- [home-manager options](https://nix-community.github.io/home-manager/options.xhtml)
- [mynixos.com](https://mynixos.com/)
- [flakestry.dev](https://flakestry.dev/)
- [nur.nix-community.org](https://nur.nix-community.org/)
- [noogle.dev](https://noogle.dev/)
