{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  config.me = {
    name = "Paul Osborne";
    username = "posborne";
    email = "osbpau@gmail.com";
    sshPublicKeys = [ ]; # TODO
  };

  config.features = {
    # for personal rigs, we'll want a DE with gaming support
    desktop = {
      enable = false;
      gnome.enable = false;
      hyprland.enable = false;
    };
    gaming.enable = mkDefault true;

    # TODO: may not make much sense to enable in nested qemu
    virt-host = {
      enable = false;
      enableDocker = false;
    };

    # And some basic development stuff
    development.enable = mkDefault true;
    development.python.enable = mkDefault true;
  };

}
