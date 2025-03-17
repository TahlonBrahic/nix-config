{
  inputs,
  outPath,
}: let
  users = ["tahlon"];
  system = "x86_64-linux";
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
    ./_wirelessNetworks.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules system inputs outPath users;}
