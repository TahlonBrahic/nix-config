{ inputs, lib, customLib, system, vars, ... }@args:

let
  inherit (inputs) disko sops-nix;
  inherit (customLib) relativeToRoot modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos; [
    opt.fhs
    #opt.gamemode
    opt.gnome
    opt.steam
  ];

  homeModules = with modulesRoot.home; [
    opt.chrome
    opt.discord
    opt.encryption
    opt.fetch
    opt.gaming
    opt.obsidian
    opt.password
    opt.protonGTK
    opt.streaming
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

  outputVars = vars.users.amy // vars.hardware.fukushyuu;

in
{
  nixosConfigurations = {
    "fukushyuu" = systemTemplate { inherit args modules; vars = outputVars;};
  };
}
