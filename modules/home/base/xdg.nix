{config, ...}: let
  dir = "${config.home.homeDirectory}";
in {
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${dir}/inbox";
      documents = "${dir}/documents";
      extraConfig = {
        XDG_PROJECTS_DIR = "${dir}/projects";
        XDG_SYSTEM_DIR = "${dir}/system";
        XDG_MISC_DIR = "${dir}/misc";
      };
    };
  };
}
