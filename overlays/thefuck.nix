{ pkgs, ... }:

# allow suggesting `nix-shell` when programs turn out not installed:
# https://github.com/nvbn/thefuck/pull/1393
pkgs.thefuck.overridePythonAttrs (old: {
  src = pkgs.fetchFromGitHub {
    owner = "thenbe";
    repo = "thefuck";
    rev = "6202d325100c51076692d998e36a293955101365";
    hash = "sha256-ZTBOK6sVHQYPmvTSLQcdnyyL+89cFGjVm8czzBC2Ecg=";
  };
  doCheck = false;
})
