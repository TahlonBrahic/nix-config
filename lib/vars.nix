{haumea}: 
let
  varsSet = haumea.lib.load {
    src = ../var;
    loader = haumea.lib.loaders.path;
  };

  vars = builtins.attrValues varsSet;
in
  vars
