{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos; [
    opt.greetd
    opt.fhs
  ];

  homeModules = with modulesRoot.home; [
    opt.obsidian
    opt.sway
    opt.kitty
    opt.encryption
    opt.gpg
    opt.password
    opt.zellij
  ];

  modules = {
    nixos = [
      disko.nixosModules.disko
      sops-nix.nixosModules.sops
    ] ++ nixModules;
    home = [
    ] ++ homeModules;
  };

  outputVars = vars.users.tahlon // vars.hardware.athena;

in
{
  nixosConfigurations = {
    "athena" = systemTemplate { inherit args modules; vars = outputVars; };
  };
}
