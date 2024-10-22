{haumea}: let
  optionalModules = {
    home = haumea.lib.load {
      src = ../modules/home/opt;
      loader = haumea.lib.loaders.path;
    };

    nixos = haumea.lib.load {
      src = ../modules/nixos/opt;
      loader = haumea.lib.loaders.path;
    };
  };
in
  optionalModules
