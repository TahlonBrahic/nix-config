{
  inputs,
  lib,
  pkgs,
  outPath,
  ...
}: let
  hostName = "shilo";
  users = ["tbrahic"];
  extraModules = [
    ./_home.nix
    ./_configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs lib outPath pkgs users;}
