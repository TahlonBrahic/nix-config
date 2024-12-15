{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"]; # samsung-laptop?
      kernelModules = [];
      luks.devices."crypted".device = "/dev/disk/by-uuid/96ce0bc2-93c0-4b1a-b807-4b5a958e5c01";
    };
    kernelModules = ["kvm-intel"];
    # extraModulePackages = with config.boot.kernelPackages; [samsung-galaxybook-extras];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "acpi_backlight=vendor"
      "acpi_osi=Linux"
      "snd-hda-intel"
      "model=laptop-dmic"
      "i915.enable_dpcd_backlight=3"
      "i915.enable_dp_mst=0"
      "i915.enable_psr2_sel_fetch=1"
    ];
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    "/.swapvol" = {
      device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = ["subvol=swap"];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/7F60-3E7E";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [];
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
