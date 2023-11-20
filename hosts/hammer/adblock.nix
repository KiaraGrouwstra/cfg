{ pkgs, inputs, ... }:
# config, lib,
# with lib;
{
  config =
    let
      adlist = inputs.adblock-unbound.packages.${pkgs.system};
    in
    {
      services.unbound = {
        enable = true;
        settings = {
          server = {
            include = [
              "\"${adlist.unbound-adblockStevenBlack}\""
            ];
            interface = [ "127.0.0.1" ];
            access-control = [ "127.0.0.0/8 allow" ];
          };
          forward-zone = [
            {
              name = ".";
              forward-addr = [
                "1.1.1.1@853#cloudflare-dns.com"
                "1.0.0.1@853#cloudflare-dns.com"
              ];
              forward-tls-upstream = "yes";
            }
          ];
        };
      };
    };
}
