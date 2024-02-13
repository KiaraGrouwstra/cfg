{ lib, ... }:

{
  # prevents error: file 'home-manager/home-manager/build-news.nix' was not found in the Nix search path
  # https://github.com/nix-community/home-manager/issues/2033
  news = {
    display = "silent";
    json = lib.mkForce { };
    entries = lib.mkForce [ ];
  };
}
