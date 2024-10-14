{vars, ...}: {
  users.mutableUsers = false;

  users.users."${vars.username}" = {
    home = "/home/${vars.username}";
    inherit (vars) initialHashedPassword;
    isNormalUser = true;
    inherit (vars) shell;
    extraGroups = [
      "${vars.username}"
      "users"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];
  };
}
