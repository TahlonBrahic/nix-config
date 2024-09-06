{ config, pkgs, ... }:

{
  home.username = "tahlon";
  home.homeDirectory = "/home/tahlon";

  home.packages = with pkgs; [
    zip
    neofetch
    neovim
  ];

  programs.git = {
    enable = true;
    userName = "Tahlon Brahic";
    userEmail = "tahlonbrahic@proton.me";
  };

  home.stateVersion = "24.05";
  
  programs.home-manager.enable = true;
}
