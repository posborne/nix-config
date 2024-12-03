{
  # config is based around sjcobb2022/nixos-config as a reference
  description = "posborne's nix config";

  inputs = {
    # principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    github-gitignore = {
      url = "github:github/gitignore";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs (systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (systems) (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            # inputs.emacs-overlay.overlays.emacs
          ];
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;
      nixosConfigurations = {
        qemu-vm = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./profiles/personal-desktop.nix
            ./nixos/hosts/qemu-vm
            ./nixos
          ];
          pkgs = pkgsFor.x86_64-linux;
        };
      };

      homeConfigurations = {
        "posborne@qemu-vm" = lib.homeManagerConfiguration {
          modules = [
            inputs.nix-doom-emacs-unstraightened.hmModule
            ./profiles/personal-desktop.nix
            ./home
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

        "posborne@fedora" = lib.homeManagerConfiguration {
          modules = [
            inputs.nix-doom-emacs-unstraightened.hmModule
            ./profiles/personal-existing-linux.nix
            ./home
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
