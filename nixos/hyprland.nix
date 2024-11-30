{ config, lib, pkgs, ... }:
with lib;
let
  desktopCfg = config.features.desktop;
  hyprlandCfg = config.features.desktop.hyprland;
in {
  config = mkIf (desktopCfg.enable && hyprlandCfg.enable) {
    programs.hyprland.enable = true;
  };
}
