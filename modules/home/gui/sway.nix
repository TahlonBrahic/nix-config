{ pkgs, ... }: 
 
{
  home.packages = with pkgs; [
    swaykdbb
    wayland-utils
    wl-clipboard
    wlprop
  ];

  wayland = {
    windowManager = {
      sway = {
        enable = true;
        config = {
          modifier = "Mod4";
          bars = [{
            command = "\${pkgs.waybar}/bin/waybar";
          }];
        };
      };
    };
  };
}
