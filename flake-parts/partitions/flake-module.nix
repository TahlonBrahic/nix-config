localFlake: {self, ...}: {
  partitions = {
    misc = {
      extraInputsFlake = ./misc;
      module = ./misc/flake-module.nix;
    };
    dev = {
      extraInputsFlake = ./dev;
      module = ./dev/flake-module.nix;
    };
  };

  partitionedAttrs = {
    checks = "dev";
    # ci = "dev";
    formatter = "dev";
    homeManager = "misc";
  };
}
