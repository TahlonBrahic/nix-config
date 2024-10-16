{nvchad4nix, pkgs}:
{
  (final: 
    prev: {
      nvchad = nvchad4nix.packages."${pkgs.system}".nvchad;
     }
  )
}
