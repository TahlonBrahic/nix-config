{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (customLib) modulesRoot systemTemplate;

  customModules = {
    nixos = with modulesRoot.nixos.opt; [
      fhs
      gnome
      steam
    ];

    homeManager = with modulesRoot.home.opt; [
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
  };

  customVars = vars.users.amy // vars.hardware.fukushyuu;
in {
  nixosConfigurations = {
    "fukushyuu" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
