{inputs, ...}: {
  fuyuNoKosei = {
    boot.enable = true;
    displayManager.enable = true;
    syncthing.enable = true;
    secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
    ssh.enable = true;
    yubikey.enable = true;
    design = {
      wallpaper = "${inputs.assets}/wallpapers/anime/a_waterfall_in_the_rain.jpg";
      theme = "${inputs.assets}/themes/nord.yaml";
    };
  };
}
