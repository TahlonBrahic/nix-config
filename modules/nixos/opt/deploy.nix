{
  # This module is used for remote deployment
  # TODO: Add import for Disko config
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINn/+0ClH1hC2Tqvahb6oLockr99dLKuK1vo53UHtibF tahlon@TAHLON-LAPTOP"
      ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
    };
  };
}
