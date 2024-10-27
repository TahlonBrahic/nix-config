
{
  inputs,
  system, 
  lib,
  localLib,
  pkgs,
  vars,
  overlays
}: let
  inherit (localLib) optionalModules droidTemplate;

  modules = {
    nixos = with optionalModules.nixos; [
      fhs
    ];

    homeManager = with optionalModules.home; [ ];
  };

  users = ["tahlon"];

  hostName = "curosr";

in {
  nixOnDroidConfigurations.default = {
    ${hostName} = droidTemplate {
      inherit inputs system lib pkgs localLib vars overlays modules users hostName;
    };
  };
}
