{ pkgs }:
with pkgs;
[
  # TODO: duplication, just experimenting...

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
  nixfmt-rfc-style
]
