{ ... }@args:

let
  inherit (args) lib inputs;
  specialArgs = { inherit inputs; };
  extraSpecialArgs = { inherit inputs; };
in
{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      system = "x86_64-linux";
        inherit specialArgs;
      	modules = [
          ../../hosts/athena/configuration.nix
	  inputs.home-manager.nixosModules.home-manager {
            #inherit extraSpecialArgs;
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.users.tahlon.imports = [ ../../hosts/athena/home.nix ];  }
      ];
    };
  };
}
