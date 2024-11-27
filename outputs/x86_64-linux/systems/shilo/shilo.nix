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
  fuyuConfig = [
    ./_home.nix
    ./_configuration.nix
  ];
in {
  nixosConfigurations = {
    ${hostName} =
      lib.systemTemplate
      {
        inherit inputs pkgs system hostName fuyuConfig users lib overlays;
      };
  };
}
