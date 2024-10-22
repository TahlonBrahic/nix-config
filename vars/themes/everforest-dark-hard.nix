let
  repo = builtins.fetchFromGitHub {
    owner = "tinted-theming";
    repo = "schemes";
    src = "base16/everforest-dark-hard.yaml";  
  };

  base16theme = builtins.readFile (repo + "/base16/everforest-dark-hard.yaml");

  wallpaperRepo = pkgs.fetchFromGitHub {
    owner = "TahlonBrahic";  
    repo = "assets";  
    rev = "main";  
    src = "wallpapers/everforest-dark-hard/nix";  
  };

  wallpaper = "${wallpaperRepo}/wallpapers/everforest-dark-hard/nix.jpg";
in 
{
  inherit base16theme wallpaper;
}
