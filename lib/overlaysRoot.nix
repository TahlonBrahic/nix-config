{haumea}: 
let
  overlaysRoot = haumea.lib.load {
    src = ../overlays;
    loader = haumea.lib.loaders.path;
  };
}
in
  overlays
