# nix-shell -p nur.repos.mic92.hello-nur --run "hello"
{
  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball {
      # Get the revision by choosing a version from https://github.com/nix-community/NUR/commits/master
      url = "https://github.com/nix-community/NUR/archive/0293fc1d7aefc2204a922ad41bb5141f085a13ec.tar.gz";
      # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
      sha256 = "0ck9xqr3vpymcv2qr7pch57iyzvabcqbmkd69cmjxs2dfrm5mszq";
    }) {
      inherit pkgs;
    };
  };
}
