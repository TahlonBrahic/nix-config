{pkgs-stable, ...}: {
  programs.rofi = {
    enable = true;
    #package = pkgs-stable.rofi-wayland;
    #extraConfig = {
    #  show-icons = true;
    #};
  };
}
