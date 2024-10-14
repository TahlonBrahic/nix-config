<<<<<<< HEAD
{
  vars,
  modulesPath,
  ...
}:
with vars; {
  imports =
    if builtins.isList modulesPath
    then map (systemImport: modulesPath + systemImport) systemImports
    else [];
||||||| bf526fc
{ config, lib, pkgs, vars, modulesPath, ... }:

with vars;
{
  imports = if builtins.isList modulesPath then 
    map (systemImport: modulesPath + systemImport) systemImports 
    else [  ];
=======
{ config, lib, pkgs, vars, modulesPath, ... }:

if vars.hostName == "yoru" then with vars; {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "samsung-laptop" "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [  ];
  #boot.kernelPackages = pkgs.linuxPackages_cachyos;
  #chaotic.scx.enable = true;
  hardware.enableAllFirmware = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/96ce0bc2-93c0-4b1a-b807-4b5a958e5c01";

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/.swapvol" =
    { device = "/dev/disk/by-uuid/f479ea2a-00ea-4cc2-83ee-c9d458b67193";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7F60-3E7E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


else with vars; {
  imports = if builtins.isList modulesPath then 
    map (systemImport: modulesPath + systemImport) systemImports 
    else [  ];
>>>>>>> origin/main

  boot = {
    initrd = {
      kernelModules = initrdKernelModules;
    };
    inherit kernelModules;
    inherit extraModulePackages;
  };

<<<<<<< HEAD
  # Root
  fileSystems."/" = {
    device = rootUUID;
    fsType = rootFT;
  };
||||||| bf526fc
  # Root 
  fileSystems."/" =
    { device = rootUUID;
      fsType = rootFT;
    };
=======
  # Root
  fileSystems."/" = 
    {
      device = "/dev/disk/by-uuid/ad806bd2-8771-43e9-9783-849c2ae2cec4";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
>>>>>>> origin/main

<<<<<<< HEAD
  fileSystems."/boot" = {
    device = bootUUID;
    fsType = bootFT;
    options = ["fmask=0022" "dmask=0022"];
  };
||||||| bf526fc
  fileSystems."/boot" =
    { device = bootUUID;
      fsType = bootFT;
      options = [ "fmask=0022" "dmask=0022" ];
    };
=======
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/boot" = 
    {
      device = bootUUID;
      fsType = bootFT;
      options = [ "fmask=0022" "dmask=0022" ];
    };
>>>>>>> origin/main

  inherit swapDevices;

  # Defaults
  hardware.enableAllFirmware = true;
<<<<<<< HEAD
  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid"];
}
||||||| bf526fc
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod"  "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid" ];
}
 
=======
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "thunderbolt" "sd_mod" "sr_mod" "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid" ];
} 

>>>>>>> origin/main
