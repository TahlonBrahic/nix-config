{ vars, modulesPath, ... }:

{
  hostName = "yoru";
  # rootUUID = "/dev/disk/by-uuid/ad806bd2-8771-43e9-9783-849c2ae2cec4";
  # rootFT = "btrfs";
  # bootUUID = "/dev/disk/by-uuid/A80C-80DD";
  # bootFT = "vfat";
  # swapDevices = [  ];
  imports =  [ (modulesPath + "/installer/scan/not-detected.nix") ];
  initrdKernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm-intel" ];
  extraModulePackages = [ ];
}
