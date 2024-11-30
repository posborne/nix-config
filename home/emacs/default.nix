{ pkgs, lib, config, ... }:
{
  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
  };

  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom.d;
    experimentalFetchTree = true; # Disable if there are fetcher issues
    extraPackages = lib.optionals pkgs.stdenv.isLinux (epkgs: with epkgs; [
      vterm
      treesit-grammars.with-all-grammars
    ]);
  };

  home.shellAliases = {
    ec = "emacsclient";
    et = "emacsclient --tty";
  };

}
