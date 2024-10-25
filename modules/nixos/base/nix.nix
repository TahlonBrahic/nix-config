{
  pkgs,
  inputs,
  users,
  ...
}: 
let
  forEachUser = builtins.attrVals users;
in 
{
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = forEachUser (map (user: [ "${user.username}" ]) users);
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

  # OOM configuration:
  systemd = {
    # Create a separate slice for nix-daemon that is
    # memory-managed by the userspace systemd-oomd killer
    slices."nix-daemon".sliceConfig = {
      ManagedOOMMemoryPressure = "kill";
      ManagedOOMMemoryPressureLimit = "50%";
    };
    services."nix-daemon".serviceConfig.Slice = "nix-daemon.slice";

    # If a kernel-level OOM event does occur anyway,
    # strongly prefer killing nix-daemon child processes
    services."nix-daemon".serviceConfig.OOMScoreAdjust = 1000;
  };
}
