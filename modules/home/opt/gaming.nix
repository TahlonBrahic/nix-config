{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    bottles
    protonup-qt
    steamcontroller
    steamtinkerlaunch
    steam-rom-manager
    cartridges
  ];
}
