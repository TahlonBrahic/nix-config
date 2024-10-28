{pkgs, ...}: {
  home.packages = with pkgs; [
    gzip
    zip
    zstd
  ];
}
