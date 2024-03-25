# Rebuild the system
switch:
  sudo nixos-rebuild switch --fast --flake .#hammer

# Format code
fmt:
  nix fmt

# Run tests
test:
  nix flake check --show-trace --print-build-logs --verbose

# Update all inputs
up:
  nix flake update --refresh

# Update specific input
# Usage: just upp nixpkgs
upp input:
  nix flake lock --update-input {{input}}

# Open a Nix REPL
# Run manually to load flake: `:lf .`
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
