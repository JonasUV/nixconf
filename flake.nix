{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
   let
    system = "x86_64-linux";
    hostname = "nixos-vm";
    username = "jonas";
	  pkgs = nixpkgs.legacyPackages.${system};
   in
   {
    imports = [
        modules/nixos/general.nix
    ];
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        hosts/${hostname}/configuration.nix

        home-manager.nixosModules.home-manager 
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import hosts/${hostname}/home.nix;
        }
      ];
    };
  };
}
