{inputs, ...}: {
  config = {
    nixpkgs.hostPlatform = "x86_64-linux";
    programs.dconf.enable = true;
    kosei = {
      boot.enable = true;
      displayManager.enable = true;
      ssh = {
        enable = true;
        publicKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRUJCFyU2Bhag5GHGq2ihZL6LljX8EZygeKU6KDzHL8 tbrahic@proton.me"
        ];
      };
      design = {
        theme = "${inputs.assets}/themes/nord.yaml";
      };
    };
  };
}
