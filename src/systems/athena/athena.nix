{
  inputs,
  lib,
  pkgs,
  ...
}: let
  hostName = "athena";
  users = ["tahlon" "test"];
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs lib outPath pkgs users;}
