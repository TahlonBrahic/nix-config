{ pkgs, ... }:

with inputs.stylix;
{
  cursor.package = pkgs.bibata-cursors;
  cursor.name = "Bibata-Modern-Ice";
  
  fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };

  # polarity = "dark" "light" "either"

  # fonts.sizes

  # opacity
}
