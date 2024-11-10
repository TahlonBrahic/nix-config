{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  pkgs-stable,
  vars,
  overlays,
}: let
  inherit (localLib) optionalModules systemTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      greetd
      laptop
    ];

    tahlon.homeManager = with optionalModules.home; [
      fetch
      firefox
      hyprland
      kitty
      librewolf
      rofi
      waybar
      zellij
    ];
  };

  users = ["tahlon"];

  hostName = "yoru";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs pkgs-stable localLib vars overlays modules users hostName;
    };
  };
}
