{ args, modules, vars, ... }:
let
  inherit (args) inputs lib customLib;
  inherit (inputs) nixpkgs home-manager;
  specialArgs = { inherit inputs lib customLib; };
  extraSpecialArgs = { inherit inputs customLib; };
  system = "x86_64-linux";
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules = modules.nixos ++ [
        # TODO: create a map function to allow different users with different modules
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = extraSpecialArgs;
	  home-manager.users."${vars.username}".modules = { imports = with customLib.modulesRoot; [modules.home]; };
	}
      ];
  } 
