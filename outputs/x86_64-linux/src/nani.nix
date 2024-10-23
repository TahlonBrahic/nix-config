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
      greetd
      fhs
      style
    ];

    homeManager = with modules.home.opt; [
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
