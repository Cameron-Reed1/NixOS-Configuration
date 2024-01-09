{

  description = "My nixos config as a flake";


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
  };


  outputs = { self, nixpkgs }@inputs: 
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {

      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./configuration.nix
        ];
      };

    };
  };

}
