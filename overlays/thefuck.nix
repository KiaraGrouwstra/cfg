{pkgs, ...}:
# allow suggesting `nix-shell` when programs turn out not installed:
# https://github.com/nvbn/thefuck/pull/1393
pkgs.thefuck.overridePythonAttrs (old: {
  src = pkgs.fetchFromGitHub {
    owner = "KiaraGrouwstra";
    repo = "thefuck";
    rev = "16d838bf6f63117b161a2f1e6572e06108b007eb";
    hash = "sha256-goo8sbMlJK9/6gfVn4A3LGNdTJf1W4n52+1qZMLpXos=";
  };
  doCheck = false;
})
