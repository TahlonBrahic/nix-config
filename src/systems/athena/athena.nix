{
  inputs,
  lib,
  pkgs,
  ...
}: let
  hostName = "athena";
  users = ["tahlon" "test"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs lib outPath pkgs system users;}
