{ config, pkgs, inputs, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
      })
    ];
  };
}
