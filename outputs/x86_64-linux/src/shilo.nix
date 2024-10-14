{
  inputs,
  lib,
  customLib,
  vars,
  system,
  ...
<<<<<<< HEAD
} @ customArgs: let
  inherit (inputs) sops-nix nix-index-database nixos-wsl;
||||||| parent of 690d323 (Further debugging)
} @ args: let
  inherit (inputs) sops-nix nix-index-database nixos-wsl;
=======
} @ customArgs: let
  inherit (inputs) chaotic sops-nix nvchad4nix nur nix-index-database nixos-wsl;
>>>>>>> 690d323 (Further debugging)
  inherit (customLib) modulesRoot systemTemplate;

  nixModules = with modulesRoot.nixos.opt; [
    wsl
    fhs
  ];

  homeModules = with modulesRoot.home.opt; [
    encryption
    fetch
    zellij
    wsl
  ];

  customModules = {
    nixos =
      [
        sops-nix.nixosModules.sops
        nix-index-database.nixosModules.nix-index
        nixos-wsl.nixoModules.default
        nur.nixosModules.nur
        chaotic.nixosModules.default
      ]
      ++ nixModules;
    home = [ nvchad4nix.homeManagerModule ] ++  homeModules;
  };

<<<<<<< HEAD
  customVars = args.lib.seqTrace args vars.users.tbrahic;
||||||| parent of 690d323 (Further debugging)
  outputVars = args.lib.seqTrace args vars.users.tbrahic;
=======
  outputVars = vars.users.tbrahic;
>>>>>>> 690d323 (Further debugging)
in {
  nixosConfigurations = {
    "shilo" = systemTemplate {
<<<<<<< HEAD
      inherit customArgs customModules customVars;
||||||| parent of 690d323 (Further debugging)
      inherit args modules;
      vars = outputVars;
=======
      inherit customArgs modules outputVars;
>>>>>>> 690d323 (Further debugging)
    };
  };
}
