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
      fhs
      gnome
      steam
    ];

    amy.homeManager = with optionalModules.home; [
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

  users = ["amy" "tahlon"];

  hostName = "fukushyuu";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
