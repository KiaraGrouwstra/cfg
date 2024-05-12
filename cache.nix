{lib, ...}: {
  nix.settings = lib.dryCache {
    "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o=" = ["https://cache.lix.systems"];
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" = ["https://nix-community.cachix.org" "https://cache.nixos.org/"];
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" = ["https://niri.cachix.org"];
    "bknix.cachix.org-1:+Lk3ufMR5Yn0vcd9Offl6xC+aYLNULY60TjQVTzbls4=" = ["https://bknix.cachix.org"];
    "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s=" = ["https://anyrun.cachix.org"];
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE=" = ["https://numtide.cachix.org"];
  };
}
