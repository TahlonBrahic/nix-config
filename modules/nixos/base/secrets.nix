{ pkgs, inputs, ...}:

{
  imports = 
    [
      inputs.sops-nix.nixosModules.sops
    ];

  sops =
  {
    age = 
    {
      keyfile = "/home/user/{$}/.config/sops/age/keys.txt"; #edit this line later
    };
    defaultSopsFile = ; # to be determined
    defaultSopsFormat = "yaml";
    secrets.${} = { # I need to edit this variable with wherever I am going to put the file
      owner = config.users.users. # edit this line later 
    }
  };
}
