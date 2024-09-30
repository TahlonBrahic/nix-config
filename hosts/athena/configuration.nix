{ config, pkgs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
  ];
 
  nix.settings.experimental-features = ["nix-command" "flakes" ];



  environment.variables.EDITOR = "vim";

  nixpkgs = {
   config = {
      allowUnfree = true;
    };
  };


  security.polkit.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      }; 
    };
  };

