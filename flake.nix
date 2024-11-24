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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @inputs: let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPkgs.${sys});
    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
	specialArgs = {inherit inputs outputs;};
      };
    mkHome = modules: pkgs:
      home-manager.lib.homemanagerConfiguration {
        inherit modules pkgs;
	extraSpecialArgs = {inherit inputs outputs;};
      };
  in {
    nixosModules = ./modules/nixos;
    homeManagerModules = ./modules/home-manager;
    nixosConfigurations = {
      qemuVM = mkNixos [./hosts/qemuVM];
    };
    homeConfigurations = {
      "posborne@qemuVM" = mkHome [./home-manager/posborne/qemuVM.nix] nixpkgs.legacyPackages."x86-64-linux";
    };
  };
}
