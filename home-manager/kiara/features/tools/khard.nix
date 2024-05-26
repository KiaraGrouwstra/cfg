{pkgs, ...}: {
  home.packages = [pkgs.khard];
  xdg.configFile."khard/khard.conf".text =
    /*
    toml
    */
    ''
      [addressbooks]
      [[contacts]]
      path = ~/Contacts/contacts

      [general]
      default_action = list
    '';
}
