{
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443];
  };
}
