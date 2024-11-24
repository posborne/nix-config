{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: {

  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
    ./systemd-initrd.nix
    ./gnome.nix
  ];

  programs.zsh.enable = true;

}