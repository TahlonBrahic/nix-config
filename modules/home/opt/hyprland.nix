{lib, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = ["--all"];
    };

    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
        "MOZ_ENABLE_WAYLAND, 1"
        "MOZ_WEBRENDER, 1"
        "XDG_SESSION_TYPE, wayland"
        "WLR_NO_HARDWARE_CURSORS, 1"
        "WLR_RENDERER_ALLOW_SOFTWARE, 1"
      ];

      input = {
        follow_mouse = 1;
        mouse_refocus = false;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
        };
      };

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      bind = let
        workspaces = ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9"];
        directions = rec {
          left = "l";
          right = "r";
          up = "u";
          down = "d";
          h = left;
          l = right;
          k = up;
          j = down;
        };
      in
        [
          "SUPER,t,exec,kitty"
          "SUPER,f,exec,librewolf"
          "SUPER,q,killactive"
          "SUPER,a,exec,killall rofi || rofi -show"
          "SUPER,s,togglespecialworkspace"
          "SUPER,g,togglegroup"
          "SUPER,w,fullscreen"
        ]
        ++
        # Change workspaces
        (map (n: "SUPER,${n},workspace,name:${n}") workspaces)
        ++
        # Move window to workspace
        (map (n: "SUPERSHIFT,${n},movetoworkspacesilent,name:${n}") workspaces)
        ++
        # Move focus
        (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
        ++ (lib.mapAttrsToList (
            key: direction: "SUPERCONTROL,${key},movewindoworgroup,${direction}"
          )
          directions);

      general = {
        gaps_in = 6;
        gaps_out = 6;
        border_size = 0;
        resize_on_border = true;
        hover_icon_on_border = true;
      };

      decoration = {
        rounding = 5;
        drop_shadow = true;
        shadow_range = 30;
        shadow_render_power = 2;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };
      };

      gestures = {
        workspace_swipe = true;
      };
    };
  };
}
