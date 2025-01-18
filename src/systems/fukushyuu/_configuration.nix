{inputs, ...}: {
  kosei = {
    boot.enable = true;
    design = {
      wallpaper = "${inputs.assets}/wallpapers/anime/a_waterfall_in_the_rain.jpg";
      theme = "${inputs.assets}/themes/nord.yaml";
    };
    displayManager = {
      enable = true;
      lightdm.enable = true;
    };
    gaming.enable = true;
    GNOME.enable = true;
    microphone.enable = true;
    syncthing.enable = true;
    secrets.defaultSopsFile = ../../secrets/secrets.yaml;
    ssh.enable = true;
  };
}
