{inputs, ...}: {
  config = {
    programs.dconf.enable = true;
    kosei = {
      boot.enable = true;
      displayManager.enable = true;
      laptopSupport = {
        enable = true;
        enableHyprlandSupport = true;
      };
      microphone.enable = true;
      ssh = {
        enable = true;
        publicKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRUJCFyU2Bhag5GHGq2ihZL6LljX8EZygeKU6KDzHL8 tbrahic@proton.me"
        ];
      };
      yubikey.enable = true;
      design = {
        theme = "${inputs.assets}/themes/nord.yaml";
      };
    };
  };
}
