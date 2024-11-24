{ config, pkgs, ... }:

{
  home.username = "posborne";
  home.homeDirectory = "/home/posborne";

  programs.git = {
    enable = true;
    userName = "Paul Osborne";
    userEmail = "osbpau@gmail.com";
  };

  home.packages = with pkgs; [
    neofetch
    ripgrep
  ];

  home.stateVersion = "24.11";
}
