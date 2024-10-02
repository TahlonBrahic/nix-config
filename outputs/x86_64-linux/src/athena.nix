{ inputs, lib, customLib, system, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot varsRoot systemTemplate;

  # TODO: I would like to abstract how I import these as I do it for each host.
  nixModules = map relativeToRoot [
    "hosts/${hostName}/configuration.nix" 
  ];

  # TODO: I would like to abstract how I pass users to systemTemplate.
  homeModules = with modulesRoot.home; [
    base.archive
    base.git
    base.xdg
    base.container
    base.nix
    base.home
        
    opt.obsidian
    opt.sway
    opt.kitty
    opt.encryption
    opt.gpg
    opt.password
    opt.zellij
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
  
  tempVars = varsRoot.varsRoot.users.tahlon;

in
{
  nixosConfigurations = {
    "${hostName}" = systemTemplate { inherit args modules; vars = tempVars; };
  };
}
