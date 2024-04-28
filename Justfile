# default action: list actions
default:
  @just --list

# Rebuild the system
switch:
  sudo NIXOS_LABEL="$(head -n 1 .git/COMMIT_EDITMSG | sed 's/ /_/g' | sed 's/[^a-zA-Z0-9:_\.-]//g')" nixos-rebuild switch --fast --impure --flake .#default --show-trace

# Build a new configuration
boot:
  sudo NIXOS_LABEL="$(head -n 1 .git/COMMIT_EDITMSG | sed 's/ /_/g' | sed 's/[^a-zA-Z0-9:_\.-]//g')" nixos-rebuild boot --fast --impure --flake .#default --show-trace

# Rebuild the home config
home:
  home-manager switch --flake .#default switch --show-trace

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
  nix flake lock --update-input {{input}}

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
  sops -e secrets.yml > secrets.enc.yml

# Decode secrets
decode:
  sops -d secrets.enc.yml > secrets.yml

# Check when inputs were last updated
age:
  age.sh

