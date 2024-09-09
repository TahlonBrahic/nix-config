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
}
