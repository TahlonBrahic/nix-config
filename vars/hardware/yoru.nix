{modulesPath, ...}: {
  hostName = "yoru";
  bootFT = "vfat";
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  initrdKernelModules = ["dm-snapshot"];
  kernelModules = ["kvm-intel"];
  extraModulePackages = [];
}
