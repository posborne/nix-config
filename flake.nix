{
  description = "posborne's nix config";

  inputs = {
    # principle inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # nixos-unified.url = "github:srid/nixos-unified";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # set inputs as submodule special args
      modules = [
        ./configuration.nix
	
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.posborne = import ./home.nix;
        }
      ];
    };
  };
}
