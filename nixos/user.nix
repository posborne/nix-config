{
  pkgs,
  config,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{

  users.users."${config.me.username}" = {
    description = config.me.name;
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
        "dialout"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "wireshark"
        "git"
        "libvirtd"
        "docker"
        "kvm"
        "adbgroup"
      ];
    openssh.authorizedKeys.keys = config.me.sshPublicKeys;

    packages = [
      pkgs.home-manager
    ];
  };
}
