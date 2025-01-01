localFlake: {
  flake-parts-lib,
  inputs,
  lib,
  ...
}:
flake-parts-lib.mkTransposedPerSystemModule {
  file = ./args.nix;
  name = "args";
  option = lib.mkOption {
    type = lib.types.unspecified;
    default = {
    };
  };
}
