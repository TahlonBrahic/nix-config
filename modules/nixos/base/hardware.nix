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

  boot = {
    initrd = {
      kernelModules = initrdKernelModules;
    };
    inherit kernelModules;
    inherit extraModulePackages;
  };

  # Root
  fileSystems."/" = {
    device = rootUUID;
    fsType = rootFT;
  };

  fileSystems."/boot" = {
    device = bootUUID;
    fsType = bootFT;
    options = ["fmask=0022" "dmask=0022"];
  };

  inherit swapDevices;

  # Defaults
  hardware.enableAllFirmware = true;
  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk" "nvme" "usb_storage" "sd_mod" "usbhid"];
}
