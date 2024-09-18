{ args, ... }:

let
  systems = [
    ./athena.nix
    ./nani.nix
  ];
  modules = map(file: import file { inherit args; }) systems;
in
{
  import = modules;
}
