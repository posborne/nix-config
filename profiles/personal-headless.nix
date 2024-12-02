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
    desktop.enable = false;

    # And some basic development stuff
    development = {
      enable = mkDefault true;
      # kernelDev = true;
      python = mkDefault true;
    };
  };

}
