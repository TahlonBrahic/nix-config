{
  pkgs,
  inputs,
  vars,
  ...
}: 
let
  inherit (vars) themes;
in 
{
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    inherit (themes.fushiguro) image;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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

    opacity = {
      applications = 4.0;
      popups = 5.0;
      terminal = 2.0;
    };

    targets = {
      wofi.enable = true;
    };

    polarity = "dark";
  };
}
