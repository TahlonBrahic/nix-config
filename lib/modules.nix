{haumea}: let
  allModulesSet = haumea.lib.load {
    src = ../modules;
    loader = haumea.lib.loaders.path;
  };

  modules = builtins.attrValues allModulesSet;
in
  modules
