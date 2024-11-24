{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
  ];

  home = {
    username = lib.mkDefault "posborne";
  };

  home.stateVersion = "24.11";
}