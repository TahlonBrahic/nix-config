{ inputs, lib, args, vars } :
let
  inherit (inputs) nixpkgs home-manager;
in
  lib.nixosSystem {
    inherit specialArgs;
    modules = 
      nixos ++ [ 
        home-manager.nixosModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = specialArgs = specialArgs;
	  home-manager.users"${vars.username}".imports = home-modules;
	}
      ]
}
