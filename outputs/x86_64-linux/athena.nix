{ ... }@args:

let
  inherit (args) inputs lib home-manager;
in
{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      	modules = [
          /etc/nixos/hosts/athena/configuration.nix
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.tahlon.imports = /etc/nixos/users/i3t/home.nix;
	  } 
      	];
    };
  };
}
