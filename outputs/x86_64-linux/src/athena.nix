{ inputs, lib, system, home-manager, ... }@args:

let
  inherit (inputs) inputs args;
in
{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      	modules = [
          builtins.trace "importing configuration.nix" ../../../hosts/athena/configuration.nix
	  builtins.trace "importing homemanager" home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.tahlon.imports = ../../../users/i3t/home.nix;
	  } 
      	];
    };
  };
}
