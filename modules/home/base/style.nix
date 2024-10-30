{
  pkgs,
  vars,
  ...
}: let
  inherit (vars.themes.everforest-dark-hard) base16Scheme;
in {
  stylix = {
    enable = true;

    inherit base16Scheme;

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
      applications = .5;
      popups = .5;
      terminal = .5;
    };

    polarity = "dark";

    targets.rofi.enable = true;
  };
}
