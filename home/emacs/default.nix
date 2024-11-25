{ pkgs, lib, config, ... }:
{
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.emacs = {
    enable = true;
  };
}
