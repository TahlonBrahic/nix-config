{lib, ...}: {
  home-manager = {
    backupFileExtension = lib.mkForce "temp";
    users = {
      "tahlon" = {
        programs.broot.enable = lib.mkForce false;
        services.gammastep = {
          longitude = -85.00;
          latitude = 40.00;
          provider = "manual";
        };
        kosei = {
          arduino.enable = true;
          browser.firefox.enable = true;
          fileManager.enable = true;

          git = {
            enable = true;
            userName = "Tahlon Brahic";
            userEmail = "tahlonbrahic@proton.me";
          };
          gpg.enable = false;
          officeUtils.enable = true;
          hyprland = {
            enable = true;
          };
          passwordManagement.enable = true;
          rofi.enable = true;
          waybar.enable = true;
        };
      };
    };
  };
}
