{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
  which
  tree
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
  neofetch
  vim
  ];

  environment.variables.EDITOR = "vim";
}