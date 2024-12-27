{
  home-manager.users."tahlon".fuyuNoKosei = {
    browser.firefox.enable = true;
    fileManager.enable = true;
    git = {
      enable = true;
      userName = "Tahlon Brahic";
      userEmail = "tahlonbrahic@proton.me";
    };
    homePackages.enable = true;
    hyprland.enable = true;
    passwordManagement.enable = true;
    rofi.enable = true;
    waybar.enable = true;
  };
}
