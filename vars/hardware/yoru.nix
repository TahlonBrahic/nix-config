{modulesPath, ...}: {
  hostName = "yoru";
  rootUUID = "/dev/disk/by-uuid/";
  rootFT = "ext4";
  bootUUID = "/dev/disk/by-uuid/";
  bootFT = "vfat";
  swapDevices = [];
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  initrdKernelModules = [];
  kernelModules = [];
  extraModulePackages = [];
}
