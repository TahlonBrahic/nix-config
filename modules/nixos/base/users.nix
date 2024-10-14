{vars, ...}: {
  users.mutableUsers = false;

  users.users."${vars.username}" = {
    initialPassword = "p";
    home = "/home/${vars.username}";
    isNormalUser = true;
    inherit (vars) shell;
    extraGroups = [
      vars.username
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };
}
