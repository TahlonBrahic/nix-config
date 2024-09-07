{ inputs, lib, ... }:

{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      modules = [
        ../../../hosts/athena/configuration.nix
	inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.tahlon = import ../../../users/i3t/home.nix; 
	}
      ];
    };
  };
}
