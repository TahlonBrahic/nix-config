{ pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-compose
    skopeo
    kubectl
    kubevirt
  ];

  programs.k9s.enable = true;
}
