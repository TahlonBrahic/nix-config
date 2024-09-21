{ vars, ... }:

{
  users.mutableUsers = false;

  users.groups = {
    # Enter future variable username ${vars.username} = {};
    docker = {};
  };

  users.users."${vars.username}" = {
    inherit (vars) initialHashedPassword;
    home = "/home/${vars.username}";
    isNormalUser = true;
    extraGroups = [
      vars.username
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  users.users.root = {
    initialHashedPassword = config.users.users."${vars.username}".initialHashedPassword;
    # add future open ssh keys
  };
}
