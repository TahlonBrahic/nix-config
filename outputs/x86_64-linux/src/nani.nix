{ lib, inputs, system, customArgs, specialArgs ? (customArgs system), ... }:

let
  inherit (inputs) disko home-manager sops-nix;
  host = "nani"; 
in
{
  nixosConfigurations = {
    ${host} = lib.nixosSystem {
      inherit system;
        inherit specialArgs;
      	modules = [
          ../../../hosts/${host}/configuration.nix
          inputs.disko.nixosModules.disko
          sops-nix.nixosModules.sops
	  home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.tahlon.imports = [ ../../../hosts/${host}/home.nix ];  }
      ];
    };
  };
}
