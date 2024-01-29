{
  description = "My nixos config as a flake";


  inputs = {
    # Stable
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Unstable
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager-unstable.url = "github:nix-community/home-manager";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };


  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable }:
  let common_dir = ./common;
  in {
    nixosConfigurations = {

      nixos = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit common_dir; };
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager-unstable.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cameron = import ./hosts/nixos/home-manager/cameron.nix;

            home-manager.extraSpecialArgs = { inherit common_dir; };
          }
        ];
      };

      nixserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit common_dir; };
        modules = [
          ./hosts/nixserver/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cameron = import ./hosts/nixserver/home-manager/cameron.nix;

            home-manager.extraSpecialArgs = { inherit common_dir; };
          }
        ];
      };

    };
  };
}
