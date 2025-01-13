{
  inputs,
  lib,
  pkgs,
  ...
}: let
  hostName = "shilo";
  users = ["tbrahic"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs lib pkgs system users;}
