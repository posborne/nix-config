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
  nixGL = lib.optionalAttrs pkgs.stdenv.isLinux {
    packages = inputs.nixgl.packages;
    defaultWrapper = "mesa";
    installScripts = [ "mesa" ];
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
    package = config.lib.nixGL.wrap pkgs.wezterm;
  };
}
