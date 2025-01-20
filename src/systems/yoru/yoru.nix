{
  inputs,
  lib,
  pkgs,
  outPath,
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
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs lib pkgs outPath system users;}
