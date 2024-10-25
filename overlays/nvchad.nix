{inputs, system, ...}:
{
  inputs.nixpkgs.overlays = (final: 
    prev: {
      nvchad = inputs.nvchad4nix.packages."${system}".nvchad;
     }
  );
}
