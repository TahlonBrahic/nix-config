{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    protonup-qt
    steamcontroller
    steamtinkerlauncher
    steam-rom-manager
    cartridges
  ];
}    
