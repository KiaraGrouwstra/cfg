# This file defines overlays
{ inputs }:
let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; inherit inputs; };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {

    weechat = prev.weechat.override {
      configure = { availablePlugins, ... }: {
        scripts = with prev.weechatScripts; [
          weechat-otr
          wee-slack
          edit
          highmon
          url_hint
          multiline
          weechat-go
          zncplayback
          weechat-grep
          colorize_nicks
          buffer_autoset
          weechat-matrix
          weechat-autosort
          weechat-notify-send
        ];
      };
    };

  };

in
{
  inherit additions modifications;
}
