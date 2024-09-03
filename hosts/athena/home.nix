{ lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "tahlon";
    HomeDirectory = "/home/tahlon/"; 

    stateVersion - "24.05";
} 
