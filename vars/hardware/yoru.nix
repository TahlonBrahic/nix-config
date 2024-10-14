{
  hostName = "yoru";
  bootFT = "vfat";
  initrdKernelModules = ["dm-snapshot"];
  kernelModules = ["kvm-intel"];
  extraModulePackages = [];
}
