{
  services.ollama = {
    enable = true;
    listenAddress = "127.0.0.1:11434";
    # acceleration = "rocm";
    sandbox = false;
  };
  # nginx by default runs with ProtectHome = true
  environment.persistence."/persist" = {
    directories = ["/var/lib/ollama"];
  };
}
