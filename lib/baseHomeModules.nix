{haumea}: let
  baseHomeModulesSet = haumea.lib.load {
    src = ../modules/home/base;
    loader = haumea.lib.loaders.path;
  };

  baseHomeModules = builtins.attrValues baseHomeModulesSet;
in
  baseHomeModules
