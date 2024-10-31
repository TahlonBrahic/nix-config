{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  vars,
  overlays,
}: let
  inherit (localLib) optionalModules droidTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      fhs
    ];

    tahlon.homeManager = with optionalModules.home; [fish];
  };

  users = ["tahlon"];

  hostName = "cursor";
in {
  nixOnDroidConfigurations = {
    ${hostName} = droidTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
