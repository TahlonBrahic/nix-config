{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  vars,
  overlays,
}: let
  inherit (localLib) optionalModules systemTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      greetd
    ];

    tahlon.homeManager = with optionalModules.home; [
      librewolf
      fetch
      kitty
      sway
      waybar
      zellij
    ];
  };

  users = ["tahlon"];

  hostName = "nani";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
