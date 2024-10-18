{pkgs, ...}: {
  home.packages = with pkgs; [
    gzip
    rar
    tar
    zip
    zstd
  ];
}
