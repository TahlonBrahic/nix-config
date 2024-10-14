{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    just
    rustup
    cargo-cache
    cargo-expand
    mkcert
    httpie
    ansible
    tree-sitter

    # Language Servers
    nil

    # Formatters and Linters
    alejandra
    deadnix
    nodePackages.prettier
    spellcheck
    shfmt
    statix
  ];
}
