{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}: {

  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  networking = {
    networkmanager = {
      enable = true;
    };
    hostName = "qemuVM";
  };
  nix.gc.dates = "daily";
  time.timeZone = "America/Chicago";
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  boot = {
    plymouth.enable = false;
  };

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  system.stateVersion = "24.11";
}
