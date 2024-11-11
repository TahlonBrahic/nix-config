{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        "features" = {"containerd-snapshotter" = true;};
      };

      enableOnBoot = true;
      autoPrune.enable = true;
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
