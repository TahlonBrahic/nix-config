{lib, inputs, ...} @ customArgs: let

  inherit (inputs) haumea;

  data = haumea.lib.load {
    src = ./src;
    inputs = customArgs // {system = "x86_64-linux";};
  };

  dataWithoutPaths = builtins.attrValues data;

  outputs = {
    nixosConfigurations = lib.attrsets.mergeAttrsList (map (it: it.nixosConfigurations or {}) dataWithoutPaths);
  };
in
  outputs // {inherit data;}
