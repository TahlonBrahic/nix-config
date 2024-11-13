{
  config,
  hostName,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.fuyuVirt;
in {
  options = {
    fuyuVirt = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        daemon.settings = {
          "features" = {"containerd-snapshotter" = true;};
        };

        enableOnBoot = true;
        autoPrune.enable = true;
      };

      libvirtd = {
        enable = true;
        qemu.runAsRoot = true;
      };
      lxd.enable = true;
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      qemu_kvm
      qemu
    ];
    imports = [inputs.nixos-wsl.nixosModules.wsl];

    wsl = {
      enable = true;
      defaultUser = "tbrahic";
      startMenuLaunchers = true;

      wslConf = {
        automount.root = "/mnt";
        interop.appendWindowsPath = false;
        network.generateHosts = false;
        network.hostname = "${hostName}";
      };
    };

    # Enable auto-generated name servers
    environment.etc."resolv.conf".source = /etc/resolv.conf;
  };
}
