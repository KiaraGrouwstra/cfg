{
  pkgs,
  lib,
  ...
}:
pkgs.weechat.override {
  configure = _: {
    scripts = lib.attrValues {
      inherit
        (pkgs.weechatScripts)
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
        ;
    };
  };
}
