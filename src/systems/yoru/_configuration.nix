{inputs, ...}: {
  config = {
    kosei = {
      boot.enable = true;
      displayManager.enable = true;
      laptopSupport = {
        enable = true;
        enableHyprlandSupport = true;
      };
      microphone.enable = true;
      syncthing.enable = true;
      secrets.defaultSopsFile = ../../secrets/secrets.yaml;
      ssh.enable = true;
      yubikey.enable = true;
      design = {
        wallpaper = "${inputs.assets}/wallpapers/anime/a_waterfall_in_the_rain.jpg";
        theme = "${inputs.assets}/themes/nord.yaml";
      };
    };
  };
}
