{ lib, ... }@inputs:

{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      system = "x86_64-linux";
      	modules = [
        ../../../hosts/athena/configuration.nix
      	];
    };
  };
  homeConfigurations = { 
    "tahlon@athena" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      #extraSpecialArgs = { inherit inputs inputs.outputs; };
      modules = [ ../../../users/i3t/home/nix ];
      };
  };
}
