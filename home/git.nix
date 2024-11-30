{
  pkgs,
  lib,
  config,
  ...
}: {

  home.packages = with pkgs; [
    gh
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = config.me.name;
    userEmail = config.me.email;
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
    };
  };
}
