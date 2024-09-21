{ lib, inputs, disko, ... }@args:

let
  specialArgs = { inherit inputs; };
  extraSpecialArgs = { inherit inputs; };
  host = "fukushyuu"; 
in
{
  nixosConfigurations = {
    ${host} = lib.nixosSystem {
      system = "x86_64-linux";
        #inherit specialArgs;
      	modules = [
          ../../../hosts/${host}/configuration.nix
          inputs.disko.nixosModules.disko
	  inputs.home-manager.nixosModules.home-manager {
            #inherit extraSpecialArgs;
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.users.amy.imports = [ ../../../hosts/${host}/home.nix ];  }
      ];
    };
  };
}
