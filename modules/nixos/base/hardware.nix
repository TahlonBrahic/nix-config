{ config, lib, pkgs, vars, modulesPath, ... }:

with vars;
{
  inherit imports;

  boot = {
    initrd = {
      kernelModules = initrdKernelModules;
    };
    inherit kernelModules;
    inherit extraModulePackages;
  };

  # Root 
  fileSystems."/" =
    { device = rootUUID;
      fsType = rootFT;
    };

  fileSystems."/boot" =
    { device = bootUUID;
      fsType = bootFT;
      options = [ "fmask=0022" "dmask=0022" ];
    }dd

  inherit swapDevices hardwareImports ;

  # Defaults
  hardware.enableAllFirmware = true;
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi", "sr_mod"  "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid" ];

  system.stateVersion = "24.11";
}
 
