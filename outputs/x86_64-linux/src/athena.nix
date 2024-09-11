{ inputs, lib, system, home-manager, ... }@args:

{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      specialArgs = { inherit inputs; };
      	modules = [
          ../../../hosts/athena/configuration.nix
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.tahlon.imports = ../../../users/i3t/home.nix;
	  } 
      	];
    };
  };
}
