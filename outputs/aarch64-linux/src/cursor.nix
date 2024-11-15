{
  inputs,
  system,
  lib,
  fuyuNoLib,
  pkgs,
  vars,
  overlays,
}: let
  inherit (fuyuNoLib) droidTemplate;

  users = ["tahlon"];

  hostName = "cursor";
in {
  nixOnDroidConfigurations = {
    ${hostName} = droidTemplate {
      inherit inputs system lib pkgs fuyuNoLib vars overlays users hostName;
    };
  };
}
