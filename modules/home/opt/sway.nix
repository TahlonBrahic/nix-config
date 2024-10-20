{
  config,
  pkgs,
  lib,
  ...
}: {
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

    config = rec {
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
}
