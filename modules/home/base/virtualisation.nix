{pkgs, ...}: {
  home.packages = with pkgs; [
    distrobox
    docker-compose
    podman
    podman-tui
    skopeo
    kubectl
    kubevirt
  ];

  programs.k9s.enable = true;
}
