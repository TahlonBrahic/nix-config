{ haumea, ... }:

{
  modules = haumea.lib.load {
    src = ../modules;
    transformer = haumea.lib.transformers.liftDefault;
  };
}
