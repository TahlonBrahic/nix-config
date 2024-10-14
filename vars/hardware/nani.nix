{modulesPath, ...}: {
  hostName = "nani";
  rootUUID = "/dev/disk/by-uuid/29e0b67d-95c0-4090-9ff3-6f779bb3684d";
  rootFT = "ext4";
  bootUUID = "/dev/disk/by-uuid/80D3-F09A";
  bootFT = "vfat";
  swapDevices = [];
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];
  initrdKernelModules = ["dm-snapshot"];
  kernelModules = ["kvm_intel"];
  extraModulePackages = [];
}
