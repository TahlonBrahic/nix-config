{pkgs, ...}: {
  home-manager.users."tbrahic".fuyuNoKosei = {
    status.enable = false;
  };
  home.systemPackages = with pkgs; [
    obs-studio
  ];
}
