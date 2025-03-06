{
  inputs,
  outPath,
  ...
}: let
  hostName = "fukushyuu";
  users = ["amy"];
  extraModules = [
    ./_home.nix
    ./_configuration.nix
    ./_hardware-configuration.nix
  ];
in
  inputs.kosei.lib.systemTemplate {inherit extraModules hostName inputs outPath users;}
