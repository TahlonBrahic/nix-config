{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix stylix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos; [
    opt.greetd 
    opt.fhs
    opt.stylix
  ];

  homeModules = with modulesRoot.home; [
    opt.chrome
    opt.discord
    opt.encryption
    opt.fetch
    opt.kitty
    opt.password
    opt.sway
    opt.zellij
  ];

  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
    ] ++ nixModules;
    home = homeModules;
  };
 
  outputVars = vars.users.tahlon // vars.hardware.nani;

in
{
  nixosConfigurations = {
    "nani" = systemTemplate { inherit args modules; vars = outputVars; };
  };
}
