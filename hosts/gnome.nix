{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  # basics to enable gnome
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # essential programs to install for a gnome environment
  programs = {
    firefox.enable = true;
  };
}
