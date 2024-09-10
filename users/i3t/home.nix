{ config, pkgs, ... }:

{
  home.username = "tahlon";
  home.homeDirectory = "/home/tahlon";

  home.packages = with pkgs; [
    zip
    neofetch
    neovim
    # sway stuff
    swaykbdd
    wayland-utils
    wl-clipboard
    wlprop
  ];

  programs.git = {
    enable = true;
    userName = "Tahlon Brahic";
    userEmail = "tahlonbrahic@proton.me";
  };

  programs.kitty = {
    enable = true;
  };

  home.stateVersion = "24.05";

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        config = {
          modifier = "Mod4";
#          bars = [{
#            command = "\${pkgs.waybar}/bin/waybar";
#          }];
        };
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
