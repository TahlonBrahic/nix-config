{
  inputs,
  lib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (lib) modules systemTemplate;

  customModules = {
    nixos = with modules.nixos.opt; [
      fhs
      gnome
      steam
    ];

    homeManager = with modules.home.opt; [
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
