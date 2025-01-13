{pkgs, ...}: {
  home-manager.users."amy" = {
    home.packages = with pkgs; [
      zoom-us
      tor-browser
    ];
    fuyuNoKosei = {
      fileManager.enable = false;
      homePackages.enable = true;
      hyprland.enable = false;
      passwordManagement.enable = true;
      rofi.enable = false;
      waybar.enable = false;
    };
  };
}
