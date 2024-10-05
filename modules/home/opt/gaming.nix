{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    protonup-qt
    steamcontroller
    steamtinkerlaunch
    steam-rom-manager
    cartridges
  ];
}    
