{ inputs, lib, config, pkgs, ... }:
# Note: this is a temporary configuration while I work on my module system.
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "fukushyuu"; 
  networking.networkmanager.enable = true;
  
  users.users = {
    amy = {
      initialPassword = "temppass";
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";  

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb.layout = "us";
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gnome-terminal
    gnome-music
    xterm
    cheese
    gedit
    epiphany 
    geary 
    evince 
    gnome-characters
    totem 
    tali 
    iagno 
    hitori 
    atomix 
  ];

  nixpkgs.config.allowUnfree = true;

  services.openssh = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ vim git ];
  programs.vim.defaultEditor = true;
  
  system.stateVersion = "23.11";  
}
