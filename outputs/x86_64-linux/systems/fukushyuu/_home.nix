{pkgs, ...}: {
  home-manager.users."amy" = {
    home.packages = with pkgs; [
      zoom-us
      obs-studio
      tor-browser
      corectrl
      radeon-profile
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
