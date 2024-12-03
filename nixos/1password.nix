{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  config = lib.mkMerge [
    # 1password cli (enable regardless)
    ({ programs._1password.enable = true; })

    # enable gui if we're doing desktop
    (mkIf (config.features.desktop.enable) {
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [
          config.me.username
        ];
      };
    })
  ];
}
