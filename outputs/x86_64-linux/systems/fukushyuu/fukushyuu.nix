{
  inputs,
  pkgs,
  system,
  lib,
  overlays,
  ...
}: let
  hostName = "fukushyuu";
  users = ["amy"];
  extraConfig = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
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