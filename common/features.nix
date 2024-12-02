{ config, lib, ... }:
with lib;
{
  options.me = mkOption {
    type = types.submodule {
      options = {
        name = mkOption {
          type = types.str;
        };
        email = mkOption {
          type = types.str;
        };
        username = mkOption {
          type = types.str;
        };
        sshPublicKeys = mkOption {
          type = types.listOf types.str;
        };
      };
    };
  };

  options.features.virt-host = {
    enable = mkEnableOption "Virtualization Host";
    enableDocker = mkEnableOption "Enable docker";
  };

  options.features.gaming = {
    enable = mkEnableOption "Enable Gaming";
  };

  options.features.desktop = {
    enable = mkEnableOption "Enable Desktop Apps";
    gnome.enable = mkEnableOption "Enable Gnome Desktop";
    hyprland.enable = mkEnableOption "Enable Hyprland Desktop";
  };

  options.features.development = {
    enable = mkEnableOption "Enable development tools";
    python.enable = mkEnableOption "Python Development";
  };

}
