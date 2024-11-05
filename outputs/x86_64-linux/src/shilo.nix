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
      wsl
    ];

    tbrahic.homeManager = with optionalModules.home; [
      fetch
      firefox
      jeezyvim
      zellij
    ];
  };

  users = ["tbrahic"];

  hostName = "shilo";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs pkgs-stable localLib vars overlays modules users hostName;
    };
  };
}
