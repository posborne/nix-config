{ lib, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = false;
      timeout = lib.mkDefault 15;
      grub = {
        enable = lib.mkDefault true;
        configurationLimit = 25;
        device = "/dev/vda";
        useOSProber = true;
      };
    };
  };
}
