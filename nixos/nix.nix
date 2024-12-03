{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}:
{
  nix = {
    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = true;
    };

    # optimise storage nightly
    optimise = {
      automatic = true;
      dates = [ "3:45" ];
    };

    # auto gc stuff older than 60d
    gc = {
      automatic = true;
      options = "--delete-older-than 60d";
    };

    # Add each flake input as a registry
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
}
