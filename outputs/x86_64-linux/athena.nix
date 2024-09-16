{ ... }@args:

let
  inherit (args) lib inputs;
in
{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      system = "x86_64-linux";
      #specialArgs = { inherit inputs; };
      	modules = [
          ../../hosts/athena/configuration.nix
	  inputs.home-manager.nixosModules.home-manager {
        
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.users.tahlon.imports = [ ../../users/i3t/home.nix ];  }
      ];
    };
  };
}
