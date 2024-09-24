{ inputs, lib, vars, args, modules, ... }:
let
  inherit (inputs) nixpkgs home-manager;
  system = "x86_64-linux";
  specialArgs = args;
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules = modules.nixos ++ [
        # TODO: create a map function to allow different users with different modules
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = specialArgs;
	  home-manager.users."${vars.username}".imports = modules.home;
	}
      ];
  }
