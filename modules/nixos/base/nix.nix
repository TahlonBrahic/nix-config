{
  pkgs,
  inputs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = [];
      accept-flake-config = true;
      auto-optimise-store = true;
    };
    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  nixpkgs.config.allowUnfree = true;
}
