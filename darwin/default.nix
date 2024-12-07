{ inputs, config, pkgs, lib, ... }:
{
  imports = [
    ../common/features.nix
  ];

  # environment options?
  nix = {
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = [ "nix-command" "flakes" ];
    };
  };

  # homebrew.enable?
  homebrew = {
    enable = true;
    brews = [
      "imagemagick"  # example - brew install imagemagick
      "htop"
    ];
    casks = [
      "google-chrome"
      # ...
    ];
  };

  # enable home-manager and include our packages (shared)
  inputs.home-manager.darwinModules.home-manager = {
    useGlobalPkgs = true;
    enable = true;
    users.${config.me.username} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        # file = lib.mkMerge [
        #   sharedFiles
        #   additionalFiles
        #   { "emacs-launcher.command".source = myEmacsLauncher; }
        # ];

        stateVersion = "24.11";
      };
    };
  };

  # launchd?

  # networking.dns (nameservers)
  # networking.hostName (hostname)
  # networking.localHostName (hostname)
  # networking.search (search-path)

  # programs... (not sure on these vs. home-manager? vs. homebrew?)
  # services... (ditto)
  # system...
  # users...

  system.stateVersion = 5;
}
