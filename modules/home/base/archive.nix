{pkgs, ...}: {
  home.packages = with pkgs; [
    gzip
    rar
    zip
    zstd
  ];
}
