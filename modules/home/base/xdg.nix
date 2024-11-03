{
  config,
  lib,
  ...
}: let
  cfg = config.customXDG;
  dir = "${config.home.homeDirectory}";
in {
  options = {
    customXDG = {
      enable = lib.mkEnableOption {
        default = true;
        example = false;
        description = "Whether to enable custom xdg directory handling.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        desktop = null;
        download = "${dir}/inbox";
        documents = "${dir}/documents";
        music = null;
        pictures = null;
        publicShare = null;
        templates = null;
        videos = null;
        extraConfig = {
          XDG_PROJECTS_DIR = "${dir}/projects";
          XDG_SYSTEM_DIR = "${dir}/system";
          XDG_MISC_DIR = "${dir}/misc";
        };
      };
    };
  };
}
