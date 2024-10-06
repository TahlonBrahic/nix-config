{ config, lib, pkgs, vars, modulesPath, ... }:

{
  inherit (vars) imports;

  boot = {
    initrd = {
      inherit (vars.initrdKernelModules) kernelModules;
    };
    inherit (vars) kernelModules;
    inherit (vars) extraModulePackages;
  };

  # Root 
  fileSystems."/" =
    { device = vars.rootUUID;
      fsType = vars.rootFT;
    };

  fileSystems."/boot" =
    { device = vars.bootUUID;
      fsType = vars.bootFT;
      options = [ "fmask=0022" "dmask=0022" ];
    }dd

  inherit (vars) swapDevices hardwareImports ;

  # Defaults
  hardware.enableAllFirmware = true;
  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi", "sr_mod"  "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid" ];

  system.stateVersion = "24.11";
}
 
