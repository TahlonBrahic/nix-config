{
  inputs,
  lib,
  pkgs,
  outPath,
  ...
}: let
  hostName = "iso";
  users = ["nixos"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
  ];
in
  inputs.kosei.lib.liveISO {inherit extraModules hostName inputs lib pkgs outPath system users;}
