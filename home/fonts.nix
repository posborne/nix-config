{
  config,
  lib,
  pkgs,
  ...
}:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.agave
    nerd-fonts.caskaydia-cove
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.inconsolata
    nerd-fonts.sauce-code-pro
    vistafonts
  ];
}
