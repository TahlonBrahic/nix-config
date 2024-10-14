{args}: let
  inherit (args) inputs;
  modulesRoot = inputs.haumea.lib.load {
    src = ../modules;
    loader = inputs.haumea.lib.loaders.path;
  };
in
  modulesRoot
