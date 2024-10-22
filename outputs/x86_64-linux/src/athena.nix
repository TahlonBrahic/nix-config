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
      greetd
    ];

    homeManager = with modulesRoot.home.opt; [
      sway
      kitty
      encryption
      gpg
      password
      zellij
    ];
  };

  customVars = vars.users.tahlon // vars.hardware.athena;
in {
  nixosConfigurations = {
    "athena" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
