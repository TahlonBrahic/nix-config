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
      gnome
      gaming
    ];

    amy.homeManager = with optionalModules.home; [
      chrome
      discord
      fetch
      gaming
      protonGTK
      streaming
    ];

    tahlon.homeManager = with optionalModules.home; [
      firefox
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
