{pkgs, ...}: {
  home-manager.users."amy" = {
    home.packages = with pkgs; [
      zoom-us
      tor-browser
      vesktop
      google-chrome
    ];
    kosei = {
      fileManager.enable = false;
      git = {
        userName = "Tahlon Brahic";
        userEmail = "tahlonbrahic@proton.me";
      };
      homePackages.enable = true;
      hyprland.enable = false;
      passwordManagement.enable = true;
      rofi.enable = false;
      waybar.enable = false;
    };
  };
}
