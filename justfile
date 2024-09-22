# default action: list actions
default:
  @just --list

# Rebuild the system
switch:
  sudo NIXOS_LABEL="$(label)" nixos-rebuild switch --fast --impure --flake .#default --show-trace

# Build a new configuration
boot:
  sudo NIXOS_LABEL="$(label)" nixos-rebuild boot --fast --impure --flake .#default --show-trace

# Dry-build a new configuration
dry:
  sudo nixos-rebuild dry-activate --fast --flake .#default --show-trace

# Rebuild the home config
home:
  home-manager switch -b backup --flake .#default switch --show-trace

# Format code
fmt:
  nix fmt

# Run tests
test:
  nix flake check --show-trace --print-build-logs --verbose

# Update all inputs
up:
  nix flake update --refresh --commit-lock-file

# Update specific input. Usage: just upp nixpkgs
upp input:
  nix flake update {{input}}

# Show what has yet to be persisted in a folder. Usage: just ephemeral $HOME | $PAGER
ephemeral dir="$HOME":
  list-ephemeral {{dir}}

# Open a Nix REPL - run manually to load flake: `:lf .`
repl:
  nix repl

# Remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

# Garbage collect all unused nix store entries
gc:
  sudo nix store gc --debug
  nix-collect-garbage --delete-old
  sudo nix-collect-garbage --delete-old

# Encode secrets
encode:
  sops -e secrets.yaml > secrets.enc.yaml

# Decode secrets
decode:
  sops -d secrets.enc.yaml > secrets.yaml

# Check when inputs were last updated
age:
  check-age

# Patch persisted wine/steam desktop entries to run xwayland
patch-desktop-xwayland:
  patch-desktop-xwayland
