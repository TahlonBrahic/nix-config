{ pkgs, inputs, ... }:

let
  inherit (inputs) stylix;
in
{
  stylix = { 
    enable = true;

    image = pkgs.fetchurl {
      url = "https://4kwallpapers.com/images/walls/thumbs_3t/15221.png";
      hash = "sha256-GfmqcwkEygLmsg/OSmdyfgBW1gPGZPHnsuAd6IX/XoM=";
    };

    cursor = { 
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  
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

    opacity = {
      applications = 5.0;
      popups = 5.0;
      terminal = 5.0;
    };

    targets = {
      grub.enable = false;
    };

    polarity = "dark";
  };
}
