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

  users = ["amy" "tahlon"];

  hostName = "fukushyuu";
in {
  nixosConfigurations = {
    ${hostName} = systemTemplate {
      inherit inputs system lib pkgs fuyuNoLib vars overlays users hostName;
    };
  };
}
