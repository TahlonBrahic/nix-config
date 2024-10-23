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
      greetd
      fhs
      style
    ];

    homeManager = with optionalModules.home; [
      librewolf
      encryption
      fetch
      kitty
      password
      sway
      waybar
      zellij
    ];
  };

  customVars = vars.users.tahlon // vars.hardware.nani;
in {
  nixosConfigurations = {
    "nani" = systemTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
