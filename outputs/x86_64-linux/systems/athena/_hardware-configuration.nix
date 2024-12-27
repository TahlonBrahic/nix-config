{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bb39b2aa-0cac-4289-9658-264eece94fd7";
    fsType = "btrfs";
    options = ["subvol=@"];
  };

  boot.initrd.luks.devices."luks-f4ecfd19-106d-46b4-91d4-a5bc7aeb5e7f".device = "/dev/disk/by-uuid/f4ecfd19-106d-46b4-91d4-a5bc7aeb5e7f";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D593-4329";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
