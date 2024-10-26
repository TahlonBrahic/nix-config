{lib, users, ...}: let
  inherit (lib.attrsets) genAttrs; 
in {
  home = {
    username = "tahlon";
    homeDirectory = "/home/tahlon";
    stateVersion = "24.05";
  };

  # github:nixcommunity/home-manager/issues/2064
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  home.sessionVariables = {
    XDG_RUNTIME_VARIABLES = "/run/user/$UID";
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
