{ inputs, ... }:

{
  system = {
    stateVersion = "24.11";
    autoupgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L"
      ];
    };
  };
}
