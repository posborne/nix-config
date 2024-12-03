{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  # wezterm uses the gpu, hack to make work on non-nixos systems
  # TODO: probably needs conditional inclusion
  nixGL.packages = inputs.nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  nixGL.installScripts = [ "mesa" ];

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
    package = config.lib.nixGL.wrap pkgs.wezterm;
  };
}
