{ pkgs, vars, ... }:

{
  home.packages = with pkgs; [
    chromium
  ];
}
