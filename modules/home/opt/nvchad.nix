{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad.enable = true;
}
