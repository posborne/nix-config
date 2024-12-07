{
  pkgs,
  lib,
  config,
  ...
}:
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
    extraPackages = if pkgs.stdenv.isLinux then (
      epkgs: with epkgs; [
        vterm
        treesit-grammars.with-all-grammars
        all-the-icons
      ]
    ) else epkgs: [];
  };

  # note: if you try to have both the tty and gui clients
  # going, you're going to have a bad time.
  home.shellAliases = {
    ec = "emacsclient -a '' -n -c";
    et = "emacsclient -a '' --tty";
  };

}
