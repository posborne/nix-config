{ lib, config, ... }:
let
  cfg = config.features.gaming;
in
{

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };

}
