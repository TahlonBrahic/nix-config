{ lib, ... }@inputs:

{
  nixosConfigurations = {
    athena = lib.nixosSystem {
      modules = [
        ../../../hosts/athena/configuration.nix
      ];
    };
  };
}
