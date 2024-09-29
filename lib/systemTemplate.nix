{ args, modules, vars, ... }:
let
  inherit (args) inputs lib system;
  inherit (inputs) nixpkgs home-manager;
  extraSpecialArgs = { inherit vars; };
in
  lib.nixosSystem {
    inherit system;
    modules = modules.nixos ++ [
        # TODO: create a map function to allow different users with different modules
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = extraSpecialArgs;
	  home-manager.users."${vars.username}".imports = modules.home;
	}
    ];
  } 
