{ lib, bin, inputs, ... }@args:

let
  inherit (inputs) disko sops-nix;
  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = map bin.relativeToRoot [
    "hosts/${hostName}/configuration.nix" 
  ];

  homeModules = map bin.relativeToRoot [
    "hosts/${hostName}/home.nix"
  ];
  
  hostName = "nani";
  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
    ] ++ nixModules;
    home = [ ] ++ homeModules;
  };
in
{
  nixosConfigurations = {
    "${hostName}" = bin.systemTemplate ( modules // args );
  };
}
