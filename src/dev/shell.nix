{
  kosei,
  system,
}: let
  pkgs = import kosei.inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
    nativeBuildInputs = with pkgs; [
      # Nix
      nix
      home-manager

      git
      # Formatters & Linters
      bashInteractive
      alejandra
      deadnix
      statix
      typos
      nodePackages.prettier

      # Secrets Management
      sops
      age
    ];
  };
}
