{ args, modules, vars, ... }:

let
  inherit (args) inputs lib customLib system;
  inherit (inputs) nixpkgs home-manager;
  inherit (customLib) baseNixosModules baseHomeModules;
  specialArgs = { inherit inputs lib customLib vars; };
  extraSpecialArgs = { inherit inputs customLib vars; };
in
  lib.nixosSystem {
    inherit system specialArgs;
    modules = baseNixosModules ++ modules.nixos ++ [
        # TODO: create a function to allow different users with different modules
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = extraSpecialArgs;
          home-manager.backupFileExtension = "backup";
	  home-manager.users."${vars.username}".imports = modules.home ++ baseHomeModules;
	}
    ];
  } 
