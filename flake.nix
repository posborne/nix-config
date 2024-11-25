{
  # config is based around sjcobb2022/nixos-config as a reference
  description = "posborne's nix config";

  inputs = {
    # principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux"];
    forEachSystem = f: lib.genAttrs (systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in
  {
    inherit lib;
    nixosConfigurations = {
      qemuVM = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs outputs;
	};
        modules = [
          ./hosts/qemuVM
          ./users/posborne.nix
        ];
      };
    };

    homeConfigurations = {
      "posborne@qemuVM" = lib.homeManagerConfiguration {
        modules = [ ./users/posborne.nix ./home ];
	pkgs = pkgsFor.x86_64-linux;
	extraSpecialArgs = {
	  inherit inputs outputs;
	};
      };
    };
  };
}
