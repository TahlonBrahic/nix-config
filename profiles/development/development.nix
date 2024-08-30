{ config, pkgs, ...}:

{
  home.username = "tahlon";
  home.homeDirectory = "home/tahlon/portable" # Reference ./module/home # Make sure this doesn't interfere with dot file deployment

  home.packages = with pkgs; [
    podman
    docker
    ansible
    python3
    powershell
    rustc
    cargo
    go
    openjdk
    ghc
  ];

  # Import neovim / NVchad
  # Import tmux config
  # Import powershell config
  # Import emacs conig
}
