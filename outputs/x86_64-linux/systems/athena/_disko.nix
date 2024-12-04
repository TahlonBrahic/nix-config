{
  disko.devices = {
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
                mountOptions = ["umask=0077"];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  keyFile = "/tmp/secret.key";
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                   "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/games" = {
                      mountpoint = "/games";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/games/local" = {
                      mountOptions = ["noatime"];
                    };
                    "/games/storage" = {
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "/backups" = {
                      mountpoint = "/backups";
                      mountOptions = ["compress=zstd"];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountpoint = "/sandbox";
        mountOptions = [
          "size=10G"
        ];
      };
    };
  };
}
