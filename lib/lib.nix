{haumea}: let
  libSet = haumea.lib.load {
    src = ./.;
    loader = haumea.lib.loaders.path;
  };

  lib = builtins.attrValues libSet; 
in
  lib
