{haumea, ...} @ inputs: let
  vars = haumea.lib.load {
    src = ../vars;
    inputs = {inherit inputs;};
  };
in
  vars
