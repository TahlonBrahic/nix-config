{inputs, pkgs}: let 
  inherit (pkgs) fetchFromGitHub;

  base16Scheme = {
    slug = "everforest-dark-hard";
    scheme = "Everforest Dark Hard";
    author = "Sainnhe Park (https://github.com/sainnhe)";
    variant = "dark";
    palette = {
      base00 = "272e33"; 
      base01 = "2e383c"; 
      base02 = "414b50"; 
      base03 = "859289"; 
      base04 = "9da9a0"; 
      base05 = "d3c6aa"; 
      base06 = "edeada"; 
      base07 = "fffbef"; 
      base08 = "e67e80"; 
      base09 = "e69875"; 
      base0A = "dbbc7f"; 
      base0B = "a7c080"; 
      base0C = "83c092"; 
      base0D = "7fbbb3"; 
      base0E = "d699b6"; 
      base0F = "9da9a0"; 
    };
  };

  wallpaperRepo = fetchFromGitHub {
    owner = "Apeiros-46B";
    repo = "everforest-walls";
    rev = "main";
    hash = "sha256-RKebxSl3c18cqGQgiF/wOHezmwjEYKn+YhgEAc9nJPc=";
  };

  image = "${wallpaperRepo}/close_up/flowers.png";
in {
  inherit base16Scheme image;
}
