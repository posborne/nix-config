{
  pkgs,
  lib,
  config,
  ...
}: {

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = config.me.name;
    userEmail = config.me.email;
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
  };
}
