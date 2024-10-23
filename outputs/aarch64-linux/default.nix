{
  lib,
  inputs,
  ...
} @ customArgs: let
  inherit (inputs) haumea nix-on-droid;

  data = haumea.lib.load {
    src = ./src;
    inputs = customArgs;
  };

  dataWithoutPaths = builtins.attrValues data;

  outputs = {
    nixOnDroidConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixOnDroidConfigurations or {}) dataWithoutPaths);
  };
in
  outputs // {inherit data;}
