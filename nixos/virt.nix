{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfgVirtHost = config.features.virt-host;
  cfgDesktop = config.features.desktop;
in
{
  config = mkMerge [
    # if virt enabled, always enable libvirt
    (mkIf (cfgVirtHost.enable) {
      virtualisation.libvirtd.enable = true;
      users.users.${config.me.username}.extraGroups = [ "libvirtd" ];
    })

    # enabel docker if the feature is enabled
    (mkIf (cfgVirtHost.enable && cfgVirtHost.enableDocker) {
      environment.systemPackages = with pkgs; [
        docker
        docker-compose
      ];
      virtualisation.docker = {
        enable = true;

        # avoid ip address range conflicts sometimes seen with the
        # default 172.17.0.0/16
        daemon.settings = {
          default-address-pools = [
            {
              base = "10.0.64.0/18";
              size = "24";
            }
          ];
        };
      };
    })

    # enable virt-manager gui for desktop
    (mkIf (cfgVirtHost.enable && cfgDesktop.enable) {
      programs.virt-manager.enable = true;
    })
  ];
}
