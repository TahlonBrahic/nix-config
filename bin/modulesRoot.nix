{ haumea, nixpkgs, ... }:

{
  modulesRoot = haumea.lib.load {
    src = ../modules;
    inputs = { pkgs = import nixpkgs { system = "x86_64-linux"; }; };
  };
}
