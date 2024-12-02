{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.features.desktop.hyprland;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dunst
      eww
      rofi
      pamixer
      playerctl
      shotman
      waybar
      wl-clipboard
      xdg-desktop-portal-hyprland
    ];

    # gtk = {
    # ...
    # };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      # Could use `settings` instead https://nix-community.github.io/home-manager/options.xhtml#opt-wayland.windowManager.hyprland.settings
      extraConfig = builtins.readFile ./hyprland.conf;
    };

    services.hypridle = {
      enable = true;
      settings.listener = [
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };

    # services.hyprpaper = {
    # ...
    # };
  };
}
