{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    htop
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  }
}
