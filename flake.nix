{
  description = "Tahlon's Nix-Config suited for multiple devices.";

  inputs = {
    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀NixOS Packages❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstables.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
  };

  sops-nix = {
    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀Secrets Managements❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
    url = "github:mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
    ❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
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
    configVars = import ./vars { inherit input lib; };
    configLib = import ./lib { inherit lib; };
    specialArgs = {
      inherit
        inputs
        outputs
        configVars
        configLib
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
      import ./pkgs { inherit pkgs};
    );

    nixosConfigurations = {
      athena = lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          { home-manager.extraSpecialArgs= specialArgs; }
          ./hosts/athena/default.nix
        ];
      };
    };
  };
}
