{
  home-manager.users."tbrahic".fuyuNoKosei = {
    browser.firefox.enable = true;
    fileManager.enable = false;
    git = {
      enable = true;
      userName = "Tahlon Brahic";
      userEmail = "tahlonbrahic@proton.me";
    };
    homePackages.enable = true;
    hyprland.enable = false;
    passwordManagement.enable = true;
    rofi.enable = false;
    waybar.enable = false;
  };
}
