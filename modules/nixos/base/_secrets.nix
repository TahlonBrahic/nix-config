{
  config,
  vars,
  customVars,
  ...
}: let
  hostname = config.networking.hostName;
in
imports = [inputs.sops-nix.nixosModules.sops];

config = {
  sops = {
    age = {
      keyfile = "/home/${customVars.username}/.config/sops/age/keys.txt";
    };
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Define SSH key storage per user and per hostname
    secrets = {
      "${vars.username}" = {
        owner = config.users.users.${customVars.username};
      };

      # Storing root SSH keys dynamically based on hostname for remote deployment
      #keys."${hostname}".ssh."${username}" = {
      #  owner = config.users.users.${username};
      #};
    };
  };
}
