{ inputs, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../common/features.nix
    ./nix.nix
    ./systemd-initrd.nix
    ./user.nix
    ./gaming.nix
    ./grub.nix
    ./hyprland.nix
    ./gnome.nix
    ./ssh.nix
    ./1password.nix
    ./virt.nix
  ];

  fonts.packages = with pkgs; [
    # TODO: pair this down, playing with font prefernces a bit
    nerd-fonts.agave
    nerd-fonts.droid-sans-mono
    nerd-fonts.envy-code-r
    nerd-fonts.fira-code
    nerd-fonts.inconsolata
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    nerd-fonts.sauce-code-pro
    nerd-fonts.ubuntu-mono

    dejavu_fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    vistafonts
  ];

  programs.zsh.enable = true;
  # programs.home-manager.enable = true;
}
