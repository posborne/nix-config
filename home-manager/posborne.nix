{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
  ];

  home = {
    username = lib.mkDefault "posborne";
  };

  home.stateVersion = "24.11";
}