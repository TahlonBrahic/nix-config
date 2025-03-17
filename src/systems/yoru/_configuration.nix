{
  inputs,
  config,
  ...
}: {
  config = {
    kosei = {
      email.address = "tahlonbrahic@gmail.com";
      boot.enable = true;
      #home-assistant = {
      #  enable = true;
      #  domain = "localhost";
      #};
      displayManager.enable = true;
      laptopSupport = {
        enable = true;
        enableHyprlandSupport = true;
      };
      microphone.enable = true;
      nixpkgs.enable = false;
      ssh = {
        enable = true;
        publicKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDRUJCFyU2Bhag5GHGq2ihZL6LljX8EZygeKU6KDzHL8 tbrahic@proton.me"
        ];
      };
      syncthing.enable = false;
      yubikey.enable = true;
      design = {
        theme = "${inputs.assets}/themes/nord.yaml";
      };
    };
  };
}
