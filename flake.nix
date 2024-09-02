{
  description = "Tahlon's Nix-Config suited for multiple devices.";

  inputs = { 
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };

    nixpkgs-unstable = { 
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };  

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
        url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  #outputs = { self, nixpkgs, home-manager, ... }@inputs: import ./outputs/default.nix { inherit inputs; };
  outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      athena = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tahlon = import ./home.nix;
          }
        ];
      };
    };
  };
}
