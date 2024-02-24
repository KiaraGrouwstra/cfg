{pkgs, ...}:
# allow suggesting `nix-shell` when programs turn out not installed:
# https://github.com/nvbn/thefuck/pull/1393
pkgs.thefuck.overridePythonAttrs (old: {
  src = pkgs.fetchFromGitHub {
    owner = "KiaraGrouwstra";
    repo = "thefuck";
    rev = "50ee10ba1d7485b9dd9184e9acc82fc418018da1";
    hash = "sha256-IAQGvIDBdU7xeTpJ/QKiCABxHA7MCwzRQng17slx9ug=";
  };
  doCheck = false;
})
