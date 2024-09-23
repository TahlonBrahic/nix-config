{ config, pkgs, lib, customArgs, ... }: 
{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    (map customArgs.relativeToRoot [
      "modules/nixos/common"
    ])
  ];
 
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    age
  ];

  environment.variables.EDITOR = "vim";

  nixpkgs = {
   config = {
      allowUnfree = true;
    };
  };

  networking.hostName = "nani";

  users.users = {
    tahlon = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
      ];
      extraGroups = ["wheel"];
      initialPassword = "password";
    };
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINn/+0ClH1hC2Tqvahb6oLockr99dLKuK1vo53UHtibF tahlon@TAHLON-LAPTOP"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  security.polkit.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
      }; 
    };
  };

  system.stateVersion = "24.11";
}
