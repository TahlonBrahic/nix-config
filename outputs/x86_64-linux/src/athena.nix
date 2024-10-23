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
      greetd
    ];

    homeManager = with modules.home.opt; [
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
