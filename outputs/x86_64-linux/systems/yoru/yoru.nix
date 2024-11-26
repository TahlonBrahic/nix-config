{
  inputs,
  pkgs,
  system,
  lib,
  overlays,
  ...
}: let
  hostName = "yoru";
  users = ["tahlon"];
  fuyuConfig = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in {
  nixosConfigurations =
    lib.systemTemplate
    {
      inherit inputs pkgs system hostName fuyuConfig users lib overlays;
    };
}
