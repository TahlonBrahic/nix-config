{
  pkgs,
  inputs,
  vars,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = [ "${vars.username}" ];
      accept-flake-config = true;
      auto-optimise-store = true;
    };
    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };
    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';
  };

  nixpkgs.config.allowUnfree = true;
}
