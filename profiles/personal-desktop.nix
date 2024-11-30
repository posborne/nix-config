{ config, lib, pkgs, ... }:
{
  config.me = {
    name = "Paul Osborne";
    username = "posborne";
    email = "osbpau@gmail.com";
    sshPublicKeys = []; # TODO
  };

  config.features = {
    # for personal rigs, we'll want a DE with gaming support
    desktop = {
      enable = true;
      gnome.enable = true;
      hyprland.enable = true;
    };
    gaming.enable = true;

    # And some basic development stuff
    development.enable = true;
    development.python.enable = true;
  };

}
