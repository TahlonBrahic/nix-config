{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    which
    cifs-utils
    rsync
    sysstat
    iotop
    iftop
    btop
    nmon
    sysbench
    pciutils
    usbutils
    lm_sensors
    psmisc
    dmidecode
    parted
    ethtool
    just
    vim
    age
    tmux
    curl
    htop
    killall
    findutils
    ripgrep
    bottom
    du-dust
    findutils
    fd
    fx
    sd
    procs
  ];
}
