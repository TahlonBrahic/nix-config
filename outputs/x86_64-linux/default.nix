{
  inputs,
  system,
  lib,
  localLib,
  pkgs,
  vars,
  overlays,
}: let
  inherit (inputs) haumea;

  data = haumea.lib.load {
    src = ./src;
    inputs = {inherit inputs system lib localLib pkgs vars overlays;};
  };

  dataWithoutPaths = builtins.attrValues data;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
  };
in
  outputs // {inherit data;}
