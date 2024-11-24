{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {

  users.users.posborne = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "dialout"
    ] ++ ifTheyExist [
      "network"
      "networkmanager"
      "wireshark"
      "git"
      "libvirtd"
      "docker"
      "kvm"
      "adbgroup"
    ];

    # openssh.authorizedKeys.keys = [(builtins.readFile ../ssh.pub)];
    # hashedPasswordFile = config.sops.secrets.posborne-password.path;
    packages = [
      pkgs.home-manager
    ];
  };

  # TODO: should use ${config.network.hostName}?
  home-manager.users.posborne = import ../home-manager/posborne.nix;
}