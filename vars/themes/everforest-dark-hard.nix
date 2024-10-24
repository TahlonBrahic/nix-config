{inputs, pkgs}: let 
  inherit (pkgs) fetchFromGitHub;
  repo = fetchFromGitHub {
    owner = "tinted-theming";
    repo = "schemes";
    rev = "spec-0.11";
    hash = "sha256-UCRGabAyj8+RFkKdSZBR8BPE6yLM3rPpdxXHmwd9rZ0=";
    # src = "base16/everforest-dark-hard.yaml";
  };

  base16scheme = builtins.readFile (repo + "/base16/everforest-dark-hard.yaml");

  wallpaperRepo = fetchFromGitHub {
    owner = "TahlonBrahic";
    repo = "assets";
    rev = "main";
    hash = "";
    # src = "wallpapers/everforest-dark-hard/nix";
  };

  wallpaper = "${wallpaperRepo}/wallpapers/everforest-dark-hard/nix.jpg";
in {
  inherit base16scheme wallpaper;
}
