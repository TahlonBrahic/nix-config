{
  # TODO: Define monitors per fuyu-no-kosei specifications
  WAYLAND_DISPLAY = "wayland-1";
  ASPECT_RATIO = "16:10";

  monitor = {
    "eDP-1" = {
      position = "0:0"; # Position on the virtual screen
      resolution = "2880x1800"; # Resolution
      scale = 2.0; # Scale factor
      refreshRate = 120; # Refresh rate if applicable
    };
  };
}
