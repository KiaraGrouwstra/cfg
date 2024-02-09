{ inputs, ... }:

{
  imports = [
    inputs.unbound-blocklist.nixosModules.default
    {
      services.unbound = {
        enable = true;
        blocklist.enable = true;
      };
    }
  ];
}
