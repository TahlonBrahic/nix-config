{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f1e944d4-d1d1-4c73-8d52-6ba8cd3fc54a";
    fsType = "ext4";
  };

  fileSystems."/var/lib/lxd/devlxd" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  fileSystems."/var/lib/lxd/shmounts" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4014-F578";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  #TODO: Add /dev/sda1: LABEL="largeHD" UUID="578768db-ddb6-457c-820e-983488281989" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="c865fc92-6c62-410b-8e07-18776d853bd9"
  swapDevices = [
    {device = "/dev/disk/by-uuid/56eaaae0-5b35-42dd-8f70-35583866df62";}
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
