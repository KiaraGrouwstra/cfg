{userConfig, ...}: let
  path = "${userConfig.home}/.ollama";
in {
  services.ollama = {
    enable = true;
    listenAddress = "127.0.0.1:11434";
    # acceleration = "rocm";
    sandbox = false;
    home = path;
    models = "${path}/models";
    writablePaths = [
      path
    ];
  };
}
