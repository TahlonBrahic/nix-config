{ config, pkgs, ... }:

{
  home.username = "amy";
  home.homeDirectory = "/home/amy";

  home.packages = with pkgs; [
    zip
    neofetch
    discord
    chromium
    bottles
    zoom
    lutris
  ];

  programs.git = {
    enable = true;
    userName = "Tahlon Brahic";
    userEmail = "tahlonbrahic@proton.me";
  };

  programs.kitty = {
    enable = true;
  };
  
  programs.steam.enable = true;

  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
