{ lib, pkgs, config, ... }:
{
  imports = [
    ./emacs
    ./gnome.nix
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

      # basic software stuff
      just

      # version control
      gh
      git

      # system tools
      socat
      file
      lsof

      # network tools
      nmap
      iproute2

      # merge tooling
      meld

      # media/graphics
      mplayer
      imagemagick
      vlc
      gimp
      ffmpeg-full
      ffmpegthumbnailer

      # desktop tools
      pavucontrol
      networkmanagerapplet
      dconf

      # security/privacy
      gnupg

      # communications
      discord
      slack
      telegram-desktop
      thunderbird
      whatsapp-for-linux
      zoom-us

      # text editors (sans emacs)
      helix
      neovim

      # productivity
      libreoffice
      
      # additional cli tools
      xclip
      graphviz
      xdg-utils

      # terminal emulators
      terminator


      # browsers
      firefox
      chromium

      # fonts
      liberation_ttf
      ttf_bitstream_vera

      # other
      home-manager
    ];
  };
}
