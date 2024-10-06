{ 
  hostName = "athena";
  rootUUID = "/dev/disk/by-uuid/bfbb2b4f-d7d4-4a26-bfa2-55148077754d";
  rootFT = "ext4";
  bootUUID = "/dev/disk/by-uuid/80D3-F09A";
  bootFT = "vfat";
  swapDevices = [  ];
  systemImports = [ "/profiles/qemu-guest.nix" ];
  initrdKernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm_intel" ];
  extraModulePackages = [ ];
}
