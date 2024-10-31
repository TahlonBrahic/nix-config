{
  inputs,
  hostName,
  user,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  config = {
    sops = {
      age = {
        keyfile = "/home/${user}/.config/sops/age/keys.txt";
      };
      defaultSopsFile = .config/secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      # Define SSH key storage per user and per hostname
      secrets = {
        "${user}" = {
          owner = "${user}";
        };

        # Storing root SSH keys dynamically based on hostname for remote deployment
        keys."${hostName}".ssh."${user}" = {
          owner = "${user}";
        };
      };
    };
  };
}
