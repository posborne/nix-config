{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.desktop;
in
{
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # media
      mplayer
      vlc
      gimp
      ffmpeg-full

      # communications
      discord
      slack
      telegram-desktop
      thunderbird
      whatsapp-for-linux
      zoom-us

      # productivity
      libreoffice

      # terminal emulators
      alacritty
      # ghostty (maybe when open)

      # browsers
      firefox
      chromium

      # fonts
      liberation_ttf
      ttf_bitstream_vera

      # utils
      xdg-utils
    ];

    fonts.fontconfig.enable = true;
  };
}
