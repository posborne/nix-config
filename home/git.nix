{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{

  home.packages = with pkgs; [
    gh
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    # user.name/user.email
    userName = config.me.name;
    userEmail = config.me.email;

    # enable lfs
    lfs.enable = true;

    # commit signing (disable for nwo)
    # signing = {
    #   signByDefault = false;
    # };

    includes = [ ];

    # Delta syntax highligher and fancy pager
    # See https://github.com/dandavison/delta
    delta = {
      enable = true;
      options = {
        side-by-side = false;
        line-numbers = true;
        decorations = true;
        plus-style = "syntax #004000";
        plus-emph-style = "syntax #00A000";
      };
    };

    extraConfig = {
      color.ui = "auto";
      core = {
        autocrlf = "input";
        eol = "lf";
        editor = "emacs --tty";
        compression = -1;
      };
      init.defaultBranch = "main";
      feature.manyFiles = true;
      merge.defaultToUpstream = true;
      pull.ff = "only";
      rebase.autosquash = true;
    };

    # stoken from nastevens nix-config; generates a global gitignore
    # using gitignore fragments from https://github.com/github/gitignore
    ignores =
      let
        gitignore = path: name: builtins.readFile "${inputs.github-gitignore}/${path}/${name}.gitignore";
        gitignoreGlobal = gitignore "Global";
        generate = list: lib.splitString "\n" (builtins.concatStringsSep "\n" list);
      in
      generate [
        (gitignoreGlobal "Backup")
        (gitignoreGlobal "Linux")
        (gitignoreGlobal "macOS")
        (gitignoreGlobal "Emacs")
        (gitignoreGlobal "JetBrains")
        (gitignoreGlobal "Vim")
        (gitignoreGlobal "VisualStudioCode")
        (gitignoreGlobal "Windows")
        (''
          # local direnv cache
          .direnv
        '')
      ];
  };
}
