{
  lib,
  haumea,
  ...
}:
# Credit to EmergentMind
{
  relativeToRoot = lib.path.append ../.;
  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
            (_type == "directory")
            || (
              (path != "default.nix")
              && (lib.strings.hasSuffix ".nix" path)
            )
        ) (builtins.readDir path)
      )
    );

  systemTemplate = import ./systemTemplate.nix;
  modulesRoot = import ./modulesRoot.nix {inherit haumea;};
  varsRoot = import ./varsRoot.nix {inherit haumea;};
  baseNixosModules = import ./baseNixosModules.nix {inherit haumea;};
  baseHomeModules = import ./baseHomeModules.nix {inherit haumea;};
}
