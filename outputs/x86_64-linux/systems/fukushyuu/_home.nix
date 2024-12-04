{pkgs, ...}: {
  home-manager.users."amy" = {
    home.packages = with pkgs; [
      zoom-us
    ];
    fuyuNoKosei = {
      compositor = {
        enable = false;
        hyprland.enable = false;
      };
      browser = {
        chrome.enable = true;
        chromium.enable = false;
      };
    };
  };
}
