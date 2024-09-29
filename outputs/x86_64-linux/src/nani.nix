{ inputs, lib, customLib, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;
  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = map relativeToRoot [
    "hosts/${hostName}/configuration.nix" 
  ];

  # TODO: I would like to abstract how I pass users to systemTemplate.
  homeModules = with modulesRoot.home; [
    base
    tui
    gui
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
  
in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules vars; };
  };
}
