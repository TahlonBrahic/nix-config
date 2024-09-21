{
  pkgs,
  nur-ataraxiasjel,
  ...
}: {
  # Enable nested virsualization, required by security containers and nested vm. 
  # This should be set per host in /hosts, not here.

  ## TO DO: Make a lib-MkIF here to pick between these... ##

  ## For AMD CPU, add "kvm-amd" to kernelModules.
  # boot.kernelModules = ["kvm-amd"];
  # boot.extraModprobeConfig = "options kvm_amd nested=1";  # for amd cpu
  
  ## For Intel CPU, add "kvm-intel" to kernelModules.
  # boot.kernelModules = ["kvm-intel"];
  # boot.extraModprobeConfig = "options kvm_intel nested=1"; # for intel cpu

  boot.kernelModules = ["vfio-pci"];

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        # enables pulling using containerd, which supports restarting from a partial pull
        # https://docs.docker.com/storage/containerd/
        "features" = {"containerd-snapshotter" = true;};
      };

      enableOnBoot = true;
    };

      libvirtd = {
        enable = true;
        qemu.runAsRoot = true;
      };
      lxd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
    qemu
  ];
}
