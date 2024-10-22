{haumea}: 
let
  overlaysSet = haumea.lib.load {
    src = ../overlays;
    loader = haumea.lib.loaders.path;
  };

  overlays = builtins.attrValues overlaysSet;
in
  overlays

