{
  inputs,
  pkgs,
  system,
  lib,
  overlays,
  ...
}: let
  hostName = "shilo";
  users = ["tbrahic"];
  extraConfig = [
    ./_home.nix
    ./_configuration.nix
  ];
in {
  nixosConfigurations = {
    ${hostName} =
      lib.systemTemplate
      {
        inherit inputs pkgs system hostName extraConfig users lib overlays;
      };
  };
}
