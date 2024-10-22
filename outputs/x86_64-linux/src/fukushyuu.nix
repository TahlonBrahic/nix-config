{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) optionalModules systemTemplate;

  customModules = {
    nixos = with optionalModules.nixos; [
      fhs
      gnome
      steam
    ];

    homeManager = with optionalModules.home; [
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
