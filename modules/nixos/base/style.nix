{
  pkgs,
  inputs,
  vars,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;

    inherit (vars.themes.everforest-dark-hard) image;

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
      grub.enable = false;
    };

    polarity = "dark";
  };
}
