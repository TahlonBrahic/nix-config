{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.fuyuDisplay;

  hyprlandGamemodePrograms = lib.makeBinPath [
    config.programs.hyprland.package
    pkgs.coreutils
    pkgs.power-profiles-daemon
  ];
in {
  options = {
    fuyuDisplay = {
      hyprland = {
        enable = lib.mkEnableOption "hyprland";
        gamemode = {
          startscript = lib.mkOption {
            type = lib.types.string;
            default = pkgs.writeShellScript "gamemode-start" ''
              export PATH=$PATH:${hyprlandGamemodePrograms}
              export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
              hyprctl --batch 'keyword decoration:blur 0 ; keyword animations:enabled 0 ; keyword misc:vfr 0'
              powerprofilesctl set performance
            '';
          };
          endscript = lib.mkOption {
            type = lib.types.string;
            default = pkgs.writeShellScript "gamemode-end" ''
              export PATH=$PATH:${hyprlandGamemodePrograms}
              export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
              hyprctl --batch 'keyword decoration:blur 1 ; keyword animations:enabled 1 ; keyword misc:vfr 1'
              powerprofilesctl set power-saver
            '';
          };
        };
      };
      sway = {
        enable = lib.mkEnableOption "sway";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = lib.mkIf cfg.hyprland.enable {
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
            "SUPER,a,exec,killall rofi || rofi -show drun"
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

    home.packages = with pkgs; [
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout # wayland logout menu
      wlr-randr # wayland output utility
      wlr-which-key # keymap manager
      mako # notification system
      wofi # gtk-based app launcher
      kitty # backup terminal
      rot8 # screen rotation daemon
      wl-kbptr
      wl-gammactl
      wl-screenrec
      wl-mirror
      wineWowPackages.wayland
      clipman
      swappy
      wpa_supplicant_gui
      brightnessctl
      wev
      playerctl
      pavucontrol
    ];

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome-keyring.enable = true;

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
    };

    programs.wofi.enable = true;

    # enable sway window manager
    wayland.windowManager.sway = {
      enable = true;

      config = {
        menu = "wofi";
        modifier = "Mod4";
        terminal = "kitty";
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
          }
        ];

        gaps = {
          smartBorders = "on";
          smartGaps = false;
          outer = -8;
          inner = 28;
        };

        window = {
          titlebar = false;
        };

        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0";
          };
          "type:touchpad" = {
            middle_emulation = "enabled";
            natural_scroll = "enabled";
            tap = "enabled";
          };
        };

        keybindings = let
          mod = config.wayland.windowManager.sway.config.modifier;
          cfg = config.wayland.windowManager.sway.config;
        in
          # Window Management
          lib.mkOptionDefault {
            "${mod}+t" = "exec ${cfg.terminal}";
            "${mod}+a" = "exec ${pkgs.wofi}";
            "${mod}+q" = "kill";

            # Modes
            "${mod}+i" = "mode randr";

            # Screenshots
            "Print" = "grim -g \"$(slurp)\" - | wl-copy -t image/png";
          };
      };
      wrapperFeatures.gtk = true;
    };
  };
}
