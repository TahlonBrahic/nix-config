{ config, pkgs, ... }:
{ 
   services.xserver = {
     enable = true;
     layout = "us";
     xkbOptions = "terminate:ctrl_alt_bksp";
   };
   
   services.xserver.windowManager.i3 = {
     enable = true;
     package = pkgs.i3-gaps;
   };
 
   environment.systemPackages = with pkgs; [
     i3status
     dmenu
     rofi
   ];
}
