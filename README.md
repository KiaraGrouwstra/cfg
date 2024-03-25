# .nixconfig

This is my setup for [NixOS](https://nixos.org/),
with secrets managed using [Sops](https://github.com/getsops/sops/).

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

## references

- [search.nixos.org](https://search.nixos.org)
- [search.nixos.org/options](https://search.nixos.org/options)
- [home-manager options](https://nix-community.github.io/home-manager/options.xhtml)
- [mynixos.com](https://mynixos.com/)
- [flakestry.dev](https://flakestry.dev/)
- [nur.nix-community.org](https://nur.nix-community.org/)
- [noogle.dev](https://noogle.dev/)

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
