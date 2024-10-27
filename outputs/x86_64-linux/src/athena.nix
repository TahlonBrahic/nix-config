{
  inputs,
  system, 
  lib,
  localLib,
  pkgs,
  vars,
  overlays
}: let
  inherit (localLib) optionalModules systemTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      fhs
      greetd
    ];

    homeManager = with optionalModules.home; [
      sway
      kitty
      encryption
      gpg
      password
      zellij
    ];
  };

  users = ["tahlon"];

  hostName = "athena";

in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}

