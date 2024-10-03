{ config, vars, ... }:

{
  users.mutableUsers = false;

  users.users."${vars.username}" = {
    initialPassword = "p";
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

  # Used for remote deployment, needs to be sent to another module
  #users.users.root = {
  #  initialHashedPassword = config.users.users."${vars.username}".initialHashedPassword;
  #};
}
