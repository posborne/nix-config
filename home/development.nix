{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.development;
in
{
  # Should more involved development items be included; we'll always included
  # some basic editor stuff but this would encompass vscode, etc.
  config = mkMerge [
    # dev enabled
    (mkIf (cfg.enable) {
      home.packages = with pkgs; [
        # enable more fine-grained nix envs for dev projects
        direnv
        devenv

        # other basic development software
        just
        nmap
      ];
    })

    # dev and desktop enabled
    (mkIf (cfg.enable && config.features.desktop.enable) {
      home.packages = with pkgs; [
        meld
      ];

      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
      };

    })
  ];

}
