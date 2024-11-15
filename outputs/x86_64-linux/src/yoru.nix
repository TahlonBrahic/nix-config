{
  inputs,
  system,
  lib,
  fuyuNoLib,
  pkgs,
  vars,
  overlays,
}: let
  inherit (fuyuNoLib) systemTemplate;

  users = ["tahlon"];

  hostName = "yoru";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs fuyuNoLib vars overlays users hostName;
    };
  };
}
