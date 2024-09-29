{ ... }@args:

let
  inherit (args) inputs lib customLib vars;
  # TODO: I do not know a good way to import system
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs { inherit system; };
  modulesRoot = inputs.haumea.lib.load {
    src = ../modules;
    #inputs = { inherit lib customLib vars pkgs; };
    loader = inputs.haumea.lib.loaders.path;
  };
in 
  modulesRoot

