{
  pkgs,
  lib,
  config,
  ...
}: {

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "Paul Osborne";
    userEmail = "osbpau@gmail.com";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
  };
}