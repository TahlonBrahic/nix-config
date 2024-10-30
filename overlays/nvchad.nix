{
  inputs,
  system,
  pkgs,
}: (final: prev: {
  nvchad = inputs.nvchad4nix.packages."${system}".nvchad;
})
