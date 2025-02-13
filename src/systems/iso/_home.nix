{
  home-manager.users = {
    "nixos".kosei = {
      arduino.enable = true;
      browser.firefox.enable = true;
      fileManager.enable = true;
      git = {
        enable = true;
        userName = "Tahlon Brahic";
        userEmail = "tahlonbrahic@proton.me";
      };
      homePackages.enable = true;
      hyprland = {
        enable = true;
      };
      rofi.enable = true;
      syncthing.enable = true;
      waybar.enable = true;
    };
  };
}
