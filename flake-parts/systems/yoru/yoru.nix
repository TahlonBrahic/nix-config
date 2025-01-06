{
  inputs,
  lib,
  ...
}: let
  hostName = "yoru";
  users = ["tahlon"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  lib.systemTemplate
  {
    inherit inputs hostName lib extraModules system users;
  }
