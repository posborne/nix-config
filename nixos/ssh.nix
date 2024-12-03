{ lib, config, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "${config.me.username}" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = true; # TODO: changeme
      PermitRootLogin = "no";
    };
  };
}
