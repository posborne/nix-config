{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  desktopCfg = config.features.desktop;
  gnomeCfg = config.features.desktop.gnome;
in
{
  config = mkIf (desktopCfg.enable && gnomeCfg.enable) {
    services.xserver = {
      enable = true;
      displayManager = {
        defaultSession = "gnome";
        gdm = {
          enable = true;
          wayland = true;
        };
      };
      desktopManager.gnome.enable = true;
    };
  };
  # extensions and such are configured as part of home-manager
}
