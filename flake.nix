{
  description = "Tahlon's Nix-Config suited for multiple devices.";

  inputs = {
    
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀NixOS Packages❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstables.url = "github:NixOS/nixpkgs/nixos-unstable";
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Dot Files❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Secrets Managements❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    sops-nix = {
        url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Ephemeral Storage❀ ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    impermanence = {
      url = "github:nix-community/impermanence";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Disk Partioning❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Secure Boot❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Boot Media❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs:
  let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
    ];
    inherit (nixpkgs) lib;
    specialArgs = {
      inherit
        inputs
        outputs
        nixpkgs
        ;
    };
  in
  {
    nixosModules = import ./modules;
    overlays = import ./overlays { inherit inputs outputs; };
    packages = forAllSystems (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in 
      import ./pkgs { inherit pkgs; };
    );

#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Athena: QEMU❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    nixosConfigurations = {
      athena = lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs= specialArgs; }
          ./hosts/athena/default.nix
        ];
      };
    };
#    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
  };
}
