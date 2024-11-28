{ lib, pkgs, config, ... }:
with lib;
let
  cfgDev = config.features.development;
  cfgPythonDev = config.features.development.python;
in
{
  config = mkIf (cfgDev.enable && cfgPythonDev.enable) {
    home.packages = with pkgs; [
      python3
      virtualenv
    ];
  };
}
