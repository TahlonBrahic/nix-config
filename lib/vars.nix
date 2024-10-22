{haumea}@inputs: 
  #lib = import ./lib.nix {inherit haumea;};
let
  vars = haumea.lib.load {
    src = ../vars;
    inputs = {inherit inputs;};
  };
in
  vars
