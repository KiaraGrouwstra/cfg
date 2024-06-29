{
  services.ollama = {
    enable = true;
    host = "127.0.0.1";
    port = 11434;
    acceleration = "rocm";
    sandbox = false;
  };
  # nginx by default runs with ProtectHome = true
  environment.persistence."/persist" = {
    directories = ["/var/lib/ollama"];
  };
}
