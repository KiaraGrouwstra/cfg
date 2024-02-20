{...}:
{
  services.guix = {enable = true;};
  systemd.services.guix-daemon.serviceConfig.Nice = 19;
}
