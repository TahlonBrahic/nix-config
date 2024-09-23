{ inputs, lib, bin, ... }@args:

let
  inherit (inputs) disko sops-nix;
  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = map bin.relativeToRoot [
    "hosts/${hostName}/configuration.nix" 
  ];

  # TODO: I would like to abstract how I pass users to systemTemplate.
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
  
  tempVars = {
    username = "tahlon";
  };

  templateArgs = args // modules // tempVars;
in
{
  nixosConfigurations = {
    "${hostName}" = bin.systemTemplate templateArgs;
  };
}
