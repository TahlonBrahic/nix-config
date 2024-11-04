{
  config,
  lib,
  vars,
  pkgs,
  hostName,
  modulesPath,
  ...
}:
# TODO: Add option for WSL host
if hostName == "shilo"
then {}
else if hostName == "fukushyuu"
then {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f1e944d4-d1d1-4c73-8d52-6ba8cd3fc54a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4014-F578";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/var/lib/lxd/shmounts" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  fileSystems."/var/lib/lxd/devlxd" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/56eaaae0-5b35-42dd-8f70-35583866df62";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp12s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp8s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
else if hostName == "yoru"
then {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["samsung-laptop" "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
      luks.devices."crypted".device = "/dev/disk/by-uuid/96ce0bc2-93c0-4b1a-b807-4b5a958e5c01";
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["acpi_backlight=vendor" "acpi_osi=Linux" "snd-hda-intel" "model=laptop-dmic"];
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
# TODO: Standardize to this layout
else
  with vars.hardware.${hostName}; {
    imports =
      if builtins.isList modulesPath
      then map (systemImport: modulesPath + systemImport) systemImports
      else [];

    boot = {
      initrd = {
        kernelModules = initrdKernelModules;
      };
      inherit kernelModules;
      inherit extraModulePackages;
    };

    # Root
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/ad806bd2-8771-43e9-9783-849c2ae2cec4";
        fsType = "btrfs";
        options = ["subvol=root"];
      };

      "/boot" = {
        device = bootUUID;
        fsType = bootFT;
        options = ["fmask=0022" "dmask=0022"];
      };
    };

    inherit swapDevices;

    # Defaults
    hardware = {
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
    };

    boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "thunderbolt" "sd_mod" "sr_mod" "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid"];

    zramSwap = {
      enable = true;
      algorithm = "zstd";
      priority = 5;
      memoryPercent = 50;
    };
  }
