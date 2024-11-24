{
  description = "posborne's nix config";

  inputs = {
    # principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; # set inputs as submodule special args
      modules = [
        ./configuration.nix
      ];
    };

    homeConfigurations = {
      posborne = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
