{
  inputs,
  system,
  lib,
  pkgs,
  localLib,
  vars,
  overlays
}: let
  inherit (localLib) modulesRoot droidTemplate;

  nixModules = with modulesRoot.nixos.opt; [ ];

  homeModules = with modulesRoot.home.opt; [ ];

  modules = {
    nixos = nixModules;
    home = homeModules;
  };

  customVars = vars.users.tahlon;
in {
  nixOnDroidConfigurations = {
    "cursor" = droidTemplate {
      inherit inputs system lib localLib pkgs vars overlays modules customVars;
    };
  };
}
