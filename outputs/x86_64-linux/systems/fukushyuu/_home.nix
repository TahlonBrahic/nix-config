{pkgs, ...}: {
  home-manager.users."amy" = {
    home.packages = with pkgs; [
      zoom-us
      tor-browser
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
