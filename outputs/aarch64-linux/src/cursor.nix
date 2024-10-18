{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
} @ customArgs: let
  inherit (customLib) modulesRoot;

  nixModules = with modulesRoot.nixos.opt; [ ];

  homeModules = with modulesRoot.home.opt; [ ];

  customModules = {
    nixos = nixModules;
    home = homeModules;
  };

  customVars = vars.users.tahlon;
in {
  nixOnDroidConfigurations = {
    "cursor" = droidTemplate {
      inherit customArgs customModules customVars;
    };
  };
}
