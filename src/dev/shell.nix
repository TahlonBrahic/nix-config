{
  kosei,
  system,
}: let
  pkgs = import kosei.inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  default =
    pkgs.mkShell {
      NIX_CONFIG = "
	extra-experimental-features = nix-command flakes pipe-operators
	pure-eval = false
	";
      nativeBuildInputs = with pkgs; [
        # Nix
        nix
        home-manager
        nixos-generators

        git
        # Formatters & Linters
        bashInteractive
        alejandra
        deadnix
        statix
        typos
        nodePackages.prettier

        # TODO: link binary for kosei sops and age
      ];
    };
}
