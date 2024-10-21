{
  config,
  userConfig,
  ...
}: {
  systemd.user.services.local-ai = let
    inherit (config.commands) local-ai;
    port = "8080";
  in {
    Unit = {
      Description = "local-ai";
    };
    Install = {
      WantedBy = ["multi-user.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${local-ai} --address :${port} --models-path /persist${userConfig.home}/.config/piper/voices/";
    };
  };
}
