{
  description = "NixOS configuration that follows fuyu-no-kosei.";

  inputs = {
    assets = {
      url = "github:TahlonBrahic/assets";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    fuyuNoKosei = {
      url = "github:TahlonBrahic/fuyu-no-kosei";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fuyu-no-nur = {
      url = "github:TahlonBrahic/fuyu-no-nur";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    fuyuvim = {
      url = "github:TahlonBrahic/fuyu-no-neovim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixvim.follows = "nixvim";
        fuyuNoNur.follows = "fuyu-no-nur";
      };
    };
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    jeezyvim = {
      url = "github:LGUG2Z/JeezyVim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixvim.follows = "nixvim";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    haumea,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs self;}
    ({
      flake-parts-lib,
      withSystem,
      ...
    }: let
      inherit (flake-parts-lib) importApply;
      lib = inputs.nixpkgs.lib // inputs.fuyuNoKosei.lib;
      flakeModules =
        lib.attrsets.genAttrs ["partitions"] (module:
          importApply ./flake-parts/${module}/flake-module.nix {inherit withSystem;});
    in {
      debug = true;
      systems = ["x86_64-linux"];
      imports =
        [
          flake-parts.flakeModules.flakeModules
          flake-parts.flakeModules.partitions
        ]
        ++ lib.attrsets.attrValues flakeModules;
      perSystem = {pkgs, ...}: {
        devShells = import ./shell.nix {inherit pkgs;};
      };

      flake = {
        inherit flakeModules;
        nixosConfigurations =
          lib.attrsets.mergeAttrsList
          (lib.lists.forEach (builtins.attrNames
            (haumea.lib.load {
              src = ./flake-parts/systems;
              loader = haumea.lib.loaders.verbatim;
            })) (system:
            haumea.lib.load {
              src = ./flake-parts/systems/${system};
              inputs = {inherit inputs lib;};
            }));
      };
    });
}
