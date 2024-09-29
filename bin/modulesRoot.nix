{ haumea, ... }:

{
  modulesRoot = haumea.lib.load {
    src = ../modules;
    loader = haumea.lib.loaders.path;
  };
}
