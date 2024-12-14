{ pkgs, ... }:
{
  fuyuNoKosei = {
    secrets.defaultSopsFile = ../../../../secrets/secrets.yaml;
    GNOME.enable = true;
    gaming.enable = true;
    displayManager = {
      tuigreet.enable = false;
      lightdm.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
