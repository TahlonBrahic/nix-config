{pkgs, ...}: let
  logout = pkgs.writeShellScriptBin "logout" ''
    if pgrep -x "wlogout" > /dev/null
    then
      pkill -x "wlogout"
      exit 0
     fi
     wlogout --protocol layer-shell
  '';
in {
  home.packages = with pkgs; [
    wlogout
    wlr-randr
    brightnessctl
  ];

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;

      settings = {
        mainBair = {
          layer = "top";
          position = "bottom";
          height = 30;
          margin-top = -10;
          margin-bottom = 0;
          margin-right = 100;
          margin-left = 100;
          font-family = "JetBrainsMono Nerd Font Mono";

          window = {
            border = 3;
            titlebar = false;
          };
          modules-left = ["custom/power"];
          modules-center = ["clock"];
          modules-right = ["custom/battery"];

          "custom/power" = {
            "format" = "{}";
            "rotate" = 0;
            "on-click" = "wlogout";
            "interval" = 86400;
            "tooltip" = true;
          };

          "custom/battery" = {
            "states" = {
              "good" = 80;
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{icon} {capacity}%";
            "format-charging" = " {capacity}%";
            "format-plugged" = " {capacity}%";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          style = ''
            #custom-hyprbindings, #battery, #powery {
              padding: 0px 18px;
              margin: 4px 0px;
              border-radius: 10px 24px 10px 24px;
            }
          '';
        };
      };
    };
  };
}
