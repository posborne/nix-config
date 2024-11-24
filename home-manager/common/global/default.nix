{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {

  imports = [
    ../features/cli
  ];
  #  ++ (builtins.attrValues outputs.homeManagerModules);
  
  nixpkgs = {
    # overlays = builtins.attrValues outputs.overlay;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = true;
    };
  };

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

}
      