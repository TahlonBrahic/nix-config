{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages  = with pkgs; [
      material-design-icons
      font-awesome
      
      # Add nerd fonts
      # Add fontconfig.defaultFonts
    ];

# This will purposely error as a reminder to fix later :)
