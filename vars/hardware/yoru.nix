{ vars, modulesPath, ... }:

{
  hostName = "yoru";
  rootUUID = "/dev/disk/by-uuid/";
  rootFT = "ext4";
  bootUUID = "/dev/disk/by-uuid/";
  bootFT = "vfat";
  swapDevices = [  ];
  imports =  [ (modulesPath + "/installer/scan/not-detected.nix") ];
  initrdKernelModules = [ ];
  kernelModules = [  ];
  extraModulePackages = [ ];

  disko = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "lvm_pv"
                vg = "pool"
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                };
                "/home" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                  mountpoint = "/home";
                };
                "/nix" = {
                  mountOptions = [ "compress=zstd" "noatime" ];
                  mountpoint = "/nix";
                };
              };
            };
          };
        };
      };
    };
  }; 
}
