{
  inputs,
  outPath,
}: let
  users = ["tahlon"];
  system = builtins.currentSystem;
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules system inputs outPath users;}
