{pkgs, ...}: {
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "terminate:ctrl_alt_bksp";
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  home.packages = with pkgs; [
    i3status
    dmenu
    rofi
  ];
}
