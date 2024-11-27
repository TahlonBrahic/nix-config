{lib, ...}: {
  secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
  virtualization.wsl.enable = true;
  tools.enable = true;
  environment.etc."resolv.conf".source = lib.mkForce /etc/resolv.conf;
  networking.networkmanager.enable = lib.mkForce true;
  networking.useNetworkd = lib.mkForce false;
}
