{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    htop

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    jq-go
    eza
    fzf

    dnzutils
    nmap
    ipcalc
    aria2
    mtr

    file
    which
    tree
    gnused
    gnutar
    gawk
    zst
    gnupg
    nnn

    strace
    ltrace
    lsof

    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
  }
}
