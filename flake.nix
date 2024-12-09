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
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      linuxSystems = [ "x86_64-linux" ];
      darwinSystems = [ "aarch64-darwin" ];
      forEachSystem = f: lib.genAttrs (systems) (system: f pkgsFor.${system});
      allSystems = linuxSystems ++ darwinSystems;
      pkgsFor = lib.genAttrs (allSystems) (
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

      darwinConfigurations = {
        pomac = nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          system = "aarch64-darwin";
          modules = [
            ./profiles/personal-mac.nix
            ./darwin
          ];
        };
      };

      homeConfigurations = {
        "posborne@wsl" = lib.homeManagerConfiguration {
	  modules = [
	    inputs.nix-doom-emacs-unstraightened.hmModule
	    ./profiles/personal-wsl.nix
	    ./home
	  ];
	  pkgs = pkgsFor.x86_64-linux;
	  extraSpecialArgs = {
	    inherit inputs outputs;
	  };
	};

        "posborne@pobox-m3" = lib.homeManagerConfiguration {
          modules = [
            inputs.nix-doom-emacs-unstraightened.hmModule
            ./profiles/personal-mac.nix
            ./home
            inputs.mac-app-util.homeManagerModules.default
          ];
          pkgs = pkgsFor.aarch64-darwin;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

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
