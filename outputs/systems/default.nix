{ lib, inputs, ... }:

{
  source = builtins.filter (name: lib.strings.hasSuffix ".nix" name) (builtins.attrNames (builtins.readDir ./src));
  data = map (file: import (./src + "/" file) { inherit inputs; }) source;
  dataWithoutPaths = builtins.attrValues (lib.attrsets.concatAttrs data);

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
  };
}
