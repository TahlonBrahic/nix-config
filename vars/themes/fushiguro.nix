{ pkgs, ...}:
{
  image = pkgs.fetchurl {
    url = "https://4kwallpapers.com/images/walls/thumbs_3t/15221.png";
    hash = "sha256-GfmqcwkEygLmsg/OSmdyfgBW1gPGZPHnsuAd6IX/XoM=";
  }
} 
