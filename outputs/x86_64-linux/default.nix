{ args, ... }:

let
  inherit (args.haumea) haumea;

  data = haumea.lib.load {
    src = ./src;
    inputs = args;
  };

  dataWithoutPaths = builtins.attrValues data;
in
outputs = {
  nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
}
