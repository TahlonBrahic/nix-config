{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    fastfetch
  ];
}
