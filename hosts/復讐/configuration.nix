{ inputs, lib, config, pkgs, ... }:
# Note: this is a temporary configuration while I work on my module system.
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "fukushyuu"; 

  users.users = {
    amy = {
      initialPassword = "temppass";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    deskstopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ vim ];
  programs.vim.defaultEditor = true;
}
