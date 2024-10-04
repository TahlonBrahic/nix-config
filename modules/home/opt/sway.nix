{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wlogout # wayland logout menu
    wlr-randr # wayland output utility
    mako # notification system developed by swaywm maintainer
    wofi # gtk-based app launcher
    
  ];

  # Enable the gnome-keyring secrets vault. 
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome-keyring.enable = true;

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
  };

  # enable sway window manager
  wayland.windowManager.sway = {
    enable = true;
    config = {
      menu = "wofi";
    };
    wrapperFeatures.gtk = true;
  };
}
