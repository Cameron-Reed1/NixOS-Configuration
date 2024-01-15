{
  description = "My nixos config as a flake";


  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };


  outputs = { self, nixpkgs, nixpkgs-unstable }: {
    nixosConfigurations = {

      nixos = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit self;
          nixpkgs = nixpkgs-unstable;
        };
        modules = [
          ./hosts/nixos/configuration.nix
        ];
      };

      nixserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
            inherit self nixpkgs;
        };
        modules = [
          ./hosts/nixserver/configuration.nix
        ];
      };

    };
  };
}
