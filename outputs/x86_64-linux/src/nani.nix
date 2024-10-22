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
      greetd
      fhs
      style
    ];

    homeManager = with modulesRoot.home.opt; [
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
