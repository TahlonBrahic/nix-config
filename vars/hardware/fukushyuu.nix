{modulesPath, ...}: {
  hostName = "fukushyuu";
  rootUUID = "/dev/disk/by-uuid/f1e944d4-d1d1-4c73-8d52-6ba8cd3fc54a";
  rootFT = "ext4";
  bootUUID = "/dev/disk/by-uuid/4041-F578";
  bootFT = "vfat";
  swapDevices = [];
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  initrdKernelModules = [];
  kernelModules = ["kvm-amd"];
  extraModulePackages = [];
}
