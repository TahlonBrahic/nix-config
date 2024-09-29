{ inputs, bin, lib, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (bin) relativeToRoot modules
  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = map relativeToRoot [
    "hosts/${hostName}/configuration.nix" 
  ];

  # TODO: I would like to abstract how I pass users to systemTemplate.
  homeModules = with modules.home; [
    core
    gui
    tui
  ];
  
  hostName = "nani";
  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
    ] ++ nixModules;
    home = [
    ] ++ homeModules;
  };
  
  tempVars = {
    username = "tahlon";
  };

  templateArgs = args // modules // tempVars;
in
{
  nixosConfigurations = {
    "${hostName}" = bin.systemTemplate { inherit args modules tempVars; };
  };
}
