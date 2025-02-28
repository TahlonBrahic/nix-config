{
  inputs,
  lib,
  pkgs,
  outPath,
  ...
}: let
  hostName = "iso";
  users = ["nixos"];
  extraModules = [
    ./_home.nix
    ./_configuration.nix
  ];
in
  inputs.kosei.lib.liveISO {inherit extraModules hostName inputs lib pkgs outPath users;}
