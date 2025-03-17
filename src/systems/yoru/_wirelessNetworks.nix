{lib, ...}: {
  kosei.networking.wirelessNetworks = ["blue" "red" "Tahlon"];
  #systemd.network.networks."40-wireless" = {
  #  enable = true;
  #  matchConfig.Name = "wlan";
  #  networkConfig.DHCP = "yes";
  #  linkConfig.RequiredForOnline = "no";
  #};
  systemd.network.links."wlo1" = {
    enable = true;
  };
  networking.networkmanager.enable = true;
  networking.firewall.enable = lib.mkForce false;
}
