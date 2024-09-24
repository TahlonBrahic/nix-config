{ args, modules, tempVars, ... }:
let
  inherit (args) inputs lib bin;
  inherit (inputs) nixpkgs home-manager;
  specialArgs = { inherit inputs lib bin; };
  extraSpecialArgs = { inherit inputs bin; };
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
	  home-manager.users."${tempVars.username}".imports = modules.home;
	}
      ];
  } 
