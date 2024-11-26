{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./nix.nix
    ./systemd-initrd.nix
    ./user.nix
    ./gaming.nix
    ./grub.nix
    ./gnome.nix
    ./ssh.nix
  ];

  programs.zsh.enable = true;
  # programs.home-manager.enable = true;
}
