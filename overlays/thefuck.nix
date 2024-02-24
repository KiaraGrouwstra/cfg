{pkgs, ...}:
# allow suggesting `nix-shell` when programs turn out not installed:
# https://github.com/nvbn/thefuck/pull/1393
pkgs.thefuck.overridePythonAttrs (old: {
  src = pkgs.fetchFromGitHub {
    owner = "KiaraGrouwstra";
    repo = "thefuck";
    rev = "74f3244543a4619c09b40f6680245834c0204dd0";
    hash = "sha256-jxfJhP4HhHVBBA725clSS79nrHf7s2Aq5nnKltR8OX8=";
  };
  doCheck = false;
})
