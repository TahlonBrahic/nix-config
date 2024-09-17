{ args, ... }:

let
  systems = [
    ./athena.nix
    ./nani.nix
  ];
  modules = map(file: import file args) systems;
in
{
  import = modules;
}
