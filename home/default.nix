{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../common/features.nix
    ./development.nix
    ./emacs
    ./fonts.nix
    ./gaming.nix
    ./git.nix
    ./python.nix
    ./tmux.nix
    ./zsh.nix
    ./wezterm
    ./desktop.nix
    ./hyprland
    ./gnome.nix
  ];

  config = lib.mkMerge [
    ({
      home = {
        username = "${config.me.username}";
        stateVersion = "24.11";
      };
      home.packages = with pkgs; [
        # == common ==
        # basic cli stuff
        bat
        fd
        fzf
        htop
        jq
        killall
        pstree
        ripgrep
        tree
        xsv

        # system tools
        socat
        file
        lsof

        # media/graphics
        imagemagick

        # security/privacy
        gnupg

        # text editors (sans emacs)
        helix
        neovim

        # additional cli tools
        xclip
        graphviz

        # other
        nixfmt-rfc-style
        home-manager
      ];
    })

    (lib.mkIf pkgs.stdenv.isDarwin {
      home = {
        homeDirectory = "/Users/${config.me.username}";
      };
      home.packages = with pkgs; [ ];
    })

    (lib.mkIf pkgs.stdenv.isLinux {
      home = {
        homeDirectory = "/home/${config.me.username}";
      };

      home.packages = with pkgs; [
        # network tools
        iproute2
        # desktop tools
        pavucontrol
        networkmanagerapplet
        dconf
      ];
    })
  ];
}
