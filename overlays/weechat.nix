{pkgs, ...}:
pkgs.weechat.override {
  configure = _: {
    scripts = with pkgs.weechatScripts; [
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
}
