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
      greetd
    ];

    homeManager = with optionalModules.nixos; [
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
