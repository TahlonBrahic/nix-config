{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (inputs) disko sops-nix chaotic nur;
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    fhs
    gnome
    steam
  ];

  homeModules = with modulesRoot.home.opt; [
    chrome
    discord
    encryption
    fetch
    gaming
    obsidian
    password
    protonGTK
    streaming
    zellij
  ];

  customModules = {
    nixos =
      [
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
        chaotic.nixosModules.default
        nur.nixosModules.nur
      ]
      ++ nixModules;
    home = homeModules;
  };

  customVars = vars.users.amy // vars.hardware.fukushyuu;
in {
  nixosConfigurations = {
    "fukushyuu" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
