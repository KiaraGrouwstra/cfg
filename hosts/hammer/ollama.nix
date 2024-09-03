{
  services.ollama = {
    enable = false;
    listenAddress = "127.0.0.1:11434";
    # host = "127.0.0.1";
    # port = 11434;
    acceleration = "rocm";
  };
  # nginx by default runs with ProtectHome = true
  environment.persistence."/persist" = {
    directories = ["/var/lib/ollama"];
  };
}
