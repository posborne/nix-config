{ lib, pkgs, config, ... }:
{
  imports = [
    ../common/features.nix
    ./development.nix
    ./desktop.nix
    ./emacs
    ./gaming.nix
    ./git.nix
    ./gnome.nix
    ./hyprland
    ./python.nix
    ./zsh.nix
  ];

  config = {
    home = {
      homeDirectory = lib.mkDefault "/home/${config.me.username}";
      username = "${config.me.username}";
      stateVersion = "24.11";
    };

    home.packages = with pkgs; [
      # basic cli stuff
      bat
      fd
      fzf
      htop
      jq
      killall
      pstree
      ripgrep
      tmux
      tree
      xsv

      # system tools
      socat
      file
      lsof

      # network tools
      iproute2

      # media/graphics
      imagemagick

      # desktop tools
      pavucontrol
      networkmanagerapplet
      dconf

      # security/privacy
      gnupg

      # text editors (sans emacs)
      helix
      neovim

      # additional cli tools
      xclip
      graphviz

      # other
      home-manager
    ];
  };
}
